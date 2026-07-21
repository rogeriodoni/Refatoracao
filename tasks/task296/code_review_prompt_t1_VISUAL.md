# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [ALINHAMENTO] Botao 'cmd_4c_Encerrar' tem Top=5 mas grupo usa Top=3 (diferenca de 2px)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 202: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 224: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 246: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrHpr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1186 linhas total):

*-- Linhas 35 a 43:
35:     PROCEDURE Init
36:     *--------------------------------------------------------------------------
37:     LPARAMETERS par_oParentForm, par_dDataIni, par_dDataFim, par_cCdGrupo, par_cCdConta, par_cCdProduto, par_cDsProduto
38:         THIS.Caption = "Hist" + CHR(243) + "rico de Produtos"
39:         IF PCOUNT() >= 1 AND VARTYPE(par_oParentForm) == "O"
40:             THIS.this_oParentForm = par_oParentForm
41:         ENDIF
42:         IF PCOUNT() >= 2 AND VARTYPE(par_dDataIni) == "D"
43:             THIS.this_dDataIni = par_dDataIni

*-- Linhas 83 a 91:
83:             THIS.ConfigurarPaginaDados()
84:             THIS.TornarControlesVisiveis(THIS)
85:             THIS.txt_4c_Data.Visible        = .F.
86:             THIS.lbl_4c_DataLabel.Visible   = .F.
87:             THIS.chk_4c_ChkAuditado.Visible = .F.
88:             THIS.ConfigurarEventos()
89: 
90:             IF !(VARTYPE(gb_4c_ValidandoUI) == "L" AND gb_4c_ValidandoUI)
91:                 THIS.CarregarDados()

*-- Linhas 115 a 154:
115:     *--------------------------------------------------------------------------
116:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH THIS.cnt_4c_Cabecalho
118:             .Top       = 0
119:             .Left      = 0
120:             .Width     = THIS.Width
121:             .Height    = 80
122:             .BackColor = RGB(100, 100, 100)
123:             .BackStyle = 1
124:             .Visible   = .T.
125:             .AddObject("lbl_4c_Sombra", "Label")
126:             WITH .lbl_4c_Sombra
127:                 .Top       = 18
128:                 .Left      = 10
129:                 .Width     = THIS.Width
130:                 .Height    = 40
131:                 .AutoSize  = .F.
132:                 .Caption   = "Hist" + CHR(243) + "rico de Produtos"
133:                 .FontName  = "Tahoma"
134:                 .FontSize  = 18
135:                 .FontBold  = .T.
136:                 .WordWrap  = .T.
137:                 .Alignment = 0
138:                 .ForeColor = RGB(0, 0, 0)
139:                 .BackStyle = 0
140:                 .Visible   = .T.
141:             ENDWITH
142:             .AddObject("lbl_4c_Titulo", "Label")
143:             WITH .lbl_4c_Titulo
144:                 .Top       = 17
145:                 .Left      = 10
146:                 .Width     = THIS.Width
147:                 .Height    = 46
148:                 .AutoSize  = .F.
149:                 .Caption   = "Hist" + CHR(243) + "rico de Produtos"
150:                 .FontName  = "Tahoma"
151:                 .FontSize  = 18
152:                 .FontBold  = .T.
153:                 .WordWrap  = .T.
154:                 .Alignment = 0

*-- Linhas 164 a 328:
164:     *--------------------------------------------------------------------------
165:         THIS.AddObject("cnt_4c_Origem", "Container")
166:         WITH THIS.cnt_4c_Origem
167:             .Top       = 426
168:             .Left      = 7
169:             .Width     = 478
170:             .Height    = 74
171:             .BackColor = RGB(255, 255, 255)
172:             .BackStyle = 1
173:             .Visible   = .T.
174:         ENDWITH
175:         THIS.AddObject("cnt_4c_Destino", "Container")
176:         WITH THIS.cnt_4c_Destino
177:             .Top       = 426
178:             .Left      = 504
179:             .Width     = 478
180:             .Height    = 74
181:             .BackColor = RGB(255, 255, 255)
182:             .BackStyle = 1
183:             .Visible   = .T.
184:         ENDWITH
185:     ENDPROC
186: 
187:     *--------------------------------------------------------------------------
188:     PROTECTED PROCEDURE ConfigurarBotoesTopo
189:     *--------------------------------------------------------------------------
190:         THIS.AddObject("chk_4c_ChkAuditado", "CheckBox")
191:         WITH THIS.chk_4c_ChkAuditado
192:             .Top             = 3
193:             .Left            = 700
194:             .Width           = 75
195:             .Height          = 75
196:             .Caption         = "Auditado"
197:             .Alignment       = 0
198:             .Style           = 1
199:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
200:             .PicturePosition = 13
201:             .WordWrap        = .T.
202:             .FontName        = "Comic Sans MS"
203:             .FontBold        = .T.
204:             .FontItalic      = .T.
205:             .FontSize        = 8
206:             .ForeColor       = RGB(90, 90, 90)
207:             .BackColor       = RGB(255, 255, 255)
208:             .Themes          = .F.
209:             .BackStyle       = 0
210:             .SpecialEffect   = 0
211:             .Visible         = .T.
212:         ENDWITH
213:         THIS.AddObject("cmd_4c_BtnDocumento", "CommandButton")
214:         WITH THIS.cmd_4c_BtnDocumento
215:             .Top             = 3
216:             .Left            = 775
217:             .Width           = 75
218:             .Height          = 75
219:             .Caption         = "Movimento"
220:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
221:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
222:             .PicturePosition = 13
223:             .WordWrap        = .T.
224:             .FontName        = "Comic Sans MS"
225:             .FontBold        = .T.
226:             .FontItalic      = .T.
227:             .FontSize        = 8
228:             .ForeColor       = RGB(90, 90, 90)
229:             .BackColor       = RGB(255, 255, 255)
230:             .Themes          = .T.
231:             .SpecialEffect   = 0
232:             .MousePointer    = 15
233:             .Visible         = .T.
234:         ENDWITH
235:         THIS.AddObject("cmd_4c_Procurar", "CommandButton")
236:         WITH THIS.cmd_4c_Procurar
237:             .Top             = 3
238:             .Left            = 850
239:             .Width           = 75
240:             .Height          = 75
241:             .Caption         = "Procurar"
242:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
243:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
244:             .PicturePosition = 13
245:             .WordWrap        = .T.
246:             .FontName        = "Comic Sans MS"
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .FontSize        = 8
250:             .ForeColor       = RGB(90, 90, 90)
251:             .BackColor       = RGB(255, 255, 255)
252:             .Themes          = .T.
253:             .SpecialEffect   = 0
254:             .MousePointer    = 15
255:             .Visible         = .T.
256:         ENDWITH
257:         THIS.AddObject("cnt_4c_Saida", "Container")
258:         WITH THIS.cnt_4c_Saida
259:             .Top       = 0
260:             .Left      = 917
261:             .Width     = 90
262:             .Height    = 85
263:             .BackStyle = 0
264:             .Visible   = .T.
265:             .AddObject("cmd_4c_Encerrar", "CommandButton")
266:             WITH .cmd_4c_Encerrar
267:                 .Top     = 5
268:                 .Left    = 917
269:                 .Width   = 75
270:                 .Height  = 75
271:                 .Caption = "Encerrar"
272:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
273:                 .Visible = .T.
274:             ENDWITH
275:         ENDWITH
276:     ENDPROC
277: 
278:     *--------------------------------------------------------------------------
279:     PROTECTED PROCEDURE ConfigurarCamposFiltroData
280:     *--------------------------------------------------------------------------
281:         THIS.AddObject("lbl_4c_DataLabel", "Label")
282:         WITH THIS.lbl_4c_DataLabel
283:             .Top      = 102
284:             .Left     = 441
285:             .AutoSize = .T.
286:             .Caption  = "Data:"
287:             .FontBold = .T.
288:             .Visible  = .F.
289:         ENDWITH
290:         THIS.AddObject("txt_4c_Data", "TextBox")
291:         WITH THIS.txt_4c_Data
292:             .Top       = 98
293:             .Left      = 478
294:             .Width     = 80
295:             .Height    = 23
296:             .Alignment = 3
297:             .MaxLength = 10
298:             .Visible   = .F.
299:         ENDWITH
300:     ENDPROC
301: 
302:     *--------------------------------------------------------------------------
303:     PROTECTED PROCEDURE ConfigurarLabelProduto
304:     *--------------------------------------------------------------------------
305:         THIS.AddObject("lbl_4c_LabelProduto", "Label")
306:         WITH THIS.lbl_4c_LabelProduto
307:             .Top       = 130
308:             .Left      = 15
309:             .AutoSize  = .T.
310:             .FontBold  = .T.
311:             .ForeColor = RGB(90, 90, 90)
312:             .Caption   = ""
313:             .Visible   = .T.
314:         ENDWITH
315:     ENDPROC
316: 
317:     *--------------------------------------------------------------------------
318:     PROTECTED PROCEDURE ConfigurarGrdHistorico
319:     *--------------------------------------------------------------------------
320:         THIS.AddObject("grd_4c_Historico", "GridBase")
321:         WITH THIS.grd_4c_Historico
322:             .Top          = 148
323:             .Left         = 4
324:             .Width        = 730
325:             .Height       = 238
326:             .ColumnCount  = 9
327:             .RecordSource = "cursor_4c_Historico"
328:             .ReadOnly     = .T.

