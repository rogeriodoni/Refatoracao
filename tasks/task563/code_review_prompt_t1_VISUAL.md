# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 280: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCMV.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1333 linhas total):

*-- Linhas 113 a 160:
113:         TRY
114:             THIS.AddObject("cnt_4c_Sombra", "Container")
115:             WITH THIS.cnt_4c_Sombra
116:                 .Top         = 0
117:                 .Left        = 0
118:                 .Width       = THIS.Width
119:                 .Height      = 80
120:                 .BackColor   = RGB(100, 100, 100)
121:                 .BackStyle   = 1
122:                 .BorderWidth = 0
123: 
124:                 .AddObject("lbl_4c_LblSombra", "Label")
125:                 WITH .lbl_4c_LblSombra
126:                     .Top       = 18
127:                     .Left      = 10
128:                     .Width     = THIS.Width
129:                     .Height    = 40
130:                     .FontBold  = .T.
131:                     .FontName  = "Tahoma"
132:                     .FontSize  = 18
133:                     .AutoSize  = .F.
134:                     .WordWrap  = .T.
135:                     .Alignment = 0
136:                     .BackStyle = 0
137:                     .ForeColor = RGB(0, 0, 0)
138:                     .Caption   = THIS.Caption
139:                 ENDWITH
140: 
141:                 .AddObject("lbl_4c_LblTitulo", "Label")
142:                 WITH .lbl_4c_LblTitulo
143:                     .Top       = 17
144:                     .Left      = 10
145:                     .Width     = THIS.Width
146:                     .Height    = 46
147:                     .FontBold  = .T.
148:                     .FontName  = "Tahoma"
149:                     .FontSize  = 18
150:                     .AutoSize  = .F.
151:                     .WordWrap  = .T.
152:                     .Alignment = 0
153:                     .BackStyle = 0
154:                     .ForeColor = RGB(255, 255, 255)
155:                     .Caption   = THIS.Caption
156:                 ENDWITH
157: 
158:                 .Visible = .T.
159:             ENDWITH
160: 

*-- Linhas 230 a 259:
230:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
231:         THIS.AddObject("shp_4c_Shape1", "Shape")
232:         WITH THIS.shp_4c_Shape1
233:             .Top           = -2
234:             .Left          = 644
235:             .Height        = 37
236:             .Width         = 52
237:             .BackStyle     = 0
238:             .BorderStyle   = 0
239:             .SpecialEffect = 1
240:             .BorderColor   = RGB(136, 189, 188)
241:             .Visible       = .T.
242:         ENDWITH
243: 
244:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
245:         WITH THIS.cmd_4c_Processa
246:             .Top             = 3
247:             .Left            = 649
248:             .Height          = 75
249:             .Width           = 75
250:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
251:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
252:             .Caption         = "\<Processar"
253:             .FontName        = "Comic Sans MS"
254:             .FontBold        = .T.
255:             .FontItalic      = .T.
256:             .FontSize        = 8
257:             .ForeColor       = RGB(90, 90, 90)
258:             .BackColor       = RGB(255, 255, 255)
259:             .Themes          = .T.

*-- Linhas 265 a 286:
265:             .TabIndex        = 14
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
269: 
270:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
271:         WITH THIS.cmd_4c_Cancela
272:             .Top             = 3
273:             .Left            = 724
274:             .Height          = 75
275:             .Width           = 75
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
277:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
278:             .Cancel          = .T.
279:             .Caption         = "Encerrar"
280:             .FontName        = "Comic Sans MS"
281:             .FontBold        = .T.
282:             .FontItalic      = .T.
283:             .FontSize        = 8
284:             .ForeColor       = RGB(90, 90, 90)
285:             .BackColor       = RGB(255, 255, 255)
286:             .Themes          = .T.

*-- Linhas 292 a 300:
292:             .TabIndex        = 15
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
296:     ENDPROC
297: 
298:     *==========================================================================
299:     * ConfigurarCamposPeriodoMoeda - Primeira metade dos campos de filtro
300:     * (Fase 5/8): grupo Periodo (getDtInicial/getDtFinal/Say1/Say6) e grupo

