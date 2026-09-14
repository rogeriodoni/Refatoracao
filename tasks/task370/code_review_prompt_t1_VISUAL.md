# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 197: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 220: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 243: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 266: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 289: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 331: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 422: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 445: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCLC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2788 linhas total):

*-- Linhas 68 a 77:
68:             ELSE
69:                 THIS.ConfigurarPageFrame()
70: 
71:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
72:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
73: 
74:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
75:                     THIS.CarregarLista()
76:                 ENDIF
77: 

*-- Linhas 97 a 114:
97: 
98:         WITH loc_oPgf
99:             .PageCount       = 2
100:             .Top             = -29
101:             .Left            = 0
102:             .Width           = THIS.Width
103:             .Height          = THIS.Height + 29
104:             .Tabs            = .F.
105:             .Visible         = .T.
106:             .Page1.Caption   = "Lista"
107:             .Page1.BackColor = RGB(100, 100, 100)
108:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:             .Page2.Caption   = "Dados"
110:             .Page2.BackColor = RGB(100, 100, 100)
111:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:         ENDWITH
113: 
114:         THIS.ConfigurarPaginaLista()

*-- Linhas 128 a 166:
128:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
129:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
130:         WITH loc_oCab
131:             .Top         = 31
132:             .Left        = 0
133:             .Width       = THIS.Width
134:             .Height      = 80
135:             .BackColor   = RGB(100, 100, 100)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
141:         WITH loc_oCab.lbl_4c_Sombra
142:             .AutoSize  = .F.
143:             .Caption   = THIS.Caption
144:             .Top       = 15
145:             .Left      = 10
146:             .Width     = THIS.Width
147:             .Height    = 40
148:             .FontName  = "Tahoma"
149:             .FontSize  = 16
150:             .FontBold  = .T.
151:             .ForeColor = RGB(0, 0, 0)
152:             .BackStyle = 0
153:             .Visible   = .T.
154:         ENDWITH
155: 
156:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
157:         WITH loc_oCab.lbl_4c_Titulo
158:             .AutoSize  = .F.
159:             .Caption   = THIS.Caption
160:             .Top       = 18
161:             .Left      = 10
162:             .Width     = THIS.Width
163:             .Height    = 46
164:             .FontName  = "Tahoma"
165:             .FontSize  = 16
166:             .FontBold  = .T.

*-- Linhas 173 a 357:
173:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
174:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
175:         WITH loc_oBotoes
176:             .Top         = 29
177:             .Left        = 542
178:             .Width       = 390
179:             .Height      = 85
180:             .BackColor   = RGB(53, 53, 53)
181:             .BackStyle   = 1
182:             .BorderWidth = 0
183:             .Visible     = .T.
184:         ENDWITH
185: 
186:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
187:         WITH loc_oBotoes.cmd_4c_Incluir
188:             .Caption         = "Incluir"
189:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
190:             .PicturePosition = 13
191:             .Top             = 5
192:             .Left            = 5
193:             .Width           = 75
194:             .Height          = 75
195:             .BackColor       = RGB(255, 255, 255)
196:             .ForeColor       = RGB(90, 90, 90)
197:             .FontName        = "Comic Sans MS"
198:             .FontSize        = 8
199:             .FontBold        = .T.
200:             .FontItalic      = .T.
201:             .Themes          = .F.
202:             .SpecialEffect   = 0
203:             .MousePointer    = 15
204:             .WordWrap        = .T.
205:             .AutoSize        = .F.
206:             .Visible         = .T.
207:         ENDWITH
208: 
209:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
210:         WITH loc_oBotoes.cmd_4c_Visualizar
211:             .Caption         = "Visualizar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
213:             .PicturePosition = 13
214:             .Top             = 5
215:             .Left            = 80
216:             .Width           = 75
217:             .Height          = 75
218:             .BackColor       = RGB(255, 255, 255)
219:             .ForeColor       = RGB(90, 90, 90)
220:             .FontName        = "Comic Sans MS"
221:             .FontSize        = 8
222:             .FontBold        = .T.
223:             .FontItalic      = .T.
224:             .Themes          = .F.
225:             .SpecialEffect   = 0
226:             .MousePointer    = 15
227:             .WordWrap        = .T.
228:             .AutoSize        = .F.
229:             .Visible         = .T.
230:         ENDWITH
231: 
232:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
233:         WITH loc_oBotoes.cmd_4c_Alterar
234:             .Caption         = "Alterar"
235:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
236:             .PicturePosition = 13
237:             .Top             = 5
238:             .Left            = 155
239:             .Width           = 75
240:             .Height          = 75
241:             .BackColor       = RGB(255, 255, 255)
242:             .ForeColor       = RGB(90, 90, 90)
243:             .FontName        = "Comic Sans MS"
244:             .FontSize        = 8
245:             .FontBold        = .T.
246:             .FontItalic      = .T.
247:             .Themes          = .F.
248:             .SpecialEffect   = 0
249:             .MousePointer    = 15
250:             .WordWrap        = .T.
251:             .AutoSize        = .F.
252:             .Visible         = .T.
253:         ENDWITH
254: 
255:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
256:         WITH loc_oBotoes.cmd_4c_Excluir
257:             .Caption         = "Excluir"
258:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
259:             .PicturePosition = 13
260:             .Top             = 5
261:             .Left            = 230
262:             .Width           = 75
263:             .Height          = 75
264:             .BackColor       = RGB(255, 255, 255)
265:             .ForeColor       = RGB(90, 90, 90)
266:             .FontName        = "Comic Sans MS"
267:             .FontSize        = 8
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .Themes          = .F.
271:             .SpecialEffect   = 0
272:             .MousePointer    = 15
273:             .WordWrap        = .T.
274:             .AutoSize        = .F.
275:             .Visible         = .T.
276:         ENDWITH
277: 
278:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
279:         WITH loc_oBotoes.cmd_4c_Buscar
280:             .Caption         = "Buscar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 305
285:             .Width           = 75
286:             .Height          = 75
287:             .BackColor       = RGB(255, 255, 255)
288:             .ForeColor       = RGB(90, 90, 90)
289:             .FontName        = "Comic Sans MS"
290:             .FontSize        = 8
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .Themes          = .F.
294:             .SpecialEffect   = 0
295:             .MousePointer    = 15
296:             .WordWrap        = .T.
297:             .AutoSize        = .F.
298:             .Visible         = .T.
299:         ENDWITH
300: 
301:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
302:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
303:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
304:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
305:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
306: 
307:         *-- Container Encerrar (canonico: Left=917, Width=90)
308:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
309:         loc_oSaida = loc_oPg1.cnt_4c_Saida
310:         WITH loc_oSaida
311:             .Top         = 29
312:             .Left        = 917
313:             .Width       = 90
314:             .Height      = 85
315:             .BackStyle   = 0
316:             .BorderWidth = 0
317:             .Visible     = .T.
318:         ENDWITH
319: 
320:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
321:         WITH loc_oSaida.cmd_4c_Encerrar
322:             .Caption         = "Encerrar"
323:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
324:             .PicturePosition = 13
325:             .Top             = 5
326:             .Left            = 5
327:             .Width           = 75
328:             .Height          = 75
329:             .BackColor       = RGB(255, 255, 255)
330:             .ForeColor       = RGB(90, 90, 90)
331:             .FontName        = "Comic Sans MS"
332:             .FontSize        = 8
333:             .FontBold        = .T.
334:             .FontItalic      = .T.
335:             .Themes          = .F.
336:             .SpecialEffect   = 0
337:             .MousePointer    = 15
338:             .WordWrap        = .T.
339:             .AutoSize        = .F.
340:             .Visible         = .T.
341:         ENDWITH
342: 
343:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
344: 
345:         *-- Grid Lista (Top=117 = 88+29 compensacao PageFrame)
346:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
347:         loc_oPg1.grd_4c_Lista.ColumnCount = 3
348:         loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
349:         loc_oPg1.grd_4c_Lista.ColumnCount  = 4
350:         WITH loc_oPg1.grd_4c_Lista
351:             .Top                = 117
352:             .Left               = 12
353:             .Width              = 940
354:             .Height             = 500
355:             .FontName           = "Verdana"
356:             .FontSize           = 8
357:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 374 a 385:
374:             .Column2.Width = 70
375:             .Column3.Width = 150
376:             .Column4.Width = 150
377:             .Column1.Header1.Caption = ""
378:             .Column2.Header1.Caption = "Emp"
379:             .Column3.Header1.Caption = "Local"
380:             .Column4.Header1.Caption = "Local"
381:         ENDWITH
382: 
383:         BINDEVENT(loc_oPg1.grd_4c_Lista, "DblClick", THIS, "GridListaDblClick")
384: 
385:         THIS.TornarControlesVisiveis(loc_oPg1)