*-- Linhas 335 a 417:
335:                 .Width            = 86
336:                 .ControlSource    = "cursor_4c_Historico.datas"
337:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
338:                 .Header1.Caption  = "Data"
339:             ENDWITH
340:             WITH .Column2
341:                 .Width            = 57
342:                 .ControlSource    = "cursor_4c_Historico.numes"
343:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
344:                 .Header1.Caption  = "C" + CHR(243) + "digo"
345:             ENDWITH
346:             WITH .Column3
347:                 .Width            = 161
348:                 .ControlSource    = "cursor_4c_Historico.dopes"
349:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
350:                 .Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
351:             ENDWITH
352:             WITH .Column4
353:                 .Width            = 31
354:                 .ControlSource    = "cursor_4c_Historico.cunis"
355:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
356:                 .Header1.Caption  = "Un."
357:             ENDWITH
358:             WITH .Column5
359:                 .Width            = 78
360:                 .ControlSource    = "cursor_4c_Historico.qtds"
361:                 .Format           = "999,999.999"
362:                 .InputMask        = "999,999.999"
363:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
364:                 .Header1.Caption  = "Quantidade"
365:             ENDWITH
366:             WITH .Column6
367:                 .Width            = 24
368:                 .ControlSource    = "cursor_4c_Historico.opers"
369:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
370:                 .Header1.Caption  = "O"
371:             ENDWITH
372:             WITH .Column7
373:                 .Width            = 93
374:                 .ControlSource    = "cursor_4c_Historico.sqtds"
375:                 .Format           = "9,999,999.999"
376:                 .InputMask        = "9,999,999.999"
377:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
378:                 .Header1.Caption  = "Saldo  Q"
379:             ENDWITH
380:             WITH .Column8
381:                 .Width            = 80
382:                 .ControlSource    = "cursor_4c_Historico.pesos"
383:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
384:                 .Header1.Caption  = "Peso"
385:                 .Visible          = .F.
386:             ENDWITH
387:             WITH .Column9
388:                 .Width            = 80
389:                 .ControlSource    = "cursor_4c_Historico.spesos"
390:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
391:                 .Header1.Caption  = "Saldo P"
392:                 .Visible          = .F.
393:             ENDWITH
394:         ENDWITH
395:     ENDPROC
396: 
397:     *--------------------------------------------------------------------------
398:     PROTECTED PROCEDURE ConfigurarGrdSubniveis
399:     *--------------------------------------------------------------------------
400:         THIS.AddObject("lbl_4c_Label3", "Label")
401:         WITH THIS.lbl_4c_Label3
402:             .Top      = 130
403:             .Left     = 747
404:             .AutoSize = .T.
405:             .Caption  = "Movimenta" + CHR(231) + CHR(245) + "es com subn" + CHR(237) + "vel"
406:             .FontBold = .T.
407:             .Visible  = .T.
408:         ENDWITH
409:         THIS.AddObject("grd_4c_Subniveis", "GridBase")
410:         WITH THIS.grd_4c_Subniveis
411:             .Top          = 148
412:             .Left         = 738
413:             .Width        = 261
414:             .Height       = 238
415:             .ColumnCount  = 3
416:             .RecordSource = "cursor_4c_Subniveis"
417:             .ReadOnly     = .T.