*-- Linhas 306 a 400:
306:     *==========================================================================
307:     PROTECTED PROCEDURE ConfigurarCamposPeriodoMoeda()
308:         *-- Say1 "Periodo :"
309:         THIS.AddObject("lbl_4c_Label1", "Label")
310:         WITH THIS.lbl_4c_Label1
311:             .Top       = 92
312:             .Left      = 99
313:             .Width     = 60
314:             .Height    = 17
315:             .FontName  = "Tahoma"
316:             .FontSize  = 8
317:             .Alignment = 0
318:             .BackStyle = 0
319:             .ForeColor = RGB(90, 90, 90)
320:             .Caption   = "Per" + CHR(237) + "odo :"
321:             .TabIndex  = 1
322:             .Visible   = .T.
323:         ENDWITH
324: 
325:         *-- getDtInicial
326:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
327:         WITH THIS.txt_4c_DtInicial
328:             .Top           = 88
329:             .Left          = 154
330:             .Width         = 80
331:             .Height        = 23
332:             .FontName      = "Tahoma"
333:             .FontSize      = 8
334:             .SpecialEffect = 1
335:             .BorderColor   = RGB(36, 84, 155)
336:             .Value         = {}
337:             .TabIndex      = 2
338:             .Visible       = .T.
339:         ENDWITH
340: 
341:         *-- Say6 "ate"
342:         THIS.AddObject("lbl_4c_Label6", "Label")
343:         WITH THIS.lbl_4c_Label6
344:             .Top       = 92
345:             .Left      = 242
346:             .Width     = 25
347:             .Height    = 17
348:             .FontName  = "Tahoma"
349:             .FontSize  = 8
350:             .Alignment = 0
351:             .BackStyle = 0
352:             .ForeColor = RGB(90, 90, 90)
353:             .Caption   = "at" + CHR(233)
354:             .TabIndex  = 3
355:             .Visible   = .T.
356:         ENDWITH
357: 
358:         *-- getDtFinal
359:         THIS.AddObject("txt_4c_DtFinal", "TextBox")
360:         WITH THIS.txt_4c_DtFinal
361:             .Top           = 88
362:             .Left          = 268
363:             .Width         = 80
364:             .Height        = 23
365:             .FontName      = "Tahoma"
366:             .FontSize      = 8
367:             .SpecialEffect = 1
368:             .BorderColor   = RGB(36, 84, 155)
369:             .Value         = {}
370:             .TabIndex      = 4
371:             .Visible       = .T.
372:         ENDWITH
373: 
374:         *-- lbl_moeda "Moeda para Conversao:"
375:         THIS.AddObject("lbl_4c_Lbl_moeda", "Label")
376:         WITH THIS.lbl_4c_Lbl_moeda
377:             .Top       = 142
378:             .Left      = 26
379:             .Width     = 155
380:             .Height    = 17
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .Alignment = 0
384:             .BackStyle = 0
385:             .ForeColor = RGB(90, 90, 90)
386:             .Caption   = "Moeda para Convers" + CHR(227) + "o:"
387:             .TabIndex  = 8
388:             .Visible   = .T.
389:         ENDWITH
390: 
391:         *-- get_cd_moeda (codigo da moeda de conversao, lookup F4 na Fase 7/8)
392:         THIS.AddObject("txt_4c__cd_moeda", "TextBox")
393:         WITH THIS.txt_4c__cd_moeda
394:             .Top           = 138
395:             .Left          = 154
396:             .Width         = 31
397:             .Height        = 23
398:             .FontName      = "Tahoma"
399:             .FontSize      = 8
400:             .MaxLength     = 3

*-- Linhas 409 a 418:
409:         *-- get_ds_moeda (descricao da moeda, preenchida pelo lookup na Fase 7/8)
410:         THIS.AddObject("txt_4c__ds_moeda", "TextBox")
411:         WITH THIS.txt_4c__ds_moeda
412:             .Top           = 138
413:             .Left          = 187
414:             .Width         = 115
415:             .Height        = 23
416:             .FontName      = "Tahoma"
417:             .FontSize      = 8
418:             .MaxLength     = 15

*-- Linhas 440 a 468:
440:     *==========================================================================
441:     PROTECTED PROCEDURE ConfigurarCamposEmpresaOperacao()
442:         *-- lbl_empresa "Empresa :"
443:         THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
444:         WITH THIS.lbl_4c_Lbl_empresa
445:             .Top       = 118
446:             .Left      = 94
447:             .Width     = 50
448:             .Height    = 17
449:             .FontName  = "Tahoma"
450:             .FontSize  = 8
451:             .Alignment = 0
452:             .BackStyle = 0
453:             .ForeColor = RGB(90, 90, 90)
454:             .Caption   = "Empresa :"
455:             .TabIndex  = 5
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *-- getEmpresa (codigo da empresa, lookup em SigCdEmp.cemps)
460:         THIS.AddObject("txt_4c_Empresa", "TextBox")
461:         WITH THIS.txt_4c_Empresa
462:             .Top           = 113
463:             .Left          = 154
464:             .Width         = 31
465:             .Height        = 23
466:             .FontName      = "Tahoma"
467:             .FontSize      = 8
468:             .MaxLength     = 3