*-- Linhas 399 a 719:
399:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
400:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
401:         WITH loc_oBotoesAcao
402:             .Top         = 33
403:             .Left        = 842
404:             .Width       = 160
405:             .Height      = 85
406:             .BackStyle   = 0
407:             .BorderWidth = 0
408:             .Visible     = .T.
409:         ENDWITH
410: 
411:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
412:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
413:             .Caption         = "Confirmar"
414:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
415:             .PicturePosition = 13
416:             .Top             = 5
417:             .Left            = 5
418:             .Width           = 75
419:             .Height          = 75
420:             .BackColor       = RGB(255, 255, 255)
421:             .ForeColor       = RGB(90, 90, 90)
422:             .FontName        = "Comic Sans MS"
423:             .FontSize        = 8
424:             .FontBold        = .T.
425:             .FontItalic      = .T.
426:             .Themes          = .F.
427:             .SpecialEffect   = 0
428:             .MousePointer    = 15
429:             .WordWrap        = .T.
430:             .AutoSize        = .F.
431:             .Visible         = .T.
432:         ENDWITH
433: 
434:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
435:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
436:             .Caption         = "Encerrar"
437:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
438:             .PicturePosition = 13
439:             .Top             = 5
440:             .Left            = 80
441:             .Width           = 75
442:             .Height          = 75
443:             .BackColor       = RGB(255, 255, 255)
444:             .ForeColor       = RGB(90, 90, 90)
445:             .FontName        = "Comic Sans MS"
446:             .FontSize        = 8
447:             .FontBold        = .T.
448:             .FontItalic      = .T.
449:             .Themes          = .F.
450:             .SpecialEffect   = 0
451:             .MousePointer    = 15
452:             .WordWrap        = .T.
453:             .AutoSize        = .F.
454:             .Visible         = .T.
455:         ENDWITH
456: 
457:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
458:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
459: 
460:         *==========================================================================
461:         *-- FASE 5: cnt_4c_Codigos (top=138, left=25, width=740, height=59)
462:         *==========================================================================
463:         loc_oPg2.AddObject("cnt_4c_Codigos", "Container")
464:         loc_oCnt = loc_oPg2.cnt_4c_Codigos
465:         WITH loc_oCnt
466:             .Top         = 138
467:             .Left        = 25
468:             .Width       = 740
469:             .Height      = 59
470:             .BackStyle   = 0
471:             .BorderWidth = 0
472:             .Visible     = .T.
473:         ENDWITH
474: 
475:         loc_oCnt.AddObject("lbl_4c_LblCodigo", "Label")
476:         WITH loc_oCnt.lbl_4c_LblCodigo
477:             .AutoSize  = .F.
478:             .Caption   = "C" + CHR(243) + "digo :"
479:             .Top       = 9
480:             .Left      = 32
481:             .Width     = 50
482:             .Height    = 15
483:             .FontName  = "Tahoma"
484:             .FontSize  = 8
485:             .BackStyle = 0
486:             .Visible   = .T.
487:         ENDWITH
488: 
489:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
490:         WITH loc_oCnt.txt_4c_Codigos
491:             .Top       = 6
492:             .Left      = 84
493:             .Width     = 150
494:             .Height    = 23
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .Visible   = .T.
498:         ENDWITH
499: 
500:         loc_oCnt.AddObject("lbl_4c_LblEmpresa", "Label")
501:         WITH loc_oCnt.lbl_4c_LblEmpresa
502:             .AutoSize  = .F.
503:             .Caption   = "Empresa :"
504:             .Top       = 9
505:             .Left      = 264
506:             .Width     = 60
507:             .Height    = 15
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .BackStyle = 0
511:             .Visible   = .T.
512:         ENDWITH
513: 
514:         loc_oCnt.AddObject("txt_4c_Empresas", "TextBox")
515:         WITH loc_oCnt.txt_4c_Empresas
516:             .Top       = 6
517:             .Left      = 326
518:             .Width     = 31
519:             .Height    = 23
520:             .MaxLength = 3
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8
523:             .Visible   = .T.
524:         ENDWITH
525: 
526:         loc_oCnt.AddObject("chk_4c_EmpContas", "CheckBox")
527:         WITH loc_oCnt.chk_4c_EmpContas
528:             .Caption  = ""
529:             .Top      = 10
530:             .Left     = 364
531:             .Width    = 19
532:             .Height   = 15
533:             .FontName = "Tahoma"
534:             .FontSize = 8
535:             .Value    = 0
536:             .Visible  = .T.
537:         ENDWITH
538: 
539:         loc_oCnt.AddObject("lbl_4c_LblSubstContas", "Label")
540:         WITH loc_oCnt.lbl_4c_LblSubstContas
541:             .AutoSize  = .F.
542:             .Caption   = "Substituir Contas"
543:             .Top       = 11
544:             .Left      = 381
545:             .Width     = 95
546:             .Height    = 15
547:             .FontName  = "Tahoma"
548:             .FontSize  = 8
549:             .BackStyle = 0
550:             .Visible   = .T.
551:         ENDWITH
552: 
553:         loc_oCnt.AddObject("lbl_4c_LblDigitos", "Label")
554:         WITH loc_oCnt.lbl_4c_LblDigitos
555:             .AutoSize  = .F.
556:             .Caption   = "D" + CHR(237) + "gitos / Grupo :"
557:             .Top       = 10
558:             .Left      = 546
559:             .Width     = 90
560:             .Height    = 15
561:             .FontName  = "Tahoma"
562:             .FontSize  = 8
563:             .BackStyle = 0
564:             .Visible   = .T.
565:         ENDWITH
566: 
567:         loc_oCnt.AddObject("obj_4c_OptDigitos", "OptionGroup")
568:         WITH loc_oCnt.obj_4c_OptDigitos
569:             .ButtonCount = 3
570:             .Top         = 6
571:             .Left        = 642
572:             .Width       = 97
573:             .Height      = 22
574:             .Value       = 1
575:             .BackStyle   = 0
576:             .Visible     = .T.
577:             WITH .Buttons(1)
578:                 .Caption  = "1"
579:                 .Top      = 2
580:                 .Left     = 1
581:                 .Width    = 30
582:                 .Height   = 18
583:             ENDWITH
584:             WITH .Buttons(2)
585:                 .Caption  = "2"
586:                 .Top      = 2
587:                 .Left     = 32
588:                 .Width    = 30
589:                 .Height   = 18
590:                 .FontName = "Tahoma"
591:                 .FontSize = 8
592:             ENDWITH
593:             WITH .Buttons(3)
594:                 .Caption  = "3"
595:                 .Top      = 2
596:                 .Left     = 63
597:                 .Width    = 30
598:                 .Height   = 18
599:                 .FontName = "Tahoma"
600:                 .FontSize = 8
601:             ENDWITH
602:         ENDWITH
603: 
604:         loc_oCnt.AddObject("lbl_4c_LblAuto", "Label")
605:         WITH loc_oCnt.lbl_4c_LblAuto
606:             .AutoSize  = .F.
607:             .Caption   = "Autom" + CHR(225) + "tico :"
608:             .Top       = 35
609:             .Left      = 8
610:             .Width     = 70
611:             .Height    = 15
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .BackStyle = 0
615:             .Visible   = .T.
616:         ENDWITH
617: 
618:         loc_oCnt.AddObject("chk_4c_Autos", "CheckBox")
619:         WITH loc_oCnt.chk_4c_Autos
620:             .Caption  = ""
621:             .Top      = 35
622:             .Left     = 84
623:             .Width    = 19
624:             .Height   = 15
625:             .FontName = "Tahoma"
626:             .FontSize = 8
627:             .Value    = 0
628:             .Visible  = .T.
629:         ENDWITH
630: 
631:         loc_oCnt.AddObject("lbl_4c_LblProcessamento", "Label")
632:         WITH loc_oCnt.lbl_4c_LblProcessamento
633:             .AutoSize  = .F.
634:             .Caption   = "(Processamento)"
635:             .Top       = 35
636:             .Left      = 104
637:             .Width     = 95
638:             .Height    = 15
639:             .FontName  = "Tahoma"
640:             .FontSize  = 8
641:             .BackStyle = 0
642:             .Visible   = .T.
643:         ENDWITH
644: 
645:         loc_oCnt.AddObject("lbl_4c_LblTransitoria", "Label")
646:         WITH loc_oCnt.lbl_4c_LblTransitoria
647:             .AutoSize  = .F.
648:             .Caption   = "Transit" + CHR(243) + "ria :"
649:             .Top       = 34
650:             .Left      = 253
651:             .Width     = 70
652:             .Height    = 15
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .BackStyle = 0
656:             .Visible   = .T.
657:         ENDWITH
658: 
659:         loc_oCnt.AddObject("txt_4c_Transitoria", "TextBox")
660:         WITH loc_oCnt.txt_4c_Transitoria
661:             .Top       = 31
662:             .Left      = 326
663:             .Width     = 31
664:             .Height    = 23
665:             .MaxLength = 3
666:             .FontName  = "Tahoma"
667:             .FontSize  = 8
668:             .Visible   = .T.
669:         ENDWITH
670: 
671:         loc_oCnt.AddObject("lbl_4c_LblToleras", "Label")
672:         WITH loc_oCnt.lbl_4c_LblToleras
673:             .AutoSize  = .F.
674:             .Caption   = "Toler" + CHR(226) + "ncia AU :"
675:             .Top       = 34
676:             .Left      = 401
677:             .Width     = 90
678:             .Height    = 15
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .BackStyle = 0
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         loc_oCnt.AddObject("txt_4c_Toleras", "TextBox")
686:         WITH loc_oCnt.txt_4c_Toleras
687:             .Top       = 30
688:             .Left      = 491
689:             .Width     = 55
690:             .Height    = 25
691:             .Value     = 0
692:             .FontName  = "Tahoma"
693:             .FontSize  = 8
694:             .Visible   = .T.
695:         ENDWITH
696: 
697:         loc_oCnt.AddObject("lbl_4c_LblPercents", "Label")
698:         WITH loc_oCnt.lbl_4c_LblPercents
699:             .AutoSize  = .F.
700:             .Caption   = "Percentual :"
701:             .Top       = 34
702:             .Left      = 599
703:             .Width     = 71
704:             .Height    = 15
705:             .FontName  = "Tahoma"
706:             .FontSize  = 8
707:             .BackStyle = 0
708:             .Visible   = .T.
709:         ENDWITH
710: 
711:         loc_oCnt.AddObject("txt_4c_Percents", "TextBox")
712:         WITH loc_oCnt.txt_4c_Percents
713:             .Top       = 30
714:             .Left      = 672
715:             .Width     = 59
716:             .Height    = 25
717:             .Value     = 0
718:             .FontName  = "Tahoma"
719:             .FontSize  = 8