*-- Linhas 423 a 691:
423:             WITH .Column1
424:                 .Width           = 31
425:                 .ControlSource   = "cursor_4c_Subniveis.emps"
426:                 .Header1.Caption = "Emp"
427:             ENDWITH
428:             WITH .Column2
429:                 .Width           = 156
430:                 .ControlSource   = "cursor_4c_Subniveis.dopes"
431:                 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
432:             ENDWITH
433:             WITH .Column3
434:                 .Width           = 51
435:                 .ControlSource   = "cursor_4c_Subniveis.numes"
436:                 .Header1.Caption = "C" + CHR(243) + "digo"
437:             ENDWITH
438:         ENDWITH
439:     ENDPROC
440: 
441:     *--------------------------------------------------------------------------
442:     PROTECTED PROCEDURE ConfigurarAreaInfo
443:     *--------------------------------------------------------------------------
444:         THIS.AddObject("lbl_4c_Label2", "Label")
445:         WITH THIS.lbl_4c_Label2
446:             .Top      = 396
447:             .Left     = 27
448:             .AutoSize = .T.
449:             .Caption  = "Documento:"
450:             .FontBold = .T.
451:             .Visible  = .T.
452:         ENDWITH
453:         THIS.AddObject("txt_4c_Nota", "TextBox")
454:         WITH THIS.txt_4c_Nota
455:             .Top           = 392
456:             .Left          = 102
457:             .Width         = 80
458:             .Height        = 23
459:             .ReadOnly      = .T.
460:             .SpecialEffect = 1
461:             .Visible       = .T.
462:         ENDWITH
463:         THIS.AddObject("lbl_4c_Label1", "Label")
464:         WITH THIS.lbl_4c_Label1
465:             .Top      = 396
466:             .Left     = 197
467:             .AutoSize = .T.
468:             .Caption  = "Usu" + CHR(225) + "rio:"
469:             .FontBold = .T.
470:             .Visible  = .T.
471:         ENDWITH
472:         THIS.AddObject("txt_4c_Usuario", "TextBox")
473:         WITH THIS.txt_4c_Usuario
474:             .Top           = 392
475:             .Left          = 250
476:             .Width         = 96
477:             .Height        = 23
478:             .ReadOnly      = .T.
479:             .SpecialEffect = 1
480:             .Visible       = .T.
481:         ENDWITH
482:         THIS.AddObject("lbl_4c_Auditoria", "Label")
483:         WITH THIS.lbl_4c_Auditoria
484:             .Top      = 396
485:             .Left     = 403
486:             .AutoSize = .T.
487:             .Caption  = "Auditoria:"
488:             .FontBold = .T.
489:             .Visible  = .T.
490:         ENDWITH
491:         THIS.AddObject("txt_4c_DtAudits", "TextBox")
492:         WITH THIS.txt_4c_DtAudits
493:             .Top           = 392
494:             .Left          = 465
495:             .Width         = 80
496:             .Height        = 23
497:             .ReadOnly      = .T.
498:             .SpecialEffect = 1
499:             .Visible       = .T.
500:         ENDWITH
501:         THIS.AddObject("lbl_4c_Auditor", "Label")
502:         WITH THIS.lbl_4c_Auditor
503:             .Top      = 396
504:             .Left     = 556
505:             .AutoSize = .T.
506:             .Caption  = "Auditor:"
507:             .FontBold = .T.
508:             .Visible  = .T.
509:         ENDWITH
510:         THIS.AddObject("txt_4c_Auditors", "TextBox")
511:         WITH THIS.txt_4c_Auditors
512:             .Top           = 392
513:             .Left          = 608
514:             .Width         = 96
515:             .Height        = 23
516:             .ReadOnly      = .T.
517:             .SpecialEffect = 1
518:             .Visible       = .T.
519:         ENDWITH
520:     ENDPROC
521: 
522:     *--------------------------------------------------------------------------
523:     PROTECTED PROCEDURE ConfigurarLabelsAreaContas
524:     *--------------------------------------------------------------------------
525:         THIS.AddObject("lbl_4c_Label7", "Label")
526:         WITH THIS.lbl_4c_Label7
527:             .Top      = 428
528:             .Left     = 17
529:             .AutoSize = .T.
530:             .Caption  = "Origem"
531:             .FontBold = .T.
532:             .Visible  = .T.
533:         ENDWITH
534:         THIS.AddObject("lin_4c_Line1", "Line")
535:         WITH THIS.lin_4c_Line1
536:             .Top         = 442
537:             .Left        = 18
538:             .Width       = 340
539:             .Height      = 0
540:             .BorderWidth = 2
541:             .BorderColor = RGB(90, 90, 90)
542:             .Visible     = .T.
543:         ENDWITH
544:         THIS.AddObject("lbl_4c_Label9", "Label")
545:         WITH THIS.lbl_4c_Label9
546:             .Top      = 451
547:             .Left     = 62
548:             .AutoSize = .T.
549:             .Caption  = "Grupo:"
550:             .FontBold = .T.
551:             .Visible  = .T.
552:         ENDWITH
553:         THIS.AddObject("lbl_4c_Label10", "Label")
554:         WITH THIS.lbl_4c_Label10
555:             .Top      = 475
556:             .Left     = 63
557:             .AutoSize = .T.
558:             .Caption  = "Conta:"
559:             .FontBold = .T.
560:             .Visible  = .T.
561:         ENDWITH
562:         THIS.AddObject("lbl_4c_Label8", "Label")
563:         WITH THIS.lbl_4c_Label8
564:             .Top      = 428
565:             .Left     = 513
566:             .AutoSize = .T.
567:             .Caption  = "Destino"
568:             .FontBold = .T.
569:             .Visible  = .T.
570:         ENDWITH
571:         THIS.AddObject("lin_4c_Line2", "Line")
572:         WITH THIS.lin_4c_Line2
573:             .Top         = 442
574:             .Left        = 515
575:             .Width       = 340
576:             .Height      = 0
577:             .BorderWidth = 2
578:             .BorderColor = RGB(90, 90, 90)
579:             .Visible     = .T.
580:         ENDWITH
581:         THIS.AddObject("lbl_4c_Label11", "Label")
582:         WITH THIS.lbl_4c_Label11
583:             .Top      = 451
584:             .Left     = 557
585:             .AutoSize = .T.
586:             .Caption  = "Grupo:"
587:             .FontBold = .T.
588:             .Visible  = .T.
589:         ENDWITH
590:         THIS.AddObject("lbl_4c_Label12", "Label")
591:         WITH THIS.lbl_4c_Label12
592:             .Top      = 475
593:             .Left     = 558
594:             .AutoSize = .T.
595:             .Caption  = "Conta:"
596:             .FontBold = .T.
597:             .Visible  = .T.
598:         ENDWITH
599:         THIS.AddObject("lbl_4c_Label5", "Label")
600:         WITH THIS.lbl_4c_Label5
601:             .Top      = 517
602:             .Left     = 29
603:             .AutoSize = .T.
604:             .Caption  = "Observa" + CHR(231) + CHR(227) + "o:"
605:             .FontBold = .T.
606:             .Visible  = .T.
607:         ENDWITH
608:     ENDPROC
609: 
610:     *--------------------------------------------------------------------------
611:     PROTECTED PROCEDURE ConfigurarCamposAreaContas
612:     *--------------------------------------------------------------------------
613:         THIS.AddObject("txt_4c_GruOri", "TextBox")
614:         WITH THIS.txt_4c_GruOri
615:             .Top           = 447
616:             .Left          = 106
617:             .Width         = 80
618:             .Height        = 23
619:             .ReadOnly      = .T.
620:             .SpecialEffect = 1
621:             .Visible       = .T.
622:         ENDWITH
623:         THIS.AddObject("txt_4c_DesGruOri", "TextBox")
624:         WITH THIS.txt_4c_DesGruOri
625:             .Top           = 447
626:             .Left          = 187
627:             .Width         = 290
628:             .Height        = 23
629:             .ReadOnly      = .T.
630:             .SpecialEffect = 1
631:             .Visible       = .T.
632:         ENDWITH
633:         THIS.AddObject("txt_4c_ConOri", "TextBox")
634:         WITH THIS.txt_4c_ConOri
635:             .Top           = 471
636:             .Left          = 106
637:             .Width         = 80
638:             .Height        = 23
639:             .ReadOnly      = .T.
640:             .SpecialEffect = 1
641:             .Visible       = .T.
642:         ENDWITH
643:         THIS.AddObject("txt_4c_DesConOri", "TextBox")
644:         WITH THIS.txt_4c_DesConOri
645:             .Top           = 471
646:             .Left          = 187
647:             .Width         = 290
648:             .Height        = 23
649:             .ReadOnly      = .T.
650:             .SpecialEffect = 1
651:             .Visible       = .T.
652:         ENDWITH
653:         THIS.AddObject("txt_4c_GruDes", "TextBox")
654:         WITH THIS.txt_4c_GruDes
655:             .Top           = 447
656:             .Left          = 601
657:             .Width         = 80
658:             .Height        = 23
659:             .ReadOnly      = .T.
660:             .SpecialEffect = 1
661:             .Visible       = .T.
662:         ENDWITH
663:         THIS.AddObject("txt_4c_DesGruDes", "TextBox")
664:         WITH THIS.txt_4c_DesGruDes
665:             .Top           = 447
666:             .Left          = 682
667:             .Width         = 290
668:             .Height        = 23
669:             .ReadOnly      = .T.
670:             .SpecialEffect = 1
671:             .Visible       = .T.
672:         ENDWITH
673:         THIS.AddObject("txt_4c_ConDes", "TextBox")
674:         WITH THIS.txt_4c_ConDes
675:             .Top           = 471
676:             .Left          = 601
677:             .Width         = 80
678:             .Height        = 23
679:             .ReadOnly      = .T.
680:             .SpecialEffect = 1
681:             .Visible       = .T.
682:         ENDWITH
683:         THIS.AddObject("txt_4c_DesConDes", "TextBox")
684:         WITH THIS.txt_4c_DesConDes
685:             .Top           = 471
686:             .Left          = 682
687:             .Width         = 290
688:             .Height        = 23
689:             .ReadOnly      = .T.
690:             .SpecialEffect = 1
691:             .Visible       = .T.