*-- Linhas 477 a 486:
477:         *-- getDEmpresa (razao social da empresa, preenchida pelo lookup)
478:         THIS.AddObject("txt_4c_DEmpresa", "TextBox")
479:         WITH THIS.txt_4c_DEmpresa
480:             .Top           = 113
481:             .Left          = 187
482:             .Width         = 339
483:             .Height        = 23
484:             .FontName      = "Tahoma"
485:             .FontSize      = 8
486:             .MaxLength     = 40

*-- Linhas 495 a 514:
495:         BINDEVENT(THIS.txt_4c_DEmpresa, "KeyPress", THIS, "ValidarDEmpresa")
496: 
497:         *-- lbl_operacao "Operacao :" (antecede a grade de selecao)
498:         THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
499:         WITH THIS.lbl_4c_Lbl_operacao
500:             .Top       = 167
501:             .Left      = 88
502:             .Width     = 56
503:             .Height    = 17
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .Alignment = 0
507:             .BackStyle = 0
508:             .ForeColor = RGB(90, 90, 90)
509:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
510:             .TabIndex  = 11
511:             .Visible   = .T.
512:         ENDWITH
513:     ENDPROC
514: 

*-- Linhas 520 a 561:
520:     PROTECTED PROCEDURE ConfigurarBotoesGrade()
521:         THIS.AddObject("obj_4c_CmdBtnGrade", "CommandGroup")
522:         WITH THIS.obj_4c_CmdBtnGrade
523:             .Top         = 193
524:             .Left        = 406
525:             .Width       = 43
526:             .Height      = 91
527:             .ButtonCount = 2
528:             .BackStyle   = 0
529:             .BorderStyle = 0
530:             .Themes      = .F.
531:             .Value       = 1
532:             .TabIndex    = 13
533: 
534:             WITH .Buttons(1)
535:                 .Top         = -1
536:                 .Left        = -1
537:                 .Height      = 45
538:                 .Width       = 45
539:                 .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
540:                 .Caption     = ""
541:                 .ToolTipText = "Selecionar"
542:                 .ForeColor   = RGB(36, 84, 155)
543:                 .BackColor   = RGB(255, 255, 255)
544:                 .Themes      = .F.
545:                 .TabIndex    = 1
546:             ENDWITH
547: 
548:             WITH .Buttons(2)
549:                 .Top         = 45
550:                 .Left        = -1
551:                 .Height      = 45
552:                 .Width       = 45
553:                 .FontName    = "Verdana"
554:                 .FontSize    = 8
555:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
556:                 .Caption     = ""
557:                 .ToolTipText = "Desmarcar"
558:                 .ForeColor   = RGB(36, 84, 155)
559:                 .BackColor   = RGB(255, 255, 255)
560:                 .Themes      = .F.
561:                 .TabIndex    = 2

*-- Linhas 587 a 596:
587:             .DeleteMark        = .F.
588:             .RecordMark        = .F.
589:             .ReadOnly          = .F.
590:             .Top               = 165
591:             .Left              = 154
592:             .Width             = 247
593:             .Height            = 148
594:             .FontName          = "Tahoma"
595:             .FontSize          = 8
596:             .RowHeight         = 18

*-- Linhas 606 a 622:
606:             .Column1.Movable      = .F.
607:             .Column1.Resizable    = .F.
608: 
609:             .Column1.AddObject("chk_4c_Check1", "CheckBox")
610:             WITH .Column1.chk_4c_Check1
611:                 .Top       = 9
612:                 .Left      = 2
613:                 .Height    = 17
614:                 .Width     = 22
615:                 .FontName  = "Tahoma"
616:                 .Alignment = 0
617:                 .Caption   = ""
618:                 .Visible   = .T.
619:                 .AutoSize  = .T.
620:             ENDWITH
621:             .Column1.CurrentControl = "chk_4c_Check1"
622:             .Column1.Sparse         = .F.

*-- Linhas 1273 a 1281:
1273: 
1274:         THIS.grd_4c_Dados.Enabled          = loc_lHab
1275:         THIS.obj_4c_CmdBtnGrade.Enabled    = loc_lHab
1276:         THIS.cmd_4c_Processa.Enabled       = loc_lHab
1277: 
1278:         THIS.Refresh()
1279:     ENDPROC
1280: 
1281:     *==========================================================================

*-- Linhas 1302 a 1314:
1302:             ENDIF
1303:         ENDIF
1304: 
1305:         THIS.cmd_4c_Processa.Enabled    = loc_lTemLinhas
1306:         THIS.obj_4c_CmdBtnGrade.Enabled = loc_lTemLinhas
1307:         THIS.grd_4c_Dados.Enabled       = loc_lTemLinhas
1308: 
1309:         THIS.cmd_4c_Cancela.Enabled = .T.
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     PROCEDURE Destroy()
1314:     *==========================================================================