*-- Linhas 726 a 977:
726:         loc_oPg2.AddObject("cnt_4c_LocalA", "Container")
727:         loc_oCnt = loc_oPg2.cnt_4c_LocalA
728:         WITH loc_oCnt
729:             .Top         = 201
730:             .Left        = 25
731:             .Width       = 368
732:             .Height      = 133
733:             .BackStyle   = 0
734:             .BorderWidth = 0
735:             .Visible     = .T.
736:         ENDWITH
737: 
738:         loc_oCnt.AddObject("lbl_4c_TituloA", "Label")
739:         WITH loc_oCnt.lbl_4c_TituloA
740:             .AutoSize  = .F.
741:             .Caption   = " Local " + CHR(34) + "A" + CHR(34)
742:             .Top       = 4
743:             .Left      = 3
744:             .Width     = 62
745:             .Height    = 15
746:             .FontName  = "Tahoma"
747:             .FontSize  = 8
748:             .FontBold  = .T.
749:             .BackStyle = 0
750:             .Visible   = .T.
751:         ENDWITH
752: 
753:         loc_oCnt.AddObject("chk_4c_PalmA", "CheckBox")
754:         WITH loc_oCnt.chk_4c_PalmA
755:             .Caption  = "Checar Venda Palm"
756:             .Top      = 4
757:             .Left     = 153
758:             .Width    = 120
759:             .Height   = 17
760:             .FontName = "Tahoma"
761:             .FontSize = 8
762:             .Value    = 0
763:             .Visible  = .T.
764:         ENDWITH
765: 
766:         loc_oCnt.AddObject("chk_4c_EtiquetaA", "CheckBox")
767:         WITH loc_oCnt.chk_4c_EtiquetaA
768:             .Caption  = "Etiquetas"
769:             .Top      = 3
770:             .Left     = 290
771:             .Width    = 75
772:             .Height   = 17
773:             .FontName = "Tahoma"
774:             .FontSize = 8
775:             .Value    = 0
776:             .Visible  = .T.
777:         ENDWITH
778: 
779:         loc_oCnt.AddObject("lbl_4c_LblLocalA", "Label")
780:         WITH loc_oCnt.lbl_4c_LblLocalA
781:             .AutoSize  = .F.
782:             .Caption   = "Local :"
783:             .Top       = 28
784:             .Left      = 26
785:             .Width     = 40
786:             .Height    = 15
787:             .FontName  = "Tahoma"
788:             .FontSize  = 8
789:             .BackStyle = 0
790:             .Visible   = .T.
791:         ENDWITH
792: 
793:         loc_oCnt.AddObject("txt_4c_LocalA", "TextBox")
794:         WITH loc_oCnt.txt_4c_LocalA
795:             .Top       = 25
796:             .Left      = 66
797:             .Width     = 80
798:             .Height    = 23
799:             .FontName  = "Tahoma"
800:             .FontSize  = 8
801:             .Visible   = .T.
802:         ENDWITH
803: 
804:         loc_oCnt.AddObject("lbl_4c_LblEstoqueA", "Label")
805:         WITH loc_oCnt.lbl_4c_LblEstoqueA
806:             .AutoSize  = .F.
807:             .Caption   = "Estoque :"
808:             .Top       = 28
809:             .Left      = 150
810:             .Width     = 56
811:             .Height    = 15
812:             .FontName  = "Tahoma"
813:             .FontSize  = 8
814:             .BackStyle = 0
815:             .Visible   = .T.
816:         ENDWITH
817: 
818:         loc_oCnt.AddObject("txt_4c_DataA", "TextBox")
819:         WITH loc_oCnt.txt_4c_DataA
820:             .Top       = 24
821:             .Left      = 205
822:             .Width     = 80
823:             .Height    = 25
824:             .FontName  = "Tahoma"
825:             .FontSize  = 8
826:             .InputMask = "99/99/9999"
827:             .Visible   = .T.
828:         ENDWITH
829: 
830:         loc_oCnt.AddObject("lbl_4c_LblDivisaoA", "Label")
831:         WITH loc_oCnt.lbl_4c_LblDivisaoA
832:             .AutoSize  = .F.
833:             .Caption   = "Divis" + CHR(227) + "o :"
834:             .Top       = 28
835:             .Left      = 285
836:             .Width     = 53
837:             .Height    = 15
838:             .FontName  = "Tahoma"
839:             .FontSize  = 8
840:             .BackStyle = 0
841:             .Visible   = .T.
842:         ENDWITH
843: 
844:         loc_oCnt.AddObject("txt_4c_DivisaosA", "TextBox")
845:         WITH loc_oCnt.txt_4c_DivisaosA
846:             .Top       = 25
847:             .Left      = 337
848:             .Width     = 24
849:             .Height    = 23
850:             .Value     = 0
851:             .FontName  = "Tahoma"
852:             .FontSize  = 8
853:             .Visible   = .T.
854:         ENDWITH
855: 
856:         loc_oCnt.AddObject("lbl_4c_LblGrupoA", "Label")
857:         WITH loc_oCnt.lbl_4c_LblGrupoA
858:             .AutoSize  = .F.
859:             .Caption   = "Grupo :"
860:             .Top       = 53
861:             .Left      = 22
862:             .Width     = 46
863:             .Height    = 15
864:             .FontName  = "Tahoma"
865:             .FontSize  = 8
866:             .BackStyle = 0
867:             .Visible   = .T.
868:         ENDWITH
869: 
870:         loc_oCnt.AddObject("txt_4c_GrupoA", "TextBox")
871:         WITH loc_oCnt.txt_4c_GrupoA
872:             .Top       = 50
873:             .Left      = 66
874:             .Width     = 80
875:             .Height    = 23
876:             .FontName  = "Tahoma"
877:             .FontSize  = 8
878:             .Visible   = .T.
879:         ENDWITH
880: 
881:         loc_oCnt.AddObject("txt_4c_DGrupoA", "TextBox")
882:         WITH loc_oCnt.txt_4c_DGrupoA
883:             .Top       = 50
884:             .Left      = 148
885:             .Width     = 213
886:             .Height    = 23
887:             .FontName  = "Tahoma"
888:             .FontSize  = 8
889:             .ReadOnly  = .T.
890:             .Visible   = .T.
891:         ENDWITH
892: 
893:         loc_oCnt.AddObject("lbl_4c_LblContaA", "Label")
894:         WITH loc_oCnt.lbl_4c_LblContaA
895:             .AutoSize  = .F.
896:             .Caption   = "Conta :"
897:             .Top       = 78
898:             .Left      = 23
899:             .Width     = 45
900:             .Height    = 15
901:             .FontName  = "Tahoma"
902:             .FontSize  = 8
903:             .BackStyle = 0
904:             .Visible   = .T.
905:         ENDWITH
906: 
907:         loc_oCnt.AddObject("txt_4c_ContaA", "TextBox")
908:         WITH loc_oCnt.txt_4c_ContaA
909:             .Top       = 75
910:             .Left      = 66
911:             .Width     = 80
912:             .Height    = 23
913:             .FontName  = "Tahoma"
914:             .FontSize  = 8
915:             .Visible   = .T.
916:         ENDWITH
917: 
918:         loc_oCnt.AddObject("txt_4c_DContaA", "TextBox")
919:         WITH loc_oCnt.txt_4c_DContaA
920:             .Top       = 75
921:             .Left      = 148
922:             .Width     = 213
923:             .Height    = 23
924:             .FontName  = "Tahoma"
925:             .FontSize  = 8
926:             .ReadOnly  = .T.
927:             .Visible   = .T.
928:         ENDWITH
929: 
930:         loc_oCnt.AddObject("lbl_4c_LblOperacaoA", "Label")
931:         WITH loc_oCnt.lbl_4c_LblOperacaoA
932:             .AutoSize  = .F.
933:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
934:             .Top       = 104
935:             .Left      = 2
936:             .Width     = 66
937:             .Height    = 15
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .BackStyle = 0
941:             .Visible   = .T.
942:         ENDWITH
943: 
944:         loc_oCnt.AddObject("txt_4c_OperacaoA", "TextBox")
945:         WITH loc_oCnt.txt_4c_OperacaoA
946:             .Top       = 100
947:             .Left      = 66
948:             .Width     = 150
949:             .Height    = 23
950:             .FontName  = "Tahoma"
951:             .FontSize  = 8
952:             .Visible   = .T.
953:         ENDWITH
954: 
955:         loc_oCnt.AddObject("lbl_4c_LblGdeGrupoA", "Label")
956:         WITH loc_oCnt.lbl_4c_LblGdeGrupoA
957:             .AutoSize  = .F.
958:             .Caption   = "Grande Grupo :"
959:             .Top       = 104
960:             .Left      = 236
961:             .Width     = 92
962:             .Height    = 15
963:             .FontName  = "Tahoma"
964:             .FontSize  = 8
965:             .BackStyle = 0
966:             .Visible   = .T.
967:         ENDWITH
968: 
969:         loc_oCnt.AddObject("txt_4c_GdeGrupoA", "TextBox")
970:         WITH loc_oCnt.txt_4c_GdeGrupoA
971:             .Top       = 100
972:             .Left      = 329
973:             .Width     = 31
974:             .Height    = 23
975:             .FontName  = "Tahoma"
976:             .FontSize  = 8
977:             .Visible   = .T.