*-- Linhas 697 a 706:
697:     *--------------------------------------------------------------------------
698:         THIS.AddObject("obj_4c_Obs", "EditBox")
699:         WITH THIS.obj_4c_Obs
700:             .Top           = 514
701:             .Left          = 106
702:             .Width         = 875
703:             .Height        = 55
704:             .ReadOnly      = .T.
705:             .SpecialEffect = 1
706:             .Visible       = .T.

*-- Linhas 759 a 785:
759:     *--------------------------------------------------------------------------
760:         BINDEVENT(THIS.grd_4c_Historico,              "AfterRowColChange", THIS, "GrdHistoricoAfterRowColChange")
761:         BINDEVENT(THIS.chk_4c_ChkAuditado,            "Click",             THIS, "ChkAuditadoClick")
762:         BINDEVENT(THIS.cmd_4c_Procurar,               "Click",             THIS, "CmdProcurarClick")
763:         BINDEVENT(THIS.cmd_4c_BtnDocumento,           "Click",             THIS, "CmdMovimentoClick")
764:         BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",          THIS, "TxtDataKeyPress")
765:         BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",         THIS, "TxtDataLostFocus")
766:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click",             THIS, "CmdEncerrarClick")
767:     ENDPROC
768: 
769:     *--------------------------------------------------------------------------
770:     PROTECTED PROCEDURE CarregarDados
771:     *-- CarregarHistorico ja chama CarregarDadosProduto internamente
772:     *--------------------------------------------------------------------------
773:         LOCAL loc_lSucesso
774:         loc_lSucesso = .F.
775:         TRY
776:             THIS.this_oBusinessObject.CarregarHistorico()
777:             THIS.this_lEhPeso = THIS.this_oBusinessObject.this_lEhPeso
778:             THIS.grd_4c_Historico.Column8.Visible = THIS.this_lEhPeso
779:             THIS.grd_4c_Historico.Column9.Visible = THIS.this_lEhPeso
780:             THIS.lbl_4c_LabelProduto.Caption = THIS.this_cDsProduto
781:             IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
782:                 SELECT cursor_4c_Historico
783:                 GO BOTTOM
784:                 THIS.AtualizarCamposLinha()
785:             ENDIF

*-- Linhas 879 a 887:
879:     *--------------------------------------------------------------------------
880:     PROCEDURE CmdProcurarClick
881:     *--------------------------------------------------------------------------
882:         THIS.lbl_4c_DataLabel.Visible = .T.
883:         THIS.txt_4c_Data.Visible      = .T.
884:         THIS.txt_4c_Data.Value        = DATE()
885:         THIS.txt_4c_Data.SetFocus()
886:     ENDPROC
887: 

*-- Linhas 895 a 903:
895:         ENDIF
896:         loc_dData = THIS.txt_4c_Data.Value
897:         THIS.txt_4c_Data.Visible      = .F.
898:         THIS.lbl_4c_DataLabel.Visible = .F.
899:         IF EMPTY(loc_dData) OR VARTYPE(loc_dData) != "D"
900:             RETURN
901:         ENDIF
902:         IF USED("cursor_4c_Historico")
903:             SET NEAR ON

*-- Linhas 914 a 922:
914:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
915:     *--------------------------------------------------------------------------
916:         THIS.txt_4c_Data.Visible      = .F.
917:         THIS.lbl_4c_DataLabel.Visible = .F.
918:     ENDPROC
919: 
920:     *--------------------------------------------------------------------------
921:     PROCEDURE CmdMovimentoClick
922:     *--------------------------------------------------------------------------

*-- Linhas 1109 a 1123:
1109:     *==========================================================================
1110:     PROCEDURE BtnCancelarClick
1111:         THIS.txt_4c_Data.Visible      = .F.
1112:         THIS.lbl_4c_DataLabel.Visible = .F.
1113:         THIS.grd_4c_Historico.SetFocus()
1114:     ENDPROC
1115: 
1116:     *--------------------------------------------------------------------------
1117:     * FormParaBO - Sincroniza estado do form -> BO
1118:     *   OPERACIONAL: propaga parametros de contexto e estado do checkbox
1119:     *--------------------------------------------------------------------------
1120:     PROCEDURE FormParaBO
1121:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1122:             RETURN
1123:         ENDIF