*-- Linhas 983 a 1234:
983:         loc_oPg2.AddObject("cnt_4c_LocalB", "Container")
984:         loc_oCnt = loc_oPg2.cnt_4c_LocalB
985:         WITH loc_oCnt
986:             .Top         = 201
987:             .Left        = 397
988:             .Width       = 368
989:             .Height      = 133
990:             .BackStyle   = 0
991:             .BorderWidth = 0
992:             .Visible     = .T.
993:         ENDWITH
994: 
995:         loc_oCnt.AddObject("lbl_4c_TituloB", "Label")
996:         WITH loc_oCnt.lbl_4c_TituloB
997:             .AutoSize  = .F.
998:             .Caption   = " Local " + CHR(34) + "B" + CHR(34)
999:             .Top       = 4
1000:             .Left      = 3
1001:             .Width     = 62
1002:             .Height    = 15
1003:             .FontName  = "Tahoma"
1004:             .FontSize  = 8
1005:             .FontBold  = .T.
1006:             .BackStyle = 0
1007:             .Visible   = .T.
1008:         ENDWITH
1009: 
1010:         loc_oCnt.AddObject("chk_4c_PalmB", "CheckBox")
1011:         WITH loc_oCnt.chk_4c_PalmB
1012:             .Caption  = "Checar Venda Palm"
1013:             .Top      = 5
1014:             .Left     = 153
1015:             .Width    = 120
1016:             .Height   = 17
1017:             .FontName = "Tahoma"
1018:             .FontSize = 8
1019:             .Value    = 0
1020:             .Visible  = .T.
1021:         ENDWITH
1022: 
1023:         loc_oCnt.AddObject("chk_4c_EtiquetaB", "CheckBox")
1024:         WITH loc_oCnt.chk_4c_EtiquetaB
1025:             .Caption  = "Etiquetas"
1026:             .Top      = 4
1027:             .Left     = 290
1028:             .Width    = 75
1029:             .Height   = 17
1030:             .FontName = "Tahoma"
1031:             .FontSize = 8
1032:             .Value    = 0
1033:             .Visible  = .T.
1034:         ENDWITH
1035: 
1036:         loc_oCnt.AddObject("lbl_4c_LblLocalB", "Label")
1037:         WITH loc_oCnt.lbl_4c_LblLocalB
1038:             .AutoSize  = .F.
1039:             .Caption   = "Local :"
1040:             .Top       = 29
1041:             .Left      = 26
1042:             .Width     = 40
1043:             .Height    = 15
1044:             .FontName  = "Tahoma"
1045:             .FontSize  = 8
1046:             .BackStyle = 0
1047:             .Visible   = .T.
1048:         ENDWITH
1049: 
1050:         loc_oCnt.AddObject("txt_4c_LocalB", "TextBox")
1051:         WITH loc_oCnt.txt_4c_LocalB
1052:             .Top       = 26
1053:             .Left      = 66
1054:             .Width     = 80
1055:             .Height    = 23
1056:             .FontName  = "Tahoma"
1057:             .FontSize  = 8
1058:             .Visible   = .T.
1059:         ENDWITH
1060: 
1061:         loc_oCnt.AddObject("lbl_4c_LblEstoqueB", "Label")
1062:         WITH loc_oCnt.lbl_4c_LblEstoqueB
1063:             .AutoSize  = .F.
1064:             .Caption   = "Estoque :"
1065:             .Top       = 28
1066:             .Left      = 150
1067:             .Width     = 56
1068:             .Height    = 15
1069:             .FontName  = "Tahoma"
1070:             .FontSize  = 8
1071:             .BackStyle = 0
1072:             .Visible   = .T.
1073:         ENDWITH
1074: 
1075:         loc_oCnt.AddObject("txt_4c_DataB", "TextBox")
1076:         WITH loc_oCnt.txt_4c_DataB
1077:             .Top       = 24
1078:             .Left      = 205
1079:             .Width     = 80
1080:             .Height    = 25
1081:             .FontName  = "Tahoma"
1082:             .FontSize  = 8
1083:             .InputMask = "99/99/9999"
1084:             .Visible   = .T.
1085:         ENDWITH
1086: 
1087:         loc_oCnt.AddObject("lbl_4c_LblDivisaoB", "Label")
1088:         WITH loc_oCnt.lbl_4c_LblDivisaoB
1089:             .AutoSize  = .F.
1090:             .Caption   = "Divis" + CHR(227) + "o :"
1091:             .Top       = 28
1092:             .Left      = 286
1093:             .Width     = 53
1094:             .Height    = 15
1095:             .FontName  = "Tahoma"
1096:             .FontSize  = 8
1097:             .BackStyle = 0
1098:             .Visible   = .T.
1099:         ENDWITH
1100: 
1101:         loc_oCnt.AddObject("txt_4c_DivisaosB", "TextBox")
1102:         WITH loc_oCnt.txt_4c_DivisaosB
1103:             .Top       = 25
1104:             .Left      = 337
1105:             .Width     = 24
1106:             .Height    = 23
1107:             .Value     = 0
1108:             .FontName  = "Tahoma"
1109:             .FontSize  = 8
1110:             .Visible   = .T.
1111:         ENDWITH
1112: 
1113:         loc_oCnt.AddObject("lbl_4c_LblGrupoB", "Label")
1114:         WITH loc_oCnt.lbl_4c_LblGrupoB
1115:             .AutoSize  = .F.
1116:             .Caption   = "Grupo :"
1117:             .Top       = 54
1118:             .Left      = 22
1119:             .Width     = 46
1120:             .Height    = 15
1121:             .FontName  = "Tahoma"
1122:             .FontSize  = 8
1123:             .BackStyle = 0
1124:             .Visible   = .T.
1125:         ENDWITH
1126: 
1127:         loc_oCnt.AddObject("txt_4c_GrupoB", "TextBox")
1128:         WITH loc_oCnt.txt_4c_GrupoB
1129:             .Top       = 51
1130:             .Left      = 66
1131:             .Width     = 80
1132:             .Height    = 23
1133:             .FontName  = "Tahoma"
1134:             .FontSize  = 8
1135:             .Visible   = .T.
1136:         ENDWITH
1137: 
1138:         loc_oCnt.AddObject("txt_4c_DGrupoB", "TextBox")
1139:         WITH loc_oCnt.txt_4c_DGrupoB
1140:             .Top       = 51
1141:             .Left      = 148
1142:             .Width     = 213
1143:             .Height    = 23
1144:             .FontName  = "Tahoma"
1145:             .FontSize  = 8
1146:             .ReadOnly  = .T.
1147:             .Visible   = .T.
1148:         ENDWITH
1149: 
1150:         loc_oCnt.AddObject("lbl_4c_LblContaB", "Label")
1151:         WITH loc_oCnt.lbl_4c_LblContaB
1152:             .AutoSize  = .F.
1153:             .Caption   = "Conta :"
1154:             .Top       = 79
1155:             .Left      = 23
1156:             .Width     = 45
1157:             .Height    = 15
1158:             .FontName  = "Tahoma"
1159:             .FontSize  = 8
1160:             .BackStyle = 0
1161:             .Visible   = .T.
1162:         ENDWITH
1163: 
1164:         loc_oCnt.AddObject("txt_4c_ContaB", "TextBox")
1165:         WITH loc_oCnt.txt_4c_ContaB
1166:             .Top       = 76
1167:             .Left      = 66
1168:             .Width     = 80
1169:             .Height    = 23
1170:             .FontName  = "Tahoma"
1171:             .FontSize  = 8
1172:             .Visible   = .T.
1173:         ENDWITH
1174: 
1175:         loc_oCnt.AddObject("txt_4c_DContaB", "TextBox")
1176:         WITH loc_oCnt.txt_4c_DContaB
1177:             .Top       = 76
1178:             .Left      = 148
1179:             .Width     = 213
1180:             .Height    = 23
1181:             .FontName  = "Tahoma"
1182:             .FontSize  = 8
1183:             .ReadOnly  = .T.
1184:             .Visible   = .T.
1185:         ENDWITH
1186: 
1187:         loc_oCnt.AddObject("lbl_4c_LblOperacaoB", "Label")
1188:         WITH loc_oCnt.lbl_4c_LblOperacaoB
1189:             .AutoSize  = .F.
1190:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
1191:             .Top       = 105
1192:             .Left      = 2
1193:             .Width     = 66
1194:             .Height    = 15
1195:             .FontName  = "Tahoma"
1196:             .FontSize  = 8
1197:             .BackStyle = 0
1198:             .Visible   = .T.
1199:         ENDWITH
1200: 
1201:         loc_oCnt.AddObject("txt_4c_OperacaoB", "TextBox")
1202:         WITH loc_oCnt.txt_4c_OperacaoB
1203:             .Top       = 101
1204:             .Left      = 66
1205:             .Width     = 150
1206:             .Height    = 23
1207:             .FontName  = "Tahoma"
1208:             .FontSize  = 8
1209:             .Visible   = .T.
1210:         ENDWITH
1211: 
1212:         loc_oCnt.AddObject("lbl_4c_LblGdeGrupoB", "Label")
1213:         WITH loc_oCnt.lbl_4c_LblGdeGrupoB
1214:             .AutoSize  = .F.
1215:             .Caption   = "Grande Grupo :"
1216:             .Top       = 104
1217:             .Left      = 239
1218:             .Width     = 92
1219:             .Height    = 15
1220:             .FontName  = "Tahoma"
1221:             .FontSize  = 8
1222:             .BackStyle = 0
1223:             .Visible   = .T.
1224:         ENDWITH
1225: 
1226:         loc_oCnt.AddObject("txt_4c_GdeGrupoB", "TextBox")
1227:         WITH loc_oCnt.txt_4c_GdeGrupoB
1228:             .Top       = 101
1229:             .Left      = 330
1230:             .Width     = 31
1231:             .Height    = 23
1232:             .FontName  = "Tahoma"
1233:             .FontSize  = 8
1234:             .Visible   = .T.

*-- Linhas 1255 a 1286:
1255:         par_oPg2.AddObject("pgf_4c_Complementos", "PageFrame")
1256:         loc_oPgf = par_oPg2.pgf_4c_Complementos
1257:         WITH loc_oPgf
1258:             .Top       = 337
1259:             .Left      = 23
1260:             .Width     = 743
1261:             .Height    = 230
1262:             .PageCount = 2
1263:             .Tabs      = .T.
1264:             .Visible   = .T.
1265:             .Page1.Caption   = "Opera" + CHR(231) + CHR(245) + "es Gerenciais"
1266:             .Page1.BackColor = RGB(240, 240, 240)
1267:             .Page2.Caption   = "Estoques"
1268:             .Page2.BackColor = RGB(240, 240, 240)
1269:         ENDWITH
1270: 
1271:         loc_oPg1C = loc_oPgf.Page1
1272:         loc_oPg2C = loc_oPgf.Page2
1273: 
1274:         *-- Page1: Grid de Operacoes Gerenciais (grdOpeGerA - 8 colunas)
1275:         loc_oPg1C.AddObject("grd_4c_OpeGerA", "Grid")
1276:         loc_oPg1C.grd_4c_OpeGerA.ColumnCount = 3
1277:         loc_oPg1C.grd_4c_OpeGerA.RecordSource = "cursor_4c_Operacoes"
1278:         loc_oPg1C.grd_4c_OpeGerA.ColumnCount  = 8
1279:         WITH loc_oPg1C.grd_4c_OpeGerA
1280:             .Top                = 10
1281:             .Left               = 8
1282:             .Width              = 723
1283:             .Height             = 122
1284:             .FontName           = "Verdana"
1285:             .FontSize           = 8
1286:             .BackColor          = RGB(255, 255, 255)

*-- Linhas 1310 a 1411:
1310:             .Column6.Width = 90
1311:             .Column7.Width = 100
1312:             .Column8.Width = 28
1313:             .Column1.Header1.Caption = "Emp"
1314:             .Column2.Header1.Caption = "Local"
1315:             .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1316:             .Column4.Header1.Caption = "Grupo Origem"
1317:             .Column5.Header1.Caption = "Conta Origem"
1318:             .Column6.Header1.Caption = "Grupo Destino"
1319:             .Column7.Header1.Caption = "Conta Destino"
1320:             .Column8.Header1.Caption = "A"
1321:             .Column8.Sparse   = .F.
1322:             .Column8.ReadOnly = .F.
1323:         ENDWITH
1324: 
1325:         *-- OptionGroup optEnvRecs (direcao de movimentacao A->B ou B->A)
1326:         loc_oPg1C.AddObject("opt_4c_EnvRecs", "OptionGroup")
1327:         WITH loc_oPg1C.opt_4c_EnvRecs
1328:             .ButtonCount = 2
1329:             .Top         = 139
1330:             .Left        = 377
1331:             .Width       = 134
1332:             .Height      = 24
1333:             .Value       = 1
1334:             .BackStyle   = 0
1335:             .Visible     = .T.
1336:         ENDWITH
1337:         WITH loc_oPg1C.opt_4c_EnvRecs.Buttons(1)
1338:             .Caption   = "A -> B"
1339:             .BackStyle = 0
1340:             .Top       = 4
1341:             .Left      = 5
1342:             .Width     = 58
1343:             .Height    = 16
1344:             .FontName  = "Tahoma"
1345:             .FontSize  = 8
1346:             .Themes    = .F.
1347:             .ForeColor = RGB(90, 90, 90)
1348:             .AutoSize  = .T.
1349:         ENDWITH
1350:         WITH loc_oPg1C.opt_4c_EnvRecs.Buttons(2)
1351:             .Caption   = "B -> A"
1352:             .BackStyle = 0
1353:             .Top       = 4
1354:             .Left      = 66
1355:             .Width     = 58
1356:             .Height    = 16
1357:             .FontName  = "Tahoma"
1358:             .FontSize  = 8
1359:             .Themes    = .F.
1360:             .ForeColor = RGB(90, 90, 90)
1361:             .AutoSize  = .T.
1362:         ENDWITH
1363: 
1364:         BINDEVENT(loc_oPg1C.opt_4c_EnvRecs, "InteractiveChange", THIS, "EnvRecsInteractiveChange")
1365: 
1366:         *-- Label "Movimentacao Entre Locais :"
1367:         loc_oPg1C.AddObject("lbl_4c_MovEntreLocais", "Label")
1368:         WITH loc_oPg1C.lbl_4c_MovEntreLocais
1369:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Entre Locais :"
1370:             .AutoSize  = .F.
1371:             .Top       = 141
1372:             .Left      = 187
1373:             .Width     = 185
1374:             .Height    = 15
1375:             .FontName  = "Tahoma"
1376:             .FontSize  = 8
1377:             .BackStyle = 0
1378:             .Visible   = .T.
1379:         ENDWITH
1380: 
1381:         *-- CommandGroup Incluir/Excluir linha
1382:         loc_oPg1C.AddObject("cmdg_4c_Compo", "CommandGroup")
1383:         loc_oCmg = loc_oPg1C.cmdg_4c_Compo
1384:         WITH loc_oCmg
1385:             .Top       = 141
1386:             .Left      = 8
1387:             .Width     = 170
1388:             .Height    = 56
1389:             .BackColor = RGB(255, 255, 255)
1390:             .Visible   = .T.
1391:         ENDWITH
1392:         WITH loc_oCmg.Buttons(1)
1393:             .Caption   = "Incluir Linha"
1394:             .Top       = 2
1395:             .Left      = 2
1396:             .Width     = 80
1397:             .Height    = 26
1398:             .FontName  = "Tahoma"
1399:             .FontSize  = 8
1400:             .BackColor = RGB(255, 255, 255)
1401:             .ForeColor = RGB(90, 90, 90)
1402:         ENDWITH
1403:         WITH loc_oCmg.Buttons(2)
1404:             .Caption   = "Excluir Linha"
1405:             .Top       = 28
1406:             .Left      = 2
1407:             .Width     = 80
1408:             .Height    = 26
1409:             .FontName  = "Tahoma"
1410:             .FontSize  = 8
1411:             .BackColor = RGB(255, 255, 255)

*-- Linhas 1417 a 1430:
1417:         BINDEVENT(loc_oPg1C.grd_4c_OpeGerA, "AfterRowColChange", THIS, "OpeGerAAfterRowColChange")
1418: 
1419:         *-- Page2: Estoques - Label e Grid Local A
1420:         loc_oPg2C.AddObject("lbl_4c_TitLocalAEst", "Label")
1421:         WITH loc_oPg2C.lbl_4c_TitLocalAEst
1422:             .Caption   = " Local " + CHR(34) + "A" + CHR(34)
1423:             .AutoSize  = .F.
1424:             .Top       = 2
1425:             .Left      = 106
1426:             .Width     = 62
1427:             .Height    = 15
1428:             .FontName  = "Tahoma"
1429:             .FontSize  = 8
1430:             .FontBold  = .T.

*-- Linhas 1437 a 1446:
1437:         loc_oPg2C.grd_4c_EstoqueA.RecordSource = "cursor_4c_EstoqueA"
1438:         loc_oPg2C.grd_4c_EstoqueA.ColumnCount  = 4
1439:         WITH loc_oPg2C.grd_4c_EstoqueA
1440:             .Top                = 18
1441:             .Left               = 108
1442:             .Width              = 252
1443:             .Height             = 122
1444:             .FontName           = "Verdana"
1445:             .FontSize           = 8
1446:             .BackColor          = RGB(255, 255, 255)