*-- Linhas 1140 a 1148:
1140: 
1141:     *--------------------------------------------------------------------------
1142:     * HabilitarCampos - OPERACIONAL: campos sao ReadOnly por natureza.
1143:     *   Gerencia apenas visibilidade do checkbox de auditoria conforme permissao.
1144:     *--------------------------------------------------------------------------
1145:     PROCEDURE HabilitarCampos
1146:     LPARAMETERS par_cModo
1147:         LOCAL loc_lPermite
1148:         loc_lPermite = .F.


### BO (C:\4c\projeto\app\classes\SigPrHprBO.prg):
*================================================================================
* SigPrHprBO.prg - Business Object: Historico de Produtos (SIGPRHPR)
* Form: OPERACIONAL
* Tabela principal: SigMvHst (UPDATE de auditoria)
* Gerado: 17/07/2026
*================================================================================

DEFINE CLASS SigPrHprBO AS BusinessBase

    *-- Tabela e chave principal (SigMvHst recebe UPDATE de auditoria)
    this_cTabela     = "SigMvHst"
    this_cCampoChave = "cidchaves"

    *-- Parametros de contexto recebidos do form pai ao abrir
    this_cCdGrupo    = ""
    this_cCdConta    = ""
    this_cCdProduto  = ""
    this_cDsProduto  = ""
    this_dDataIni    = {}
    this_dDataFim    = {}
    this_cCodEmpresa = ""

    *-- Dados do registro corrente de SigMvHst (linha selecionada no grid)
    this_cEmps       = ""
    this_cEmpos      = ""
    this_cGrupos     = ""
    this_cEstos      = ""
    this_cCpros      = ""
    this_cDopes      = ""
    this_nNumes      = 0
    this_dDatas      = {}
    this_cAuditors   = ""
    this_dDtAudits   = {}
    this_nQtds       = 0
    this_cOpers      = ""
    this_nSQtds      = 0
    this_cObs        = ""
    this_cUsuars     = ""
    this_cCidChaves  = ""
    this_nPesos      = 0
    this_nSPesos     = 0
    this_cCunis      = ""
    this_cCunips     = ""
    this_cCestos     = ""
    this_cEmpDopNums = ""
    this_cEmpGruEsts = ""

    *-- Dados do documento (SigMvCab ou SigCdNec)
    this_cGrupoOri    = ""
    this_cContaOri    = ""
    this_cGrupoDes    = ""
    this_cContaDes    = ""
    this_cNotas       = ""

    *-- Descricoes do contabil (SigCdGcr e SigCdCli)
    this_cDesGrupoOri = ""
    this_cDesContaOri = ""
    this_cDesGrupoDes = ""
    this_cDesContaDes = ""

    *-- Controle interno de permissao e tipo de produto (Cestos='3' = produto peso)
    this_lTemAuditoria = .F.
    this_lEhPeso       = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvHst"
            THIS.this_cCampoChave = "cidchaves"
            THIS.this_cCodEmpresa = go_4c_Sistema.cCodEmpresa

            *-- Cursor placeholder para grid de historico
            *-- Estrutura espelha campos do SQLEXEC em CarregarHistorico
            SET NULL ON
            CREATE CURSOR cursor_4c_Historico (;
                emps      C(3)    NULL, ;
                empos     C(3)    NULL, ;
                grupos    C(10)   NULL, ;
                estos     C(10)   NULL, ;
                cpros     C(14)   NULL, ;
                dopes     C(20)   NULL, ;
                numes     N(6,0)  NULL, ;
                datas     T       NULL, ;
                auditors  C(10)   NULL, ;
                dtaudits  T       NULL, ;
                qtds      N(9,3)  NULL, ;
                opers     C(1)    NULL, ;
                sqtds     N(11,3) NULL, ;
                obs       M       NULL, ;
                usuars    C(10)   NULL, ;
                cidchaves C(20)   NULL, ;
                pesos     N(15,3) NULL, ;
                spesos    N(15,3) NULL, ;
                cunis     C(3)    NULL  ;
            )
            INDEX ON DTOS(datas) TAG datas
            INDEX ON pesos TAG pesos
            SET NULL OFF

            *-- Cursor placeholder para grid de subniveis
            *-- Estrutura espelha crSubniveis do legado
            SET NULL ON
            CREATE CURSOR cursor_4c_Subniveis (;
                emps  C(3)   NULL, ;
                dopes C(20)  NULL, ;
                numes N(6,0) NULL  ;
            )
            INDEX ON emps TAG emps
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Copia dados da linha corrente do cursor para as props
    * Assinatura canonica CRUD (par_cAliasCursor). Alias flexivel para
    * cursor_4c_Historico ou qualquer outro cursor com estrutura de SigMvHst.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Historico", par_cAliasCursor)
            IF USED(loc_cAlias) AND RECCOUNT(loc_cAlias) > 0
                SELECT (loc_cAlias)
                THIS.this_cEmps      = TratarNulo(emps, "C")
                THIS.this_cEmpos     = TratarNulo(empos, "C")
                THIS.this_cGrupos    = TratarNulo(grupos, "C")
                THIS.this_cEstos     = TratarNulo(estos, "C")
                THIS.this_cCpros     = TratarNulo(cpros, "C")
                THIS.this_cDopes     = TratarNulo(dopes, "C")
                IF VARTYPE(numes) = "N"
                    THIS.this_nNumes = NVL(numes, 0)
                ELSE
                    THIS.this_nNumes = 0
                ENDIF
                THIS.this_dDatas     = NVL(datas, {})
                THIS.this_cAuditors  = TratarNulo(auditors, "C")
                THIS.this_dDtAudits  = NVL(dtaudits, {})
                IF VARTYPE(qtds) = "N"
                    THIS.this_nQtds  = NVL(qtds, 0)
                ELSE
                    THIS.this_nQtds  = 0
                ENDIF
                THIS.this_cOpers     = TratarNulo(opers, "C")
                IF VARTYPE(sqtds) = "N"
                    THIS.this_nSQtds = NVL(sqtds, 0)
                ELSE
                    THIS.this_nSQtds = 0
                ENDIF
                THIS.this_cObs       = TratarNulo(obs, "C")
                THIS.this_cUsuars    = TratarNulo(usuars, "C")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                IF VARTYPE(pesos) = "N"
                    THIS.this_nPesos = NVL(pesos, 0)
                ELSE
                    THIS.this_nPesos = 0
                ENDIF
                IF TYPE(loc_cAlias + ".spesos") != "U"
                    IF VARTYPE(spesos) = "N"
                        THIS.this_nSPesos = NVL(spesos, 0)
                    ELSE
                        THIS.this_nSPesos = 0
                    ENDIF
                ENDIF
                IF TYPE(loc_cAlias + ".cunis") != "U"
                    THIS.this_cCunis = TratarNulo(cunis, "C")
                ENDIF
                THIS.this_lTemAuditoria = (NOT EMPTY(ALLTRIM(THIS.this_cAuditors)))
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDoCursor]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Este form eh OPERACIONAL de leitura (historico de produtos).
    * Registros em SigMvHst sao gerados por movimentacoes de outros modulos,
    * NUNCA inseridos manualmente por este cadastro. Assim, Inserir() bloqueia
    * a operacao e retorna .F., garantindo que o form Salvar() (chamado pela
    * FormBase por engano) nao corrompa o historico.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + " permitido incluir registros no hist" + CHR(243) + "rico de produtos. Movimenta" + CHR(231) + CHR(245) + "es s" + CHR(227) + "o geradas pelos m" + CHR(243) + "dulos operacionais."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvHst dos campos de auditoria (auditors/dtaudits).
    * Aplica ou remove marca de auditor conforme this_lTemAuditoria.
    * Registra evento em LogAuditoria via RegistrarAuditoria("UPDATE").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nQueryOk, loc_cUsuario, loc_cChave
        loc_lSucesso = .F.
        TRY
            loc_cChave = ALLTRIM(THIS.this_cCidChaves)
            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Nenhum registro selecionado para atualizar."
            ELSE
                loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

                IF THIS.this_lTemAuditoria
                    *-- Marcar como auditado pelo usuario logado
                    loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(loc_cUsuario) + ;
                               ", dtaudits = GETDATE() " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                ELSE
                    *-- Remover marca de auditoria
                    loc_cSQL = "UPDATE SigMvHst SET auditors = '          ', dtaudits = NULL " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                ENDIF

                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar auditoria do hist" + CHR(243) + "rico."
                ELSE
                    *-- Sincronizar cursor local + props
                    IF USED("cursor_4c_Historico")
                        SELECT cursor_4c_Historico
                        IF THIS.this_lTemAuditoria
                            REPLACE auditors WITH loc_cUsuario, dtaudits WITH DATETIME()
                            THIS.this_cAuditors = loc_cUsuario
                            THIS.this_dDtAudits = DATETIME()
                        ELSE
                            REPLACE auditors WITH SPACE(10), dtaudits WITH {}
                            THIS.this_cAuditors = ""
                            THIS.this_dDtAudits = {}
                        ENDIF
                    ENDIF
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " [Atualizar]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override com GETDATE() nativo do SQL Server.
    * Regra: NUNCA usar GETDATE() em campo DataHora
    * (rejeita tipo T, gera INSERT NULL em NOT NULL). Lesson 2026-07-08.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario
        loc_cChave = THIS.ObterChavePrimaria()
        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF
        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")
        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"
        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarHistorico
    *-- Carrega SigMvHst para cursor_4c_Historico conforme parametros do form pai
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL, loc_cEmpGruEst, loc_cDtIni, loc_cDtFim
        loc_lSucesso = .F.
        TRY
            loc_cEmpGruEst = THIS.this_cCodEmpresa + THIS.this_cCdGrupo + THIS.this_cCdConta
            loc_cDtIni     = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDtFim     = FormatarDataSQL(THIS.this_dDataFim)

            loc_cSQL = "SELECT a.emps, a.empos, a.grupos, a.estos, a.cpros, " + ;
                       "a.dopes, a.numes, a.datas, a.auditors, a.dtaudits, " + ;
                       "a.qtds, a.opers, a.sqtds, a.obs, a.usuars, " + ;
                       "a.cidchaves, a.pesos, a.spesos, '   ' AS cunis " + ;
                       "FROM SigMvHst a " + ;
                       "WHERE a.empgruests = " + EscaparSQL(loc_cEmpGruEst) + ;
                       " AND a.cpros = " + EscaparSQL(THIS.this_cCdProduto) + ;
                       " AND CAST(a.datas AS DATE) >= " + loc_cDtIni + ;
                       " AND CAST(a.datas AS DATE) <= " + loc_cDtFim + ;
                       " ORDER BY a.emps, a.grupos, a.estos, a.cidchaves, a.opers"

            IF USED("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar hist" + CHR(243) + "rico de produtos.", "Erro")
            ELSE
                SELECT cursor_4c_Historico
                ZAP
                APPEND FROM DBF("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp

                THIS.CarregarDadosProduto()

                IF NOT EMPTY(ALLTRIM(THIS.this_cCunis))
                    SELECT cursor_4c_Historico
                    REPLACE ALL cunis WITH THIS.this_cCunis
                ENDIF

                SELECT cursor_4c_Historico
                INDEX ON DTOS(datas) TAG datas
                INDEX ON pesos TAG pesos
                GO BOTTOM

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarHistorico]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosProduto
    *-- Carrega SigCdPro e SigCdUni para o produto corrente
    *-- Preenche this_cCunis, this_cCunips, this_cCestos, this_lEhPeso
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT cpros, cunis, cunips FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(THIS.this_cCdProduto), "cursor_4c_TmpPro")
            IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                SELECT cursor_4c_TmpPro
                GO TOP
                THIS.this_cCunis  = NVL(cursor_4c_TmpPro.cunis, "")
                THIS.this_cCunips = NVL(cursor_4c_TmpPro.cunips, "")
            ELSE
                THIS.this_cCunis  = ""
                THIS.this_cCunips = ""
            ENDIF
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF

            THIS.this_cCestos = ""
            IF NOT EMPTY(ALLTRIM(THIS.this_cCunis))
                IF USED("cursor_4c_TmpUni")
                    USE IN cursor_4c_TmpUni
                ENDIF
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT Cestos FROM SigCdUni WHERE cunis = " + ;
                    EscaparSQL(THIS.this_cCunis), "cursor_4c_TmpUni")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpUni") AND RECCOUNT("cursor_4c_TmpUni") > 0
                    SELECT cursor_4c_TmpUni
                    GO TOP
                    THIS.this_cCestos = NVL(cursor_4c_TmpUni.Cestos, "")
                ENDIF
                IF USED("cursor_4c_TmpUni")
                    USE IN cursor_4c_TmpUni
                ENDIF
            ENDIF

            THIS.this_lEhPeso = (THIS.this_cCestos = "3")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDadosProduto]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosLinhaSelecionada
    *-- Copia dados do registro corrente de cursor_4c_Historico para props this_*
    *-- Chamado pelo form apos AfterRowColChange
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
                SELECT cursor_4c_Historico
                THIS.this_cEmps      = NVL(cursor_4c_Historico.emps, "")
                THIS.this_cEmpos     = NVL(cursor_4c_Historico.empos, "")
                THIS.this_cGrupos    = NVL(cursor_4c_Historico.grupos, "")
                THIS.this_cEstos     = NVL(cursor_4c_Historico.estos, "")
                THIS.this_cCpros     = NVL(cursor_4c_Historico.cpros, "")
                THIS.this_cDopes     = NVL(cursor_4c_Historico.dopes, "")
                THIS.this_nNumes     = NVL(cursor_4c_Historico.numes, 0)
                THIS.this_dDatas     = NVL(cursor_4c_Historico.datas, {})
                THIS.this_cAuditors  = NVL(cursor_4c_Historico.auditors, "")
                THIS.this_dDtAudits  = NVL(cursor_4c_Historico.dtaudits, {})
                THIS.this_nQtds      = NVL(cursor_4c_Historico.qtds, 0)
                THIS.this_cOpers     = NVL(cursor_4c_Historico.opers, "")
                THIS.this_nSQtds     = NVL(cursor_4c_Historico.sqtds, 0)
                THIS.this_cObs       = NVL(cursor_4c_Historico.obs, "")
                THIS.this_cUsuars    = NVL(cursor_4c_Historico.usuars, "")
                THIS.this_cCidChaves = NVL(cursor_4c_Historico.cidchaves, "")
                THIS.this_nPesos     = NVL(cursor_4c_Historico.pesos, 0)
                THIS.this_nSPesos    = NVL(cursor_4c_Historico.spesos, 0)
                THIS.this_cCunis     = NVL(cursor_4c_Historico.cunis, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDadosLinhaSelecionada]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDocumento
    *-- Carrega documento (SigMvCab ou SigCdNec) do registro corrente
    *-- Tenta SigMvCab primeiro (empdopnums); se vazio, tenta SigCdNec (empdnps)
    *-- Preenche this_cGrupoOri, this_cContaOri, this_cGrupoDes, this_cContaDes, this_cNotas
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cEmpsEfetivo
        LOCAL loc_cEmpDopNum, loc_cEmpDopNumLong
        loc_lSucesso = .F.
        TRY
            THIS.this_cGrupoOri = ""
            THIS.this_cContaOri = ""
            THIS.this_cGrupoDes = ""
            THIS.this_cContaDes = ""
            THIS.this_cNotas    = ""

            loc_cEmpsEfetivo   = IIF(NOT EMPTY(ALLTRIM(THIS.this_cEmpos)), THIS.this_cEmpos, THIS.this_cEmps)
            loc_cEmpDopNum     = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
            loc_cEmpDopNumLong = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 10)

            IF USED("cursor_4c_DocTemp")
                USE IN cursor_4c_DocTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT grupoos, contaos, grupods, contads, Notas " + ;
                "FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNum), ;
                "cursor_4c_DocTemp")

            IF loc_nQueryOk >= 1 AND USED("cursor_4c_DocTemp") AND RECCOUNT("cursor_4c_DocTemp") = 0
                USE IN cursor_4c_DocTemp
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT grupoos, contaos, grupods, contads, '      ' AS Notas " + ;
                    "FROM SigCdNec " + ;
                    "WHERE empdnps = " + EscaparSQL(loc_cEmpDopNumLong), ;
                    "cursor_4c_DocTemp")
            ENDIF

            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar documento do movimento.", "Erro")
            ELSE
                IF USED("cursor_4c_DocTemp") AND RECCOUNT("cursor_4c_DocTemp") > 0
                    SELECT cursor_4c_DocTemp
                    GO TOP
                    THIS.this_cGrupoOri = NVL(cursor_4c_DocTemp.grupoos, "")
                    THIS.this_cContaOri = NVL(cursor_4c_DocTemp.contaos, "")
                    THIS.this_cGrupoDes = NVL(cursor_4c_DocTemp.grupods, "")
                    THIS.this_cContaDes = NVL(cursor_4c_DocTemp.contads, "")
                    THIS.this_cNotas    = NVL(cursor_4c_DocTemp.Notas, "")
                ENDIF
                IF USED("cursor_4c_DocTemp")
                    USE IN cursor_4c_DocTemp
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDocumento]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricoesContabil
    *-- Carrega descricoes de grupos (SigCdGcr) e contas (SigCdCli)
    *-- Preenche this_cDesGrupoOri/Des e this_cDesContaOri/Des
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk
        LOCAL loc_cGruOri, loc_cConOri, loc_cGruDes, loc_cConDes
        loc_lSucesso = .F.
        TRY
            loc_cGruOri = THIS.this_cGrupoOri
            loc_cConOri = THIS.this_cContaOri
            loc_cGruDes = THIS.this_cGrupoDes
            loc_cConDes = THIS.this_cContaDes

            THIS.this_cDesGrupoOri = ""
            THIS.this_cDesContaOri = ""
            THIS.this_cDesGrupoDes = ""
            THIS.this_cDesContaDes = ""

            *-- Grupos via SigCdGcr (coluna descrs COM r)
            IF USED("cursor_4c_TmpGcr")
                USE IN cursor_4c_TmpGcr
            ENDIF
            IF NOT EMPTY(ALLTRIM(loc_cGruOri)) OR NOT EMPTY(ALLTRIM(loc_cGruDes))
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descrs FROM SigCdGcr " + ;
                    "WHERE codigos = " + EscaparSQL(loc_cGruOri) + ;
                    " OR codigos = " + EscaparSQL(loc_cGruDes), ;
                    "cursor_4c_TmpGcr")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpGcr") AND RECCOUNT("cursor_4c_TmpGcr") > 0
                    SELECT cursor_4c_TmpGcr
                    INDEX ON codigos TAG codigos
                    GO TOP
                    THIS.this_cDesGrupoOri = IIF(SEEK(loc_cGruOri, "cursor_4c_TmpGcr", "codigos"), NVL(cursor_4c_TmpGcr.descrs, ""), "")
                    THIS.this_cDesGrupoDes = IIF(SEEK(loc_cGruDes, "cursor_4c_TmpGcr", "codigos"), NVL(cursor_4c_TmpGcr.descrs, ""), "")
                ENDIF
                IF USED("cursor_4c_TmpGcr")
                    USE IN cursor_4c_TmpGcr
                ENDIF
            ENDIF

            *-- Contas via SigCdCli
            IF USED("cursor_4c_TmpCli")
                USE IN cursor_4c_TmpCli
            ENDIF
            IF NOT EMPTY(ALLTRIM(loc_cConOri)) OR NOT EMPTY(ALLTRIM(loc_cConDes))
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT iclis, rclis FROM SigCdCli " + ;
                    "WHERE iclis = " + EscaparSQL(loc_cConOri) + ;
                    " OR iclis = " + EscaparSQL(loc_cConDes), ;
                    "cursor_4c_TmpCli")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                    SELECT cursor_4c_TmpCli
                    INDEX ON iclis TAG iclis
                    GO TOP
                    THIS.this_cDesContaOri = IIF(SEEK(loc_cConOri, "cursor_4c_TmpCli", "iclis"), NVL(cursor_4c_TmpCli.rclis, ""), "")
                    THIS.this_cDesContaDes = IIF(SEEK(loc_cConDes, "cursor_4c_TmpCli", "iclis"), NVL(cursor_4c_TmpCli.rclis, ""), "")
                ENDIF
                IF USED("cursor_4c_TmpCli")
                    USE IN cursor_4c_TmpCli
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDescricoesContabil]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubniveis
    *-- Carrega SigMvPec para cursor_4c_Subniveis do registro corrente
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cEdn, loc_cSQL
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Subniveis
            ZAP

            loc_cEdn = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)

            loc_cSQL = "SELECT a.EmpSubns AS Emps, b.Dopes, " + ;
                       "RIGHT(STR(a.Codigos, 10), 6) AS Numes " + ;
                       "FROM SigMvPec a, SigCdOpe b " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                       " AND LEFT(STR(a.Codigos, 10), 4) = STR(b.NDopes, 4) " + ;
                       "ORDER BY 1, 2, 3"

            IF USED("cursor_4c_SubniveisTemp")
                USE IN cursor_4c_SubniveisTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubniveisTemp")
            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar subniveis.", "Erro")
            ELSE
                IF USED("cursor_4c_SubniveisTemp") AND RECCOUNT("cursor_4c_SubniveisTemp") > 0
                    SELECT cursor_4c_SubniveisTemp
                    SCAN
                        INSERT INTO cursor_4c_Subniveis (emps, dopes, numes) ;
                            VALUES (cursor_4c_SubniveisTemp.Emps, ;
                                    cursor_4c_SubniveisTemp.Dopes, ;
                                    VAL(cursor_4c_SubniveisTemp.Numes))
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_SubniveisTemp")
                    USE IN cursor_4c_SubniveisTemp
                ENDIF
                SELECT cursor_4c_Subniveis
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarSubniveis]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AuditarRegistro
    *-- Marca registro corrente como auditado pelo usuario logado em SigMvHst
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro selecionado para auditar.", "Auditoria")
            ELSE
                loc_cSQL = "UPDATE SigMvHst SET auditors = " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    MsgErro("Falha ao registrar auditor.", "Erro de Auditoria")
                ELSE
                    loc_cSQL = "UPDATE SigMvHst SET dtaudits = GETDATE() " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                    IF loc_nQueryOk < 1
                        MsgErro("Falha ao registrar data de auditoria.", "Erro de Auditoria")
                    ELSE
                        IF USED("cursor_4c_Historico")
                            SELECT cursor_4c_Historico
                            REPLACE auditors WITH gc_4c_UsuarioLogado
                            REPLACE dtaudits WITH DATETIME()
                        ENDIF
                        THIS.this_cAuditors = gc_4c_UsuarioLogado
                        THIS.this_dDtAudits = DATETIME()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [AuditarRegistro]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE DesauditarRegistro
    *-- Remove marca de auditoria do registro corrente em SigMvHst
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro selecionado.", "Auditoria")
            ELSE
                loc_cSQL = "UPDATE SigMvHst SET auditors = '          ' " + ;
                           "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    MsgErro("Falha ao remover auditor.", "Erro de Auditoria")
                ELSE
                    loc_cSQL = "UPDATE SigMvHst SET dtaudits = NULL " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                    IF loc_nQueryOk < 1
                        MsgErro("Falha ao remover data de auditoria.", "Erro de Auditoria")
                    ELSE
                        IF USED("cursor_4c_Historico")
                            SELECT cursor_4c_Historico
                            REPLACE auditors WITH SPACE(10)
                            REPLACE dtaudits WITH {}
                        ENDIF
                        THIS.this_cAuditors = ""
                        THIS.this_dDtAudits = {}
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [DesauditarRegistro]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE VerificarPermissaoAuditoria
    *-- Retorna .T. se o usuario logado pode auditar o registro corrente
    *-- Supervisor (4CONTROL) sempre pode; outros: apenas registros sem auditor
    *-- ou registros que o proprio usuario auditou
    *--------------------------------------------------------------------------
        LOCAL loc_lPermitido, loc_lSupervisor
        loc_lPermitido  = .F.
        TRY
            loc_lSupervisor = (UPPER(ALLTRIM(gc_4c_UsuarioLogado)) = "4CONTROL")
            IF loc_lSupervisor
                loc_lPermitido = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cAuditors))
                    loc_lPermitido = .T.
                ELSE
                    IF UPPER(ALLTRIM(gc_4c_UsuarioLogado)) = UPPER(ALLTRIM(THIS.this_cAuditors))
                        loc_lPermitido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [VerificarPermissaoAuditoria]", "Erro")
        ENDTRY
        RETURN loc_lPermitido
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE VerificarExistenciaDocumento
    *-- Verifica se existe documento para o registro corrente
    *-- Retorna "MOVCAB" se em SigMvCab, "NEC" se em SigCdNec, "" se nao encontrou
    *--------------------------------------------------------------------------
        LOCAL loc_cTipoDoc, loc_nQueryOk, loc_cEmpsEfetivo
        LOCAL loc_cEmpDopNum, loc_cEmpDopNumLong
        loc_cTipoDoc = ""
        TRY
            IF NOT (EMPTY(ALLTRIM(THIS.this_cEmps)) OR EMPTY(ALLTRIM(THIS.this_cDopes)) OR THIS.this_nNumes = 0)
                loc_cEmpsEfetivo   = IIF(NOT EMPTY(ALLTRIM(THIS.this_cEmpos)), THIS.this_cEmpos, THIS.this_cEmps)
                loc_cEmpDopNum     = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
                loc_cEmpDopNumLong = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 10)

                IF USED("cursor_4c_TmpChk")
                    USE IN cursor_4c_TmpChk
                ENDIF
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
                    EscaparSQL(loc_cEmpDopNum), "cursor_4c_TmpChk")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpChk") AND RECCOUNT("cursor_4c_TmpChk") > 0
                    SELECT cursor_4c_TmpChk
                    IF NVL(cursor_4c_TmpChk.nExiste, 0) > 0
                        loc_cTipoDoc = "MOVCAB"
                    ENDIF
                ENDIF
                IF USED("cursor_4c_TmpChk")
                    USE IN cursor_4c_TmpChk
                ENDIF

                IF EMPTY(loc_cTipoDoc)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                        "SELECT COUNT(*) AS nExiste FROM SigCdNec WHERE EmpDnPs = " + ;
                        EscaparSQL(loc_cEmpDopNumLong), "cursor_4c_TmpChk")
                    IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpChk") AND RECCOUNT("cursor_4c_TmpChk") > 0
                        SELECT cursor_4c_TmpChk
                        IF NVL(cursor_4c_TmpChk.nExiste, 0) > 0
                            loc_cTipoDoc = "NEC"
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_TmpChk")
                        USE IN cursor_4c_TmpChk
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [VerificarExistenciaDocumento]", "Erro")
        ENDTRY
        RETURN loc_cTipoDoc
    ENDPROC

ENDDEFINE