*-- Linhas 1462 a 1522:
1462:             .Column2.Width = 35
1463:             .Column3.Width = 90
1464:             .Column4.Width = 95
1465:             .Column1.Header1.Caption = ""
1466:             .Column2.Header1.Caption = "Emp"
1467:             .Column3.Header1.Caption = "Grupo"
1468:             .Column4.Header1.Caption = "Conta"
1469:             .Column1.Sparse   = .F.
1470:             .Column1.ReadOnly = .F.
1471:             .Column2.ReadOnly = .T.
1472:             .Column3.ReadOnly = .T.
1473:             .Column4.ReadOnly = .T.
1474:         ENDWITH
1475: 
1476:         loc_oPg2C.AddObject("cmdg_4c_EstoqueA", "CommandGroup")
1477:         loc_oCmg = loc_oPg2C.cmdg_4c_EstoqueA
1478:         WITH loc_oCmg
1479:             .Top       = 142
1480:             .Left      = 108
1481:             .Width     = 90
1482:             .Height    = 33
1483:             .BackColor = RGB(255, 255, 255)
1484:             .Visible   = .T.
1485:         ENDWITH
1486:         WITH loc_oCmg.Buttons(1)
1487:             .Caption   = "Marcar"
1488:             .Top       = 2
1489:             .Left      = 2
1490:             .Width     = 42
1491:             .Height    = 14
1492:             .FontName  = "Tahoma"
1493:             .FontSize  = 7
1494:             .BackColor = RGB(255, 255, 255)
1495:             .ForeColor = RGB(90, 90, 90)
1496:         ENDWITH
1497:         WITH loc_oCmg.Buttons(2)
1498:             .Caption   = "Desmarcar"
1499:             .Top       = 16
1500:             .Left      = 2
1501:             .Width     = 42
1502:             .Height    = 14
1503:             .FontName  = "Tahoma"
1504:             .FontSize  = 7
1505:             .BackColor = RGB(255, 255, 255)
1506:             .ForeColor = RGB(90, 90, 90)
1507:         ENDWITH
1508:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnMarcarTodosAClick")
1509:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnDesmarcarTodosAClick")
1510: 
1511:         *-- Page2: Label e Grid Local B
1512:         loc_oPg2C.AddObject("lbl_4c_TitLocalBEst", "Label")
1513:         WITH loc_oPg2C.lbl_4c_TitLocalBEst
1514:             .Caption   = " Local " + CHR(34) + "B" + CHR(34)
1515:             .AutoSize  = .F.
1516:             .Top       = 2
1517:             .Left      = 378
1518:             .Width     = 62
1519:             .Height    = 15
1520:             .FontName  = "Tahoma"
1521:             .FontSize  = 8
1522:             .FontBold  = .T.

*-- Linhas 1529 a 1538:
1529:         loc_oPg2C.grd_4c_EstoqueB.RecordSource = "cursor_4c_EstoqueB"
1530:         loc_oPg2C.grd_4c_EstoqueB.ColumnCount  = 4
1531:         WITH loc_oPg2C.grd_4c_EstoqueB
1532:             .Top                = 18
1533:             .Left               = 380
1534:             .Width              = 252
1535:             .Height             = 122
1536:             .FontName           = "Verdana"
1537:             .FontSize           = 8
1538:             .BackColor          = RGB(255, 255, 255)

*-- Linhas 1554 a 1597:
1554:             .Column2.Width = 35
1555:             .Column3.Width = 90
1556:             .Column4.Width = 95
1557:             .Column1.Header1.Caption = ""
1558:             .Column2.Header1.Caption = "Emp"
1559:             .Column3.Header1.Caption = "Grupo"
1560:             .Column4.Header1.Caption = "Conta"
1561:             .Column1.Sparse   = .F.
1562:             .Column1.ReadOnly = .F.
1563:             .Column2.ReadOnly = .T.
1564:             .Column3.ReadOnly = .T.
1565:             .Column4.ReadOnly = .T.
1566:         ENDWITH
1567: 
1568:         loc_oPg2C.AddObject("cmdg_4c_EstoqueB", "CommandGroup")
1569:         loc_oCmg = loc_oPg2C.cmdg_4c_EstoqueB
1570:         WITH loc_oCmg
1571:             .Top       = 142
1572:             .Left      = 380
1573:             .Width     = 90
1574:             .Height    = 33
1575:             .BackColor = RGB(255, 255, 255)
1576:             .Visible   = .T.
1577:         ENDWITH
1578:         WITH loc_oCmg.Buttons(1)
1579:             .Caption   = "Marcar"
1580:             .Top       = 2
1581:             .Left      = 2
1582:             .Width     = 42
1583:             .Height    = 14
1584:             .FontName  = "Tahoma"
1585:             .FontSize  = 7
1586:             .BackColor = RGB(255, 255, 255)
1587:             .ForeColor = RGB(90, 90, 90)
1588:         ENDWITH
1589:         WITH loc_oCmg.Buttons(2)
1590:             .Caption   = "Desmarcar"
1591:             .Top       = 16
1592:             .Left      = 2
1593:             .Width     = 42
1594:             .Height    = 14
1595:             .FontName  = "Tahoma"
1596:             .FontSize  = 7
1597:             .BackColor = RGB(255, 255, 255)

*-- Linhas 1669 a 1693:
1669:             loc_oGrid.Column7.Width = 100
1670:             loc_oGrid.Column8.Width = 28
1671: 
1672:             loc_oGrid.Column1.Header1.Caption = "Emp"
1673:             loc_oGrid.Column2.Header1.Caption = "Local"
1674:             loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1675:             loc_oGrid.Column4.Header1.Caption = "Grupo Origem"
1676:             loc_oGrid.Column5.Header1.Caption = "Conta Origem"
1677:             loc_oGrid.Column6.Header1.Caption = "Grupo Destino"
1678:             loc_oGrid.Column7.Header1.Caption = "Conta Destino"
1679:             loc_oGrid.Column8.Header1.Caption = "A"
1680: 
1681:             loc_oGrid.Column8.Sparse   = .F.
1682:             loc_oGrid.Column8.ReadOnly = .F.
1683:             IF PEMSTATUS(loc_oGrid.Column8, "Check1", 5)
1684:                 loc_oGrid.Column8.Check1.Alignment = 0
1685:                 loc_oGrid.Column8.Check1.ReadOnly  = .F.
1686:                 loc_oGrid.Column8.Check1.Visible   = .T.
1687:                 loc_oGrid.Column8.Check1.Top       = 9
1688:                 loc_oGrid.Column8.Check1.Left      = 2
1689:                 loc_oGrid.Column8.Check1.Height    = 17
1690:                 loc_oGrid.Column8.Check1.Width     = 22
1691:                 IF !THIS.this_lOpeBound
1692:                     BINDEVENT(loc_oGrid.Column8.Check1, "KeyPress",  THIS, "OpeGerACheckKeyPress")
1693:                     BINDEVENT(loc_oGrid.Column8.Check1, "MouseDown", THIS, "OpeGerACheckMouseDown")

*-- Linhas 1741 a 1760:
1741:             loc_oGrid.Column2.Width = 35
1742:             loc_oGrid.Column3.Width = 90
1743:             loc_oGrid.Column4.Width = 95
1744:             loc_oGrid.Column1.Header1.Caption = ""
1745:             loc_oGrid.Column2.Header1.Caption = "Emp"
1746:             loc_oGrid.Column3.Header1.Caption = "Grupo"
1747:             loc_oGrid.Column4.Header1.Caption = "Conta"
1748:             loc_oGrid.Column1.Sparse   = .F.
1749:             loc_oGrid.Column1.ReadOnly = .F.
1750:             IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
1751:                 loc_oGrid.Column1.Check1.Alignment = 0
1752:                 loc_oGrid.Column1.Check1.ReadOnly  = .F.
1753:                 loc_oGrid.Column1.Check1.Visible   = .T.
1754:                 loc_oGrid.Column1.Check1.Top       = 9
1755:                 loc_oGrid.Column1.Check1.Left      = 2
1756:                 loc_oGrid.Column1.Check1.Height    = 17
1757:                 loc_oGrid.Column1.Check1.Width     = 22
1758:                 IF !THIS.this_lEstoqueBound
1759:                     BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress",  THIS, "EstoqueACheckKeyPress")
1760:                     BINDEVENT(loc_oGrid.Column1.Check1, "MouseDown", THIS, "EstoqueACheckMouseDown")

*-- Linhas 1788 a 1807:
1788:             loc_oGrid.Column2.Width = 35
1789:             loc_oGrid.Column3.Width = 90
1790:             loc_oGrid.Column4.Width = 95
1791:             loc_oGrid.Column1.Header1.Caption = ""
1792:             loc_oGrid.Column2.Header1.Caption = "Emp"
1793:             loc_oGrid.Column3.Header1.Caption = "Grupo"
1794:             loc_oGrid.Column4.Header1.Caption = "Conta"
1795:             loc_oGrid.Column1.Sparse   = .F.
1796:             loc_oGrid.Column1.ReadOnly = .F.
1797:             IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
1798:                 loc_oGrid.Column1.Check1.Alignment = 0
1799:                 loc_oGrid.Column1.Check1.ReadOnly  = .F.
1800:                 loc_oGrid.Column1.Check1.Visible   = .T.
1801:                 loc_oGrid.Column1.Check1.Top       = 9
1802:                 loc_oGrid.Column1.Check1.Left      = 2
1803:                 loc_oGrid.Column1.Check1.Height    = 17
1804:                 loc_oGrid.Column1.Check1.Width     = 22
1805:                 IF !THIS.this_lEstoqueBound
1806:                     BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress",  THIS, "EstoqueBCheckKeyPress")
1807:                     BINDEVENT(loc_oGrid.Column1.Check1, "MouseDown", THIS, "EstoqueBCheckMouseDown")

*-- Linhas 2258 a 2269:
2258:                 loc_oGrid.Column3.Width = 150
2259:                 loc_oGrid.Column4.Width = 150
2260: 
2261:                 loc_oGrid.Column1.Header1.Caption = ""
2262:                 loc_oGrid.Column2.Header1.Caption = "Emp"
2263:                 loc_oGrid.Column3.Header1.Caption = "Local"
2264:                 loc_oGrid.Column4.Header1.Caption = "Local"
2265: 
2266:                 THIS.FormatarGridLista(loc_oGrid)
2267:                 loc_lResultado = .T.
2268:             ENDIF
2269:         CATCH TO loc_oErro

*-- Linhas 2308 a 2316:
2308:     ENDPROC
2309: 
2310:     *--------------------------------------------------------------------------
2311:     * BtnConfirmarClick - Salva o registro atual (handler do botao cmd_4c_Confirmar)
2312:     * Delega para BtnSalvarClick para manter compatibilidade com validador
2313:     *--------------------------------------------------------------------------
2314:     PROCEDURE BtnConfirmarClick()
2315:         RETURN THIS.BtnSalvarClick()
2316:     ENDPROC

*-- Linhas 2665 a 2673:
2665:         loc_oLocalB  = loc_oPg2.cnt_4c_LocalB
2666: 
2667:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2668:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2669:         ENDIF
2670: 
2671:         *-- cnt_4c_Codigos (Codigos somente habilitado em INCLUIR)
2672:         loc_oCodigos.txt_4c_Codigos.Enabled     = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
2673:         loc_oCodigos.txt_4c_Empresas.Enabled    = par_lHabilitar

*-- Linhas 2743 a 2752:
2743:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2744: 
2745:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2746:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
2747:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2748:         ENDIF
2749:     ENDPROC
2750: 
2751:     *--------------------------------------------------------------------------
2752:     * ValidarCampos - Valida campos obrigatorios antes de salvar


### BO (C:\4c\projeto\app\classes\CLCBO.prg):
*===============================================================================
* CLCBO.prg - Business Object para Comparativos Entre Locais
* Tabela principal: SigLcLo (PK: Codigos)
* Tabelas relacionadas: SigLcLoI (operacoes), SigLcLoE (estoques avaliados)
*===============================================================================
DEFINE CLASS CLCBO AS BusinessBase

    *-- Identificacao da tabela (BusinessBase)
    this_cTabela     = "SigLcLo"
    this_cCampoChave = "Codigos"

    *---------------------------------------------------------------------------
    * Propriedades - SigLcLo (campos principais)
    *---------------------------------------------------------------------------
    this_cCodigos    = ""   && Codigos  C - Chave primaria
    this_cEmps       = ""   && Emps     C(3) - Empresa
    this_lEmpContas  = .F.  && EmpContas N(1) - Substituir contas
    this_cEmpTrans   = ""   && EmpTrans  C - Empresa transitoria
    this_nDigitos    = 0    && Digitos   N - Digitos/Grupo (optiongroup)
    this_lAutos      = .F.  && Autos     N(1) - Automatico (processamento)
    this_nToleras    = 0    && Toleras   N - Tolerancia AU
    this_nPercents   = 0    && Percents  N - Percentual

    *-- Local A
    this_cLocalA     = ""   && LocalA    C - Codigo do Local A
    this_cGrupoA     = ""   && GrupoA    C - Grupo Origem (remote DB)
    this_cContaA     = ""   && ContaA    C - Conta Origem (remote DB)
    this_cOperacaoA  = ""   && OperacaoA C - Operacao Local A
    this_cGdeGrupoA  = ""   && GdeGrupoA C - Grande Grupo Local A
    this_dDataA      = {}   && DataA     D - Data Local A
    this_lEtiquetaA  = .F.  && EtiquetaA N(1) - Etiquetas Local A
    this_lPalmA      = .F.  && PalmA     N(1) - Checar Venda Palm A
    this_nDivisaoA   = 0    && DivisaoA  N - Divisao Local A

    *-- Local B
    this_cLocalB     = ""   && LocalB    C - Codigo do Local B
    this_cGrupoB     = ""   && GrupoB    C - Grupo Origem (remote DB)
    this_cContaB     = ""   && ContaB    C - Conta Origem (remote DB)
    this_cOperacaoB  = ""   && OperacaoB C - Operacao Local B
    this_cGdeGrupoB  = ""   && GdeGrupoB C - Grande Grupo Local B
    this_dDataB      = {}   && DataB     D - Data Local B
    this_lEtiquetaB  = .F.  && EtiquetaB N(1) - Etiquetas Local B
    this_lPalmB      = .F.  && PalmB     N(1) - Checar Venda Palm B
    this_nDivisaoB   = 0    && DivisaoB  N - Divisao Local B

    *---------------------------------------------------------------------------
    * Init - Configurar tabela e chave primaria
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigLcLo"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria (BusinessBase override)
    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *---------------------------------------------------------------------------
    * Buscar - SELECT de todos os registros de SigLcLo
    *---------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents, LocalA, GrupoA, ContaA, OperacaoA," + ;
                       " GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB," + ;
                       " GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       " FROM SigLcLo ORDER BY Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro especifico pelo codigo
    *---------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents, LocalA, GrupoA, ContaA, OperacaoA," + ;
                       " GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB," + ;
                       " GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       " FROM SigLcLo WHERE Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            IF VARTYPE(EmpContas) = "L"
                THIS.this_lEmpContas = EmpContas
            ELSE
                IF VARTYPE(EmpContas) = "L"
                    THIS.this_lEmpContas = EmpContas
                ELSE
                    IF VARTYPE(EmpContas) = "L"
                        THIS.this_lEmpContas = EmpContas
                    ELSE
                        IF VARTYPE(EmpContas) = "L"
                            THIS.this_lEmpContas = EmpContas
                        ELSE
                            THIS.this_lEmpContas = (NVL(EmpContas, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_cEmpTrans  = TratarNulo(EmpTrans,  "C")
            THIS.this_nDigitos   = TratarNulo(Digitos,   "N")
            IF VARTYPE(Autos) = "L"
                THIS.this_lAutos = Autos
            ELSE
                IF VARTYPE(Autos) = "L"
                    THIS.this_lAutos = Autos
                ELSE
                    IF VARTYPE(Autos) = "L"
                        THIS.this_lAutos = Autos
                    ELSE
                        IF VARTYPE(Autos) = "L"
                            THIS.this_lAutos = Autos
                        ELSE
                            THIS.this_lAutos = (NVL(Autos, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_nToleras   = TratarNulo(Toleras,   "N")
            THIS.this_nPercents  = TratarNulo(Percents,  "N")
            THIS.this_cLocalA    = TratarNulo(LocalA,    "C")
            THIS.this_cGrupoA    = TratarNulo(GrupoA,    "C")
            THIS.this_cContaA    = TratarNulo(ContaA,    "C")
            THIS.this_cOperacaoA = TratarNulo(OperacaoA, "C")
            THIS.this_cGdeGrupoA = TratarNulo(GdeGrupoA, "C")
            THIS.this_dDataA     = TratarNulo(DataA,     "D")
            IF VARTYPE(EtiquetaA) = "L"
                THIS.this_lEtiquetaA = EtiquetaA
            ELSE
                IF VARTYPE(EtiquetaA) = "L"
                    THIS.this_lEtiquetaA = EtiquetaA
                ELSE
                    IF VARTYPE(EtiquetaA) = "L"
                        THIS.this_lEtiquetaA = EtiquetaA
                    ELSE
                        IF VARTYPE(EtiquetaA) = "L"
                            THIS.this_lEtiquetaA = EtiquetaA
                        ELSE
                            THIS.this_lEtiquetaA = (NVL(EtiquetaA, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(PalmA) = "L"
                THIS.this_lPalmA = PalmA
            ELSE
                IF VARTYPE(PalmA) = "L"
                    THIS.this_lPalmA = PalmA
                ELSE
                    IF VARTYPE(PalmA) = "L"
                        THIS.this_lPalmA = PalmA
                    ELSE
                        IF VARTYPE(PalmA) = "L"
                            THIS.this_lPalmA = PalmA
                        ELSE
                            THIS.this_lPalmA = (NVL(PalmA, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_nDivisaoA  = TratarNulo(DivisaoA,  "N")
            THIS.this_cLocalB    = TratarNulo(LocalB,    "C")
            THIS.this_cGrupoB    = TratarNulo(GrupoB,    "C")
            THIS.this_cContaB    = TratarNulo(ContaB,    "C")
            THIS.this_cOperacaoB = TratarNulo(OperacaoB, "C")
            THIS.this_cGdeGrupoB = TratarNulo(GdeGrupoB, "C")
            THIS.this_dDataB     = TratarNulo(DataB,     "D")
            IF VARTYPE(EtiquetaB) = "L"
                THIS.this_lEtiquetaB = EtiquetaB
            ELSE
                IF VARTYPE(EtiquetaB) = "L"
                    THIS.this_lEtiquetaB = EtiquetaB
                ELSE
                    IF VARTYPE(EtiquetaB) = "L"
                        THIS.this_lEtiquetaB = EtiquetaB
                    ELSE
                        IF VARTYPE(EtiquetaB) = "L"
                            THIS.this_lEtiquetaB = EtiquetaB
                        ELSE
                            THIS.this_lEtiquetaB = (NVL(EtiquetaB, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(PalmB) = "L"
                THIS.this_lPalmB = PalmB
            ELSE
                IF VARTYPE(PalmB) = "L"
                    THIS.this_lPalmB = PalmB
                ELSE
                    IF VARTYPE(PalmB) = "L"
                        THIS.this_lPalmB = PalmB
                    ELSE
                        IF VARTYPE(PalmB) = "L"
                            THIS.this_lPalmB = PalmB
                        ELSE
                            THIS.this_lPalmB = (NVL(PalmB, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_nDivisaoB  = TratarNulo(DivisaoB,  "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarOperacoes - Carrega SigLcLoI para o cursor do grid de operacoes
    *---------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF

        TRY
            loc_cSQL = "SELECT cIdChaves, Codigos, Emps, Cods, Operacoes," + ;
                       " GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs" + ;
                       " FROM SigLcLoI WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY cIdChaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Operacoes")
                    GO TOP IN cursor_4c_Operacoes
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarEstoques - Carrega SigLcLoE (estoques avaliados) para um local
    *---------------------------------------------------------------------------
    PROCEDURE CarregarEstoques(par_cCodigos, par_cLocal, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cCursorDestino)
            USE IN (par_cCursorDestino)
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Locals, Emps, Grupos, Contas, Marca" + ;
                       " FROM SigLcLoE WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND Locals = " + EscaparSQL(par_cLocal) + ;
                       " ORDER BY Emps, Grupos, Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                IF USED(par_cCursorDestino)
                    GO TOP IN (par_cCursorDestino)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarCodigoDuplicado - Verifica se o codigo ja existe na tabela
    *---------------------------------------------------------------------------
    PROCEDURE VerificarCodigoDuplicado(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigLcLo WHERE Codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                GO TOP IN cursor_4c_ChkDup
                loc_lExiste = (cursor_4c_ChkDup.Total > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarCodigoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - INSERT INTO SigLcLo (PROTECTED - chamado por Salvar())
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigLcLo (" + ;
                       " Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents," + ;
                       " LocalA, GrupoA, ContaA, OperacaoA, GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB, GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       EscaparSQL(THIS.this_cEmps)      + "," + ;
                       IIF(THIS.this_lEmpContas, "1", "0") + "," + ;
                       EscaparSQL(THIS.this_cEmpTrans)  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDigitos)  + "," + ;
                       IIF(THIS.this_lAutos, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nToleras)  + "," + ;
                       FormatarNumeroSQL(THIS.this_nPercents) + "," + ;
                       EscaparSQL(THIS.this_cLocalA)    + "," + ;
                       EscaparSQL(THIS.this_cGrupoA)    + "," + ;
                       EscaparSQL(THIS.this_cContaA)    + "," + ;
                       EscaparSQL(THIS.this_cOperacaoA) + "," + ;
                       EscaparSQL(THIS.this_cGdeGrupoA) + "," + ;
                       FormatarDataSQL(THIS.this_dDataA) + "," + ;
                       IIF(THIS.this_lEtiquetaA, "1", "0") + "," + ;
                       IIF(THIS.this_lPalmA, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDivisaoA) + "," + ;
                       EscaparSQL(THIS.this_cLocalB)    + "," + ;
                       EscaparSQL(THIS.this_cGrupoB)    + "," + ;
                       EscaparSQL(THIS.this_cContaB)    + "," + ;
                       EscaparSQL(THIS.this_cOperacaoB) + "," + ;
                       EscaparSQL(THIS.this_cGdeGrupoB) + "," + ;
                       FormatarDataSQL(THIS.this_dDataB) + "," + ;
                       IIF(THIS.this_lEtiquetaB, "1", "0") + "," + ;
                       IIF(THIS.this_lPalmB, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDivisaoB) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - UPDATE SigLcLo (PROTECTED - chamado por Salvar())
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigLcLo SET" + ;
                       " Emps      = " + EscaparSQL(THIS.this_cEmps)      + "," + ;
                       " EmpContas = " + IIF(THIS.this_lEmpContas, "1", "0") + "," + ;
                       " EmpTrans  = " + EscaparSQL(THIS.this_cEmpTrans)  + "," + ;
                       " Digitos   = " + FormatarNumeroSQL(THIS.this_nDigitos)  + "," + ;
                       " Autos     = " + IIF(THIS.this_lAutos, "1", "0")  + "," + ;
                       " Toleras   = " + FormatarNumeroSQL(THIS.this_nToleras)  + "," + ;
                       " Percents  = " + FormatarNumeroSQL(THIS.this_nPercents) + "," + ;
                       " LocalA    = " + EscaparSQL(THIS.this_cLocalA)    + "," + ;
                       " GrupoA    = " + EscaparSQL(THIS.this_cGrupoA)    + "," + ;
                       " ContaA    = " + EscaparSQL(THIS.this_cContaA)    + "," + ;
                       " OperacaoA = " + EscaparSQL(THIS.this_cOperacaoA) + "," + ;
                       " GdeGrupoA = " + EscaparSQL(THIS.this_cGdeGrupoA) + "," + ;
                       " DataA     = " + FormatarDataSQL(THIS.this_dDataA) + "," + ;
                       " EtiquetaA = " + IIF(THIS.this_lEtiquetaA, "1", "0") + "," + ;
                       " PalmA     = " + IIF(THIS.this_lPalmA, "1", "0")  + "," + ;
                       " DivisaoA  = " + FormatarNumeroSQL(THIS.this_nDivisaoA) + "," + ;
                       " LocalB    = " + EscaparSQL(THIS.this_cLocalB)    + "," + ;
                       " GrupoB    = " + EscaparSQL(THIS.this_cGrupoB)    + "," + ;
                       " ContaB    = " + EscaparSQL(THIS.this_cContaB)    + "," + ;
                       " OperacaoB = " + EscaparSQL(THIS.this_cOperacaoB) + "," + ;
                       " GdeGrupoB = " + EscaparSQL(THIS.this_cGdeGrupoB) + "," + ;
                       " DataB     = " + FormatarDataSQL(THIS.this_dDataB) + "," + ;
                       " EtiquetaB = " + IIF(THIS.this_lEtiquetaB, "1", "0") + "," + ;
                       " PalmB     = " + IIF(THIS.this_lPalmB, "1", "0")  + "," + ;
                       " DivisaoB  = " + FormatarNumeroSQL(THIS.this_nDivisaoB) + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigLcLoI + SigLcLoE + SigLcLo (PROTECTED)
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir registros filhos de SigLcLoI primeiro
            loc_cSQL = "DELETE FROM SigLcLoI WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Excluir registros filhos de SigLcLoE
            loc_cSQL = "DELETE FROM SigLcLoE WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir estoques avaliados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Excluir o registro principal
            loc_cSQL = "DELETE FROM SigLcLo WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * InserirOperacao - INSERT filho em SigLcLoI (chamado pelo Form ao gravar grid)
    *---------------------------------------------------------------------------
    PROCEDURE InserirOperacao(par_cCodigos, par_cIdChave, par_cEmps, par_cCods, ;
                              par_cOperacoes, par_cGrupoOs, par_cContaOs, ;
                              par_cGrupoDs, par_cContaDs, par_nAgrupar, par_cEnvRecs)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigLcLoI (" + ;
                       " cIdChaves, Codigos, Emps, Cods, Operacoes," + ;
                       " GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs" + ;
                       ") VALUES (" + ;
                       EscaparSQL(par_cIdChave)   + "," + ;
                       EscaparSQL(par_cCodigos)   + "," + ;
                       EscaparSQL(par_cEmps)      + "," + ;
                       EscaparSQL(par_cCods)      + "," + ;
                       EscaparSQL(par_cOperacoes) + "," + ;
                       EscaparSQL(par_cGrupoOs)   + "," + ;
                       EscaparSQL(par_cContaOs)   + "," + ;
                       EscaparSQL(par_cGrupoDs)   + "," + ;
                       EscaparSQL(par_cContaDs)   + "," + ;
                       FormatarNumeroSQL(par_nAgrupar) + "," + ;
                       EscaparSQL(par_cEnvRecs)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

            IF !loc_lSucesso
                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InserirOperacao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExcluirOperacoes - DELETE todos os filhos de SigLcLoI para um codigo
    *---------------------------------------------------------------------------
    PROCEDURE ExcluirOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigLcLoI WHERE Codigos = " + EscaparSQL(par_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

            IF !loc_lSucesso
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExcluirOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * GravarEstoques - DELETE + re-INSERT em SigLcLoE para um local
    *---------------------------------------------------------------------------
    PROCEDURE GravarEstoques(par_cCodigos, par_cLocal, par_cCursorOrigem)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir registros anteriores deste local
            loc_cSQL = "DELETE FROM SigLcLoE WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND Locals = " + EscaparSQL(par_cLocal)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao limpar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Inserir registros marcados do cursor origem
            IF USED(par_cCursorOrigem) AND RECCOUNT(par_cCursorOrigem) > 0
                SELECT (par_cCursorOrigem)
                GO TOP

                SCAN
                    SELECT (par_cCursorOrigem)
                    IF Marca
                        loc_cSQL = "INSERT INTO SigLcLoE (Codigos, Locals, Emps, Grupos, Contas, Marca)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(par_cCodigos) + "," + ;
                                   EscaparSQL(par_cLocal)   + "," + ;
                                   EscaparSQL(ALLTRIM(Emps))   + "," + ;
                                   EscaparSQL(ALLTRIM(Grupos)) + "," + ;
                                   EscaparSQL(ALLTRIM(Contas)) + "," + ;
                                   "1)"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao gravar estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em GravarEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

