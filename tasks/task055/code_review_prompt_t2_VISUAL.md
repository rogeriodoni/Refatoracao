# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (22)
- [LAYOUT-POSITION] Controle 'lbl_estoque' (parent: SIGRECMP): Top original=263 vs migrado 'lbl_4c_Lbl_estoque' Top=178 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_op' (parent: SIGRECMP): Top original=151 vs migrado 'lbl_4c_Lbl_op' Top=66 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_empresa' (parent: SIGRECMP): Top original=207 vs migrado 'lbl_4c_Lbl_empresa' Top=122 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optagrupa' (parent: SIGRECMP): Top original=391 vs migrado 'obj_4c_Optagrupa' Top=4 (diff=387px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optagrupa' (parent: SIGRECMP): Left original=100 vs migrado 'obj_4c_Optagrupa' Left=2 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptSituas' (parent: SIGRECMP): Top original=369 vs migrado 'obj_4c_OptSituas' Top=4 (diff=365px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptSituas' (parent: SIGRECMP): Left original=100 vs migrado 'obj_4c_OptSituas' Left=2 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optData' (parent: SIGRECMP): Top original=118 vs migrado 'obj_4c_OptData' Top=4 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optData' (parent: SIGRECMP): Left original=292 vs migrado 'obj_4c_OptData' Left=2 (diff=290px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_grupo' (parent: SIGRECMP): Top original=320 vs migrado 'lbl_4c_Lbl_grupo' Top=235 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGRECMP): Top original=123 vs migrado 'lbl_4c_Lbl_periodo_a' Top=38 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGRECMP): Left original=55 vs migrado 'lbl_4c_Lbl_periodo_a' Left=188 (diff=133px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo_a' (parent: SIGRECMP): Top original=123 vs migrado 'lbl_4c_Lbl_periodo_a' Top=38 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_operacao' (parent: SIGRECMP): Top original=151 vs migrado 'lbl_4c_Lbl_operacao' Top=66 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkservico' (parent: SIGRECMP): Top original=395 vs migrado 'chk_4c_Chkservico' Top=310 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkOrdem' (parent: SIGRECMP): Top original=374 vs migrado 'chk_4c_ChkOrdem' Top=289 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkPendente' (parent: SIGRECMP): Top original=374 vs migrado 'chk_4c_ChkPendente' Top=289 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkImpOp' (parent: SIGRECMP): Top original=151 vs migrado 'chk_4c_ChkImpOp' Top=66 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGRECMP): Top original=306 vs migrado 'cmd_4c_Apaga' Top=221 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'SelTudo' (parent: SIGRECMP): Top original=271 vs migrado 'cmd_4c_SelTudo' Top=186 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGRECMP): Top original=230 vs migrado 'lbl_4c_Label1_GrupoContab' Top=150 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGRECMP): Left original=511 vs migrado 'lbl_4c_Label1_GrupoContab' Left=62 (diff=449px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCmp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2716 linhas total):

*-- Linhas 44 a 52:
44:         loc_lContinuar = .T.
45: 
46:         TRY
47:             THIS.Caption = "Listagem de Composi" + CHR(231) + CHR(227) + ;
48:                            "o Por Movimenta" + CHR(231) + CHR(227) + "o/OP"
49: 
50:             IF TYPE("gc_4c_CaminhoIcones") = "U"
51:                 gc_4c_CaminhoIcones = ""
52:             ENDIF

*-- Linhas 67 a 76:
67:             IF loc_lContinuar
68:                 THIS.ConfigurarCabecalho()
69:                 THIS.ConfigurarPageFrame()
70:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
71:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
72:                 THIS.ConfigurarPaginaLista()
73:                 THIS.ConfigurarPaginaDados()
74:                 THIS.LimparCampos()
75:                 loc_lSucesso = .T.
76:             ENDIF

*-- Linhas 96 a 161:
96:         loc_oCab = THIS.cnt_4c_Cabecalho
97: 
98:         WITH loc_oCab
99:             .Top         = 0
100:             .Left        = 0
101:             .Width       = THIS.Width
102:             .Height      = 80
103:             .BackStyle   = 1
104:             .BackColor   = RGB(100, 100, 100)
105:             .BorderWidth = 0
106:             .Visible     = .T.
107: 
108:             .AddObject("lbl_4c_Sombra", "Label")
109:             WITH .lbl_4c_Sombra
110:                 .Top       = 22
111:                 .Left      = 22
112:                 .Width     = THIS.Width
113:                 .Height    = 30
114:                 .Caption   = THIS.Caption
115:                 .FontName  = "Tahoma"
116:                 .FontSize  = 14
117:                 .FontBold  = .T.
118:                 .ForeColor = RGB(0, 0, 0)
119:                 .BackStyle = 0
120:                 .Visible   = .T.
121:             ENDWITH
122: 
123:             .AddObject("lbl_4c_Titulo", "Label")
124:             WITH .lbl_4c_Titulo
125:                 .Top       = 20
126:                 .Left      = 20
127:                 .Width     = THIS.Width
128:                 .Height    = 30
129:                 .Caption   = THIS.Caption
130:                 .FontName  = "Tahoma"
131:                 .FontSize  = 14
132:                 .FontBold  = .T.
133:                 .ForeColor = RGB(255, 255, 255)
134:                 .BackStyle = 0
135:                 .Visible   = .T.
136:             ENDWITH
137: 
138:             .AddObject("cmg_4c_Botoes", "CommandGroup")
139:             WITH .cmg_4c_Botoes
140:                 .Top           = 3
141:                 .Left          = 526
142:                 .Width         = THIS.Width
143:                 .Height        = 76
144:                 .ButtonCount   = 4
145:                 .BackStyle     = 0
146:                 .BorderColor   = RGB(136, 189, 188)
147:                 .SpecialEffect = 1
148:                 .Themes        = .F.
149:                 .Visible       = .T.
150: 
151:                 WITH .Buttons(1)
152:                     .Top             = 2
153:                     .Left            = 6
154:                     .Width           = THIS.Width
155:                     .Height          = 72
156:                     .Caption         = "Visualizar"
157:                     .FontBold        = .T.
158:                     .FontItalic      = .T.
159:                     .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
160:                     .PicturePosition = 13
161:                     .Themes          = .F.

*-- Linhas 167 a 179:
167:                 ENDWITH
168: 
169:                 WITH .Buttons(2)
170:                     .Top             = 2
171:                     .Left            = 72
172:                     .Width           = THIS.Width
173:                     .Height          = 72
174:                     .Caption         = "Imprimir"
175:                     .FontName        = "Tahoma"
176:                     .FontBold        = .T.
177:                     .FontItalic      = .T.
178:                     .FontSize        = 8
179:                     .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"

*-- Linhas 187 a 199:
187:                 ENDWITH
188: 
189:                 WITH .Buttons(3)
190:                     .Top             = 2
191:                     .Left            = 138
192:                     .Width           = THIS.Width
193:                     .Height          = 72
194:                     .Caption         = "Excel"
195:                     .FontName        = "Tahoma"
196:                     .FontBold        = .T.
197:                     .FontItalic      = .T.
198:                     .FontSize        = 8
199:                     .Picture         = gc_4c_CaminhoIcones + "excel.jpg"

*-- Linhas 207 a 219:
207:                 ENDWITH
208: 
209:                 WITH .Buttons(4)
210:                     .Top             = 2
211:                     .Left            = 204
212:                     .Width           = THIS.Width
213:                     .Height          = 72
214:                     .Caption         = "Encerrar"
215:                     .Cancel          = .T.
216:                     .FontName        = "Tahoma"
217:                     .FontBold        = .T.
218:                     .FontItalic      = .T.
219:                     .FontSize        = 8

*-- Linhas 247 a 261:
247:         loc_oPgf = THIS.pgf_4c_Paginas
248: 
249:         loc_oPgf.PageCount = 1
250:         loc_oPgf.Top       = 85
251:         loc_oPgf.Left      = -1
252:         loc_oPgf.Width     = THIS.Width + 2
253:         loc_oPgf.Height    = THIS.Height - 85
254:         loc_oPgf.Tabs      = .F.
255: 
256:         loc_oPgf.Page1.Caption   = "Filtros"
257:         loc_oPgf.Page1.FontName  = "Tahoma"
258:         loc_oPgf.Page1.FontSize  = 8
259:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
260:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
261:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 271 a 282:
271:     *   - Observacao, Empresa
272:     *   - Grupo Estoque / Conta
273:     *   - Grande Grupo, Grupo Produto, Subgrupo
274:     *   - Situacao (optSituas), Agrupamento (optagrupa), checkboxes
275:     *   - Grid grd_4c_Dados (tipos de movimentacao com checkboxes)
276:     *   - Botoes SelTudo e Apaga
277:     * Posicoes: Top original - 85 (PageFrame.Top=85)
278:     *==========================================================================
279:     PROTECTED PROCEDURE ConfigurarPaginaLista()
280:         LOCAL loc_oPagina, loc_oGrid, loc_oErro
281:         TRY
282:             loc_oPagina = THIS.pgf_4c_Paginas.Page1

*-- Linhas 297 a 352:
297:             ENDIF
298: 
299:             *-- ===== ROW 1: PERIODO =====
300:             loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
301:             WITH loc_oPagina.lbl_4c_Lbl_periodo
302:                 .Top       = 38
303:                 .Left      = 55
304:                 .Width     = 45
305:                 .Height    = 18
306:                 .Caption   = "Per" + CHR(237) + "odo :"
307:                 .FontName  = "Tahoma"
308:                 .FontSize  = 8
309:                 .ForeColor = RGB(90, 90, 90)
310:                 .BackStyle = 0
311:                 .Visible   = .T.
312:             ENDWITH
313: 
314:             loc_oPagina.AddObject("txt_4c__dt_inicial", "TextBox")
315:             WITH loc_oPagina.txt_4c__dt_inicial
316:                 .Top           = 33
317:                 .Left          = 104
318:                 .Width         = 80
319:                 .Height        = 25
320:                 .Value         = DATE()
321:                 .InputMask     = "99/99/9999"
322:                 .FontName      = "Tahoma"
323:                 .FontSize      = 8
324:                 .ForeColor     = RGB(90, 90, 90)
325:                 .BackColor     = RGB(255, 255, 255)
326:                 .SpecialEffect = 0
327:                 .Visible       = .T.
328:             ENDWITH
329: 
330:             loc_oPagina.AddObject("lbl_4c_Lbl_periodo_a", "Label")
331:             WITH loc_oPagina.lbl_4c_Lbl_periodo_a
332:                 .Top       = 38
333:                 .Left      = 188
334:                 .Width     = 18
335:                 .Height    = 18
336:                 .Caption   = "at" + CHR(233)
337:                 .FontName  = "Tahoma"
338:                 .FontSize  = 8
339:                 .ForeColor = RGB(90, 90, 90)
340:                 .BackStyle = 0
341:                 .Visible   = .T.
342:             ENDWITH
343: 
344:             loc_oPagina.AddObject("txt_4c__dt_final", "TextBox")
345:             WITH loc_oPagina.txt_4c__dt_final
346:                 .Top           = 33
347:                 .Left          = 212
348:                 .Width         = 80
349:                 .Height        = 25
350:                 .Value         = DATE()
351:                 .InputMask     = "99/99/9999"
352:                 .FontName      = "Tahoma"

*-- Linhas 359 a 417:
359: 
360:             loc_oPagina.AddObject("obj_4c_OptData", "OptionGroup")
361:             WITH loc_oPagina.obj_4c_OptData
362:                 .Top         = 33
363:                 .Left        = 292
364:                 .Width       = 185
365:                 .Height      = 25
366:                 .ButtonCount = 2
367:                 .BackStyle   = 0
368:                 .BorderStyle = 0
369:                 .Themes      = .F.
370:                 .Value       = 1
371:                 WITH .Buttons(1)
372:                     .Caption   = "Lan" + CHR(231) + "amento"
373:                     .Top       = 4
374:                     .Left      = 2
375:                     .Width     = 85
376:                     .Height    = 17
377:                     .BackStyle = 0
378:                     .Visible   = .T.
379:                 ENDWITH
380:                 WITH .Buttons(2)
381:                     .Caption   = "Prazo Entrega"
382:                     .FontName  = "Tahoma"
383:                     .FontSize  = 8
384:                     .Top       = 4
385:                     .Left      = 90
386:                     .Width     = 90
387:                     .Height    = 17
388:                     .BackStyle = 0
389:                     .Visible   = .T.
390:                 ENDWITH
391:                 .Visible = .T.
392:             ENDWITH
393: 
394:             *-- ===== ROW 2: MOVIMENTACAO / OP =====
395:             loc_oPagina.AddObject("lbl_4c_Lbl_operacao", "Label")
396:             WITH loc_oPagina.lbl_4c_Lbl_operacao
397:                 .Top       = 66
398:                 .Left      = 22
399:                 .Width     = 78
400:                 .Height    = 18
401:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
402:                 .FontName  = "Tahoma"
403:                 .FontSize  = 8
404:                 .ForeColor = RGB(90, 90, 90)
405:                 .BackStyle = 0
406:                 .Visible   = .T.
407:             ENDWITH
408: 
409:             loc_oPagina.AddObject("txt_4c__operacao", "TextBox")
410:             WITH loc_oPagina.txt_4c__operacao
411:                 .Top           = 61
412:                 .Left          = 104
413:                 .Width         = 150
414:                 .Height        = 25
415:                 .Value         = ""
416:                 .FontName      = "Tahoma"
417:                 .FontSize      = 8

*-- Linhas 423 a 476:
423: 
424:             loc_oPagina.AddObject("txt_4c_Numes", "TextBox")
425:             WITH loc_oPagina.txt_4c_Numes
426:                 .Top           = 61
427:                 .Left          = 257
428:                 .Width         = 54
429:                 .Height        = 25
430:                 .Value         = 0
431:                 .InputMask     = "######"
432:                 .FontName      = "Tahoma"
433:                 .FontSize      = 8
434:                 .ForeColor     = RGB(90, 90, 90)
435:                 .BackColor     = RGB(255, 255, 255)
436:                 .SpecialEffect = 0
437:                 .Visible       = .T.
438:             ENDWITH
439: 
440:             loc_oPagina.AddObject("lbl_4c_Lbl_op", "Label")
441:             WITH loc_oPagina.lbl_4c_Lbl_op
442:                 .Top       = 66
443:                 .Left      = 318
444:                 .Width     = 23
445:                 .Height    = 18
446:                 .Caption   = "OP:"
447:                 .FontName  = "Tahoma"
448:                 .FontSize  = 8
449:                 .ForeColor = RGB(90, 90, 90)
450:                 .BackStyle = 0
451:                 .Visible   = .T.
452:             ENDWITH
453: 
454:             loc_oPagina.AddObject("chk_4c_ChkImpOp", "CheckBox")
455:             WITH loc_oPagina.chk_4c_ChkImpOp
456:                 .Top     = 66
457:                 .Left    = 344
458:                 .Width   = 15
459:                 .Height  = 15
460:                 .Caption = ""
461:                 .Value   = 0
462:                 .FontName = "Tahoma"
463:                 .FontSize = 8
464:                 .Themes  = .F.
465:                 .Visible = .T.
466:             ENDWITH
467: 
468:             loc_oPagina.AddObject("txt_4c_Opi", "TextBox")
469:             WITH loc_oPagina.txt_4c_Opi
470:                 .Top           = 61
471:                 .Left          = 363
472:                 .Width         = 54
473:                 .Height        = 25
474:                 .Value         = 0
475:                 .InputMask     = "######"
476:                 .FontName      = "Tahoma"

*-- Linhas 482 a 507:
482:                 .Visible       = .T.
483:             ENDWITH
484: 
485:             loc_oPagina.AddObject("lbl_4c_Label3", "Label")
486:             WITH loc_oPagina.lbl_4c_Label3
487:                 .Top       = 66
488:                 .Left      = 422
489:                 .Width     = 20
490:                 .Height    = 18
491:                 .Caption   = "at" + CHR(233)
492:                 .FontName  = "Tahoma"
493:                 .FontSize  = 8
494:                 .ForeColor = RGB(90, 90, 90)
495:                 .BackStyle = 0
496:                 .Visible   = .T.
497:             ENDWITH
498: 
499:             loc_oPagina.AddObject("txt_4c_Opf", "TextBox")
500:             WITH loc_oPagina.txt_4c_Opf
501:                 .Top           = 61
502:                 .Left          = 445
503:                 .Width         = 54
504:                 .Height        = 25
505:                 .Value         = 0
506:                 .InputMask     = "######"
507:                 .FontName      = "Tahoma"

*-- Linhas 514 a 539:
514:             ENDWITH
515: 
516:             *-- ===== ROW 3: OBSERVACAO =====
517:             loc_oPagina.AddObject("lbl_4c_Label18", "Label")
518:             WITH loc_oPagina.lbl_4c_Label18
519:                 .Top       = 94
520:                 .Left      = 33
521:                 .Width     = 67
522:                 .Height    = 18
523:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
524:                 .FontName  = "Tahoma"
525:                 .FontSize  = 8
526:                 .ForeColor = RGB(90, 90, 90)
527:                 .BackStyle = 0
528:                 .Visible   = .T.
529:             ENDWITH
530: 
531:             loc_oPagina.AddObject("txt_4c_CodObs", "TextBox")
532:             WITH loc_oPagina.txt_4c_CodObs
533:                 .Top           = 90
534:                 .Left          = 104
535:                 .Width         = 31
536:                 .Height        = 23
537:                 .Value         = 0
538:                 .InputMask     = "###"
539:                 .FontName      = "Tahoma"

*-- Linhas 546 a 555:
546: 
547:             loc_oPagina.AddObject("txt_4c_DesObs", "TextBox")
548:             WITH loc_oPagina.txt_4c_DesObs
549:                 .Top           = 90
550:                 .Left          = 138
551:                 .Width         = 361
552:                 .Height        = 23
553:                 .Value         = ""
554:                 .FontName      = "Tahoma"
555:                 .FontSize      = 8

*-- Linhas 561 a 586:
561:             ENDWITH
562: 
563:             *-- ===== ROW 4: EMPRESA =====
564:             loc_oPagina.AddObject("lbl_4c_Lbl_empresa", "Label")
565:             WITH loc_oPagina.lbl_4c_Lbl_empresa
566:                 .Top       = 122
567:                 .Left      = 50
568:                 .Width     = 50
569:                 .Height    = 18
570:                 .Caption   = "Empresa :"
571:                 .FontName  = "Tahoma"
572:                 .FontSize  = 8
573:                 .ForeColor = RGB(90, 90, 90)
574:                 .BackStyle = 0
575:                 .Visible   = .T.
576:             ENDWITH
577: 
578:             loc_oPagina.AddObject("txt_4c__empresa", "TextBox")
579:             WITH loc_oPagina.txt_4c__empresa
580:                 .Top           = 117
581:                 .Left          = 104
582:                 .Width         = 31
583:                 .Height        = 25
584:                 .Value         = ""
585:                 .InputMask     = "XXX"
586:                 .FontName      = "Tahoma"

*-- Linhas 593 a 602:
593: 
594:             loc_oPagina.AddObject("txt_4c__empresa_desc", "TextBox")
595:             WITH loc_oPagina.txt_4c__empresa_desc
596:                 .Top           = 117
597:                 .Left          = 138
598:                 .Width         = 361
599:                 .Height        = 25
600:                 .Value         = ""
601:                 .FontName      = "Tahoma"
602:                 .FontSize      = 8

*-- Linhas 608 a 633:
608:             ENDWITH
609: 
610:             *-- ===== ROW 5 ESQUERDA: GRUPO ESTOQUE =====
611:             loc_oPagina.AddObject("lbl_4c_Label1_GrupoContab", "Label")
612:             WITH loc_oPagina.lbl_4c_Label1_GrupoContab
613:                 .Top       = 150
614:                 .Left      = 62
615:                 .Width     = 38
616:                 .Height    = 18
617:                 .Caption   = "Grupo :"
618:                 .FontName  = "Tahoma"
619:                 .FontSize  = 8
620:                 .ForeColor = RGB(90, 90, 90)
621:                 .BackStyle = 0
622:                 .Visible   = .T.
623:             ENDWITH
624: 
625:             loc_oPagina.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
626:             WITH loc_oPagina.txt_4c__Cd_GrEstoque
627:                 .Top           = 145
628:                 .Left          = 104
629:                 .Width         = 80
630:                 .Height        = 25
631:                 .Value         = ""
632:                 .FontName      = "Tahoma"
633:                 .FontSize      = 8

*-- Linhas 639 a 648:
639: 
640:             loc_oPagina.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
641:             WITH loc_oPagina.txt_4c__Ds_GrEstoque
642:                 .Top           = 145
643:                 .Left          = 187
644:                 .Width         = 312
645:                 .Height        = 25
646:                 .Value         = ""
647:                 .FontName      = "Tahoma"
648:                 .FontSize      = 8

*-- Linhas 654 a 695:
654:             ENDWITH
655: 
656:             *-- ===== ROW 5 DIREITA: LABEL TIPO MOV =====
657:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
658:             WITH loc_oPagina.lbl_4c_Label1
659:                 .Top       = 145
660:                 .Left      = 511
661:                 .Width     = 172
662:                 .Height    = 17
663:                 .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o"
664:                 .FontName  = "Tahoma"
665:                 .FontSize  = 8
666:                 .FontBold  = .T.
667:                 .ForeColor = RGB(90, 90, 90)
668:                 .BackStyle = 0
669:                 .Visible   = .T.
670:             ENDWITH
671: 
672:             *-- ===== ROW 6 ESQUERDA: CONTA ESTOQUE =====
673:             loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
674:             WITH loc_oPagina.lbl_4c_Lbl_estoque
675:                 .Top       = 178
676:                 .Left      = 62
677:                 .Width     = 38
678:                 .Height    = 18
679:                 .Caption   = "Conta :"
680:                 .FontName  = "Tahoma"
681:                 .FontSize  = 8
682:                 .ForeColor = RGB(90, 90, 90)
683:                 .BackStyle = 0
684:                 .Visible   = .T.
685:             ENDWITH
686: 
687:             loc_oPagina.AddObject("txt_4c__cd_estoque", "TextBox")
688:             WITH loc_oPagina.txt_4c__cd_estoque
689:                 .Top           = 173
690:                 .Left          = 104
691:                 .Width         = 80
692:                 .Height        = 25
693:                 .Value         = ""
694:                 .FontName      = "Tahoma"
695:                 .FontSize      = 8

*-- Linhas 702 a 711:
702: 
703:             loc_oPagina.AddObject("txt_4c__ds_estoque", "TextBox")
704:             WITH loc_oPagina.txt_4c__ds_estoque
705:                 .Top           = 173
706:                 .Left          = 187
707:                 .Width         = 312
708:                 .Height        = 25
709:                 .Value         = ""
710:                 .FontName      = "Tahoma"
711:                 .FontSize      = 8

*-- Linhas 720 a 729:
720:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
721:             loc_oGrid = loc_oPagina.grd_4c_Dados
722:             WITH loc_oGrid
723:                 .Top                = 158
724:                 .Left               = 511
725:                 .Width              = 251
726:                 .Height             = 130
727:                 .ColumnCount        = 2
728:                 .RecordSource       = "cursor_4c_TipoMov"
729:                 .RecordSourceType   = 1

*-- Linhas 741 a 834:
741:                 .ScrollBars         = 2
742:                 .Themes             = .F.
743: 
744:                 *-- Column1: CheckBox para Marca (campo booleano de selecao)
745:                 WITH .Column1
746:                     .Width = 25
747:                     .Header1.Caption = ""
748:                     .AddObject("Check1", "CheckBox")
749:                     .Check1.Caption = ""
750:                     .Check1.Value = 0
751:                     .CurrentControl = "Check1"
752:                     .ControlSource = "cursor_4c_TipoMov.Marca"
753:                     .Visible = .T.
754:                 ENDWITH
755: 
756:                 *-- Column2: Descricao do tipo de movimentacao
757:                 WITH .Column2
758:                     .Width = 224
759:                     .ControlSource = "cursor_4c_TipoMov.Descri"
760:                     .ReadOnly = .T.
761:                     .Header1.Caption = "Descrs"
762:                     .Visible = .T.
763:                 ENDWITH
764: 
765:                 .Visible = .T.
766:             ENDWITH
767: 
768:             *-- Re-definir ControlSource apos RecordSource (auto-bind por ordem de campo pode sobrescrever)
769:             loc_oGrid.Column1.ControlSource = "cursor_4c_TipoMov.Marca"
770:             loc_oGrid.Column2.ControlSource = "cursor_4c_TipoMov.Descri"
771: 
772:             *-- Botoes SelTudo / Apaga (direita do grid)
773:             loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
774:             WITH loc_oPagina.cmd_4c_SelTudo
775:                 .Top          = 186
776:                 .Left         = 763
777:                 .Width        = 35
778:                 .Height       = 34
779:                 .Caption      = ""
780:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
781:                 .ToolTipText  = "Selecionar Todos"
782:                 .FontName     = "Tahoma"
783:                 .FontSize     = 8
784:                 .ForeColor    = RGB(90, 90, 90)
785:                 .BackColor    = RGB(255, 255, 255)
786:                 .Themes       = .F.
787:                 .SpecialEffect = 0
788:                 .MousePointer = 15
789:                 .Visible      = .T.
790:             ENDWITH
791: 
792:             loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
793:             WITH loc_oPagina.cmd_4c_Apaga
794:                 .Top          = 221
795:                 .Left         = 763
796:                 .Width        = 35
797:                 .Height       = 34
798:                 .Caption      = ""
799:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
800:                 .ToolTipText  = "Desmarcar Todos"
801:                 .FontName     = "Tahoma"
802:                 .FontSize     = 8
803:                 .ForeColor    = RGB(90, 90, 90)
804:                 .BackColor    = RGB(255, 255, 255)
805:                 .Themes       = .F.
806:                 .SpecialEffect = 0
807:                 .MousePointer = 15
808:                 .Visible      = .T.
809:             ENDWITH
810: 
811:             *-- ===== ROW 7: GRANDE GRUPO =====
812:             loc_oPagina.AddObject("lbl_4c_Label5", "Label")
813:             WITH loc_oPagina.lbl_4c_Label5
814:                 .Top       = 206
815:                 .Left      = 24
816:                 .Width     = 76
817:                 .Height    = 18
818:                 .Caption   = "Grande Grupo :"
819:                 .FontName  = "Tahoma"
820:                 .FontSize  = 8
821:                 .ForeColor = RGB(90, 90, 90)
822:                 .BackStyle = 0
823:                 .Visible   = .T.
824:             ENDWITH
825: 
826:             loc_oPagina.AddObject("txt_4c__cd_ggrupo", "TextBox")
827:             WITH loc_oPagina.txt_4c__cd_ggrupo
828:                 .Top           = 201
829:                 .Left          = 104
830:                 .Width         = 31
831:                 .Height        = 25
832:                 .Value         = ""
833:                 .InputMask     = "##"
834:                 .FontName      = "Tahoma"

*-- Linhas 841 a 850:
841: 
842:             loc_oPagina.AddObject("txt_4c__ds_ggrupo", "TextBox")
843:             WITH loc_oPagina.txt_4c__ds_ggrupo
844:                 .Top           = 201
845:                 .Left          = 138
846:                 .Width         = 361
847:                 .Height        = 25
848:                 .Value         = ""
849:                 .FontName      = "Tahoma"
850:                 .FontSize      = 8

*-- Linhas 856 a 881:
856:             ENDWITH
857: 
858:             *-- ===== ROW 8: GRUPO PRODUTO =====
859:             loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
860:             WITH loc_oPagina.lbl_4c_Lbl_grupo
861:                 .Top       = 235
862:                 .Left      = 21
863:                 .Width     = 79
864:                 .Height    = 18
865:                 .Caption   = "Grupo Produto :"
866:                 .FontName  = "Tahoma"
867:                 .FontSize  = 8
868:                 .ForeColor = RGB(90, 90, 90)
869:                 .BackStyle = 0
870:                 .Visible   = .T.
871:             ENDWITH
872: 
873:             loc_oPagina.AddObject("txt_4c__grupo", "TextBox")
874:             WITH loc_oPagina.txt_4c__grupo
875:                 .Top           = 230
876:                 .Left          = 104
877:                 .Width         = 31
878:                 .Height        = 25
879:                 .Value         = ""
880:                 .InputMask     = "XXX"
881:                 .FontName      = "Tahoma"

*-- Linhas 888 a 897:
888: 
889:             loc_oPagina.AddObject("txt_4c__grupo_desc", "TextBox")
890:             WITH loc_oPagina.txt_4c__grupo_desc
891:                 .Top           = 230
892:                 .Left          = 138
893:                 .Width         = 361
894:                 .Height        = 25
895:                 .Value         = ""
896:                 .FontName      = "Tahoma"
897:                 .FontSize      = 8

*-- Linhas 903 a 928:
903:             ENDWITH
904: 
905:             *-- ===== ROW 9: SUBGRUPO =====
906:             loc_oPagina.AddObject("lbl_4c_Label16", "Label")
907:             WITH loc_oPagina.lbl_4c_Label16
908:                 .Top       = 264
909:                 .Left      = 45
910:                 .Width     = 55
911:                 .Height    = 15
912:                 .Caption   = "Subgrupo :"
913:                 .FontName  = "Tahoma"
914:                 .FontSize  = 8
915:                 .ForeColor = RGB(90, 90, 90)
916:                 .BackStyle = 0
917:                 .Visible   = .T.
918:             ENDWITH
919: 
920:             loc_oPagina.AddObject("txt_4c__cd_sgrupo", "TextBox")
921:             WITH loc_oPagina.txt_4c__cd_sgrupo
922:                 .Top           = 259
923:                 .Left          = 104
924:                 .Width         = 52
925:                 .Height        = 25
926:                 .Value         = ""
927:                 .InputMask     = "XXXXXXX"
928:                 .FontName      = "Tahoma"

*-- Linhas 935 a 1126:
935: 
936:             loc_oPagina.AddObject("txt_4c__ds_sgrupo", "TextBox")
937:             WITH loc_oPagina.txt_4c__ds_sgrupo
938:                 .Top           = 259
939:                 .Left          = 158
940:                 .Width         = 341
941:                 .Height        = 25
942:                 .Value         = ""
943:                 .FontName      = "Tahoma"
944:                 .FontSize      = 8
945:                 .ForeColor     = RGB(90, 90, 90)
946:                 .BackColor     = RGB(255, 255, 255)
947:                 .Enabled       = .F.
948:                 .SpecialEffect = 0
949:                 .Visible       = .T.
950:             ENDWITH
951: 
952:             *-- ===== ROW 10: SITUACAO + CHECKBOXES =====
953:             loc_oPagina.AddObject("lbl_4c_Label7", "Label")
954:             WITH loc_oPagina.lbl_4c_Label7
955:                 .Top       = 290
956:                 .Left      = 50
957:                 .Width     = 50
958:                 .Height    = 18
959:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
960:                 .FontName  = "Tahoma"
961:                 .FontSize  = 8
962:                 .ForeColor = RGB(90, 90, 90)
963:                 .BackStyle = 0
964:                 .Visible   = .T.
965:             ENDWITH
966: 
967:             loc_oPagina.AddObject("obj_4c_OptSituas", "OptionGroup")
968:             WITH loc_oPagina.obj_4c_OptSituas
969:                 .Top         = 284
970:                 .Left        = 100
971:                 .Width       = 311
972:                 .Height      = 27
973:                 .ButtonCount = 3
974:                 .BackStyle   = 0
975:                 .BorderStyle = 0
976:                 .Themes      = .F.
977:                 .Value       = 3
978:                 WITH .Buttons(1)
979:                     .Caption   = "N.Ind."
980:                     .Top       = 4
981:                     .Left      = 2
982:                     .Width     = 60
983:                     .Height    = 17
984:                     .BackStyle = 0
985:                     .Visible   = .T.
986:                 ENDWITH
987:                 WITH .Buttons(2)
988:                     .Caption   = "Industrializada"
989:                     .FontName  = "Tahoma"
990:                     .FontSize  = 8
991:                     .Top       = 4
992:                     .Left      = 65
993:                     .Width     = 100
994:                     .Height    = 17
995:                     .BackStyle = 0
996:                     .Visible   = .T.
997:                 ENDWITH
998:                 WITH .Buttons(3)
999:                     .Caption   = "Todos"
1000:                     .FontName  = "Tahoma"
1001:                     .FontSize  = 8
1002:                     .Top       = 4
1003:                     .Left      = 168
1004:                     .Width     = 60
1005:                     .Height    = 17
1006:                     .BackStyle = 0
1007:                     .Visible   = .T.
1008:                 ENDWITH
1009:                 .Visible = .T.
1010:             ENDWITH
1011: 
1012:             loc_oPagina.AddObject("chk_4c_ChkPendente", "CheckBox")
1013:             WITH loc_oPagina.chk_4c_ChkPendente
1014:                 .Top      = 289
1015:                 .Left     = 421
1016:                 .Width    = 69
1017:                 .Height   = 15
1018:                 .Caption  = "Pendentes"
1019:                 .Value    = 0
1020:                 .FontName = "Tahoma"
1021:                 .FontSize = 8
1022:                 .Enabled  = .F.
1023:                 .Themes   = .F.
1024:                 .Visible  = .T.
1025:             ENDWITH
1026: 
1027:             loc_oPagina.AddObject("chk_4c_ChkOrdem", "CheckBox")
1028:             WITH loc_oPagina.chk_4c_ChkOrdem
1029:                 .Top      = 289
1030:                 .Left     = 516
1031:                 .Width    = 171
1032:                 .Height   = 15
1033:                 .Caption  = "Filtro por Ordem de Composi" + CHR(231) + CHR(227) + "o"
1034:                 .Value    = 0
1035:                 .FontName = "Tahoma"
1036:                 .FontSize = 8
1037:                 .Themes   = .F.
1038:                 .Visible  = .T.
1039:             ENDWITH
1040: 
1041:             *-- ===== ROW 11: AGRUPAMENTO + SERVICO =====
1042:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
1043:             WITH loc_oPagina.lbl_4c_Label2
1044:                 .Top       = 311
1045:                 .Left      = 26
1046:                 .Width     = 74
1047:                 .Height    = 18
1048:                 .Caption   = "Agrupamento :"
1049:                 .FontName  = "Tahoma"
1050:                 .FontSize  = 8
1051:                 .ForeColor = RGB(90, 90, 90)
1052:                 .BackStyle = 0
1053:                 .Visible   = .T.
1054:             ENDWITH
1055: 
1056:             loc_oPagina.AddObject("obj_4c_Optagrupa", "OptionGroup")
1057:             WITH loc_oPagina.obj_4c_Optagrupa
1058:                 .Top         = 306
1059:                 .Left        = 100
1060:                 .Width       = 198
1061:                 .Height      = 25
1062:                 .ButtonCount = 2
1063:                 .BackStyle   = 0
1064:                 .BorderStyle = 0
1065:                 .Themes      = .F.
1066:                 .Value       = 1
1067:                 WITH .Buttons(1)
1068:                     .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
1069:                     .Top       = 4
1070:                     .Left      = 2
1071:                     .Width     = 90
1072:                     .Height    = 17
1073:                     .BackStyle = 0
1074:                     .Visible   = .T.
1075:                 ENDWITH
1076:                 WITH .Buttons(2)
1077:                     .Caption   = "OP"
1078:                     .FontName  = "Tahoma"
1079:                     .FontSize  = 8
1080:                     .Top       = 4
1081:                     .Left      = 95
1082:                     .Width     = 40
1083:                     .Height    = 17
1084:                     .BackStyle = 0
1085:                     .Visible   = .T.
1086:                 ENDWITH
1087:                 .Visible = .T.
1088:             ENDWITH
1089: 
1090:             loc_oPagina.AddObject("chk_4c_Chkservico", "CheckBox")
1091:             WITH loc_oPagina.chk_4c_Chkservico
1092:                 .Top      = 310
1093:                 .Left     = 368
1094:                 .Width    = 110
1095:                 .Height   = 15
1096:                 .Caption  = "Industrializa" + CHR(231) + CHR(227) + "o (S)"
1097:                 .Value    = 0
1098:                 .FontName = "Tahoma"
1099:                 .FontSize = 8
1100:                 .Enabled  = .F.
1101:                 .Themes   = .F.
1102:                 .Visible  = .T.
1103:             ENDWITH
1104: 
1105:             *-- ===== BINDEVENTS =====
1106:             BINDEVENT(loc_oPagina.chk_4c_ChkImpOp, "InteractiveChange", ;
1107:                 THIS, "ChkImpOpChange")
1108:             BINDEVENT(loc_oPagina.obj_4c_OptSituas, "InteractiveChange", ;
1109:                 THIS, "OptSituasChange")
1110:             BINDEVENT(loc_oPagina.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
1111:             BINDEVENT(loc_oPagina.cmd_4c_Apaga,   "Click", THIS, "BtnApagaClick")
1112:             BINDEVENT(loc_oPagina.txt_4c__operacao, "KeyPress", ;
1113:                 THIS, "TxtOperacaoKeyPress")
1114:             BINDEVENT(loc_oPagina.txt_4c_CodObs, "KeyPress", ;
1115:                 THIS, "TxtCodObsKeyPress")
1116:             BINDEVENT(loc_oPagina.txt_4c_DesObs, "KeyPress", ;
1117:                 THIS, "TxtDesObsKeyPress")
1118:             BINDEVENT(loc_oPagina.txt_4c__empresa, "KeyPress", ;
1119:                 THIS, "TxtEmpresaKeyPress")
1120:             BINDEVENT(loc_oPagina.txt_4c__Cd_GrEstoque, "KeyPress", ;
1121:                 THIS, "TxtGrEstoqueKeyPress")
1122:             BINDEVENT(loc_oPagina.txt_4c__cd_ggrupo, "KeyPress", ;
1123:                 THIS, "TxtGrdGrupoKeyPress")
1124:             BINDEVENT(loc_oPagina.txt_4c__ds_ggrupo, "KeyPress", ;
1125:                 THIS, "TxtGrdGrupoDescKeyPress")
1126:             BINDEVENT(loc_oPagina.txt_4c__grupo, "KeyPress", ;

*-- Linhas 1189 a 1197:
1189:                 loc_oPagina.txt_4c_Opf.Enabled = .F.
1190:             ENDIF
1191: 
1192:             *-- Checkboxes contextuais desabilitados ate condicao de habilitacao ser satisfeita
1193:             IF PEMSTATUS(loc_oPagina, "chk_4c_Chkservico", 5)
1194:                 loc_oPagina.chk_4c_Chkservico.Enabled = .F.
1195:             ENDIF
1196:             IF PEMSTATUS(loc_oPagina, "chk_4c_ChkPendente", 5)
1197:                 loc_oPagina.chk_4c_ChkPendente.Enabled = .F.


### BO (C:\4c\projeto\app\classes\SigReCmpBO.prg):
*==============================================================================
* SigReCmpBO.prg
* Business Object: Listagem de Composicao Por Movimentacao/OP (SIGRECMP)
* Herda de: RelatorioBase
* Tipo: REPORT
* Form legado: SigReCmp.SCX (frmrelatorio)
* Relatorios: SigReCp2.frx (agrupamento=1), SigReCp3.frx (agrupamento=2)
*==============================================================================

DEFINE CLASS SigReCmpBO AS RelatorioBase

    *-- Identificacao (sem tabela direta - relatorio)
    this_cTabela          = ""
    this_cCampoChave      = ""
    this_cMensagemErro    = ""

    *--------------------------------------------------------------------------
    * Filtros de data e periodo
    *--------------------------------------------------------------------------
    this_dDtInicial       = {}    && Data inicial do periodo
    this_dDtFinal         = {}    && Data final do periodo
    this_nOptData         = 1     && 1=Lancamento, 2=Prazo Entrega

    *--------------------------------------------------------------------------
    * Filtro de movimentacao
    *--------------------------------------------------------------------------
    this_cOperacao        = ""    && Codigo da movimentacao (max 20 chars)
    this_nNumes           = 0     && Numero da movimentacao (0=todos)

    *--------------------------------------------------------------------------
    * Filtro de OP (Ordem de Producao)
    *--------------------------------------------------------------------------
    this_lChkImpOp        = .F.   && .T. = filtrar por intervalo de OP
    this_nOpi             = 0     && OP inicial (0=sem filtro)
    this_nOpf             = 0     && OP final (0=sem limite, tratado como 999999)

    *--------------------------------------------------------------------------
    * Filtro de empresa
    *--------------------------------------------------------------------------
    this_cEmpresa         = ""    && Codigo da empresa (3 chars)
    this_cEmpresaDesc     = ""    && Descricao da empresa

    *--------------------------------------------------------------------------
    * Filtro de observacao
    *--------------------------------------------------------------------------
    this_nCodObs          = 0     && Codigo de observacao (0=todos)
    this_cDesObs          = ""    && Descricao da observacao

    *--------------------------------------------------------------------------
    * Filtro de grupo estoque / conta
    *--------------------------------------------------------------------------
    this_cGrEstoque       = ""    && Codigo do grupo estoque (10 chars)
    this_cGrEstoqueDesc   = ""    && Descricao do grupo estoque
    this_cEstoque         = ""    && Codigo da conta/estoque (10 chars)
    this_cEstoqueDesc     = ""    && Descricao da conta/estoque

    *--------------------------------------------------------------------------
    * Filtro de grande grupo
    *--------------------------------------------------------------------------
    this_cGrdGrupo        = ""    && Codigo do grande grupo (3 chars)
    this_cGrdGrupoDesc    = ""    && Descricao do grande grupo

    *--------------------------------------------------------------------------
    * Filtro de grupo produto
    *--------------------------------------------------------------------------
    this_cGrupo           = ""    && Codigo do grupo produto (3 chars)
    this_cGrupoDesc       = ""    && Descricao do grupo produto

    *--------------------------------------------------------------------------
    * Filtro de subgrupo
    *--------------------------------------------------------------------------
    this_cSubGrupo        = ""    && Codigo do subgrupo (6 chars)
    this_cSubGrupoDesc    = ""    && Descricao do subgrupo

    *--------------------------------------------------------------------------
    * Opcoes gerais de filtro e agrupamento
    *--------------------------------------------------------------------------
    this_nOpcaoSituacao   = 3     && OptSituas: 1=N.Ind., 2=Industrializada, 3=Todos
    this_nAgrupamento     = 1     && optagrupa: 1=por Composicao, 2=pela OP
    this_lServico         = .F.   && .T. = incluir industrializacao de servico
    this_lPendente        = .F.   && .T. = filtrar apenas pendentes
    this_lOrdem           = .F.   && .T. = filtrar por ordem de composicao

    *==========================================================================
    * Init - Inicializa o BO de relatorio (sem tabela direta)
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * InicializarDados
    * Cria e popula cursor_4c_TipoMov com tipos de movimentacao de SigCdTom.
    * Equivalente ao Load (CREATE CURSOR cs_SigCdTom) + parte do Init legado.
    * Deve ser chamado pelo form antes de exibir o grid de tipos.
    *==========================================================================
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_TipoMov")
                USE IN cursor_4c_TipoMov
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TipoMov (Marca N(1), Descri C(40), Codigos N(2))
            SET NULL OFF
            INDEX ON Codigos TAG Codigos

            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TipoMovTemp") > 0
                SELECT cursor_4c_TipoMovTemp
                SCAN
                    INSERT INTO cursor_4c_TipoMov (Marca, Codigos, Descri) ;
                        VALUES (0, cursor_4c_TipoMovTemp.Codigos, ;
                                ALLTRIM(STR(cursor_4c_TipoMovTemp.Codigos, 2)) + "-" + ;
                                ALLTRIM(cursor_4c_TipoMovTemp.Descrs))
                ENDSCAN
                IF USED("cursor_4c_TipoMovTemp")
                    USE IN cursor_4c_TipoMovTemp
                ENDIF
            ENDIF
            SELECT cursor_4c_TipoMov
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterNomeRelatorio
    * Retorna nome do FRX conforme agrupamento selecionado
    *==========================================================================
    PROCEDURE ObterNomeRelatorio()
        IF THIS.this_nAgrupamento = 1
            RETURN "SigReCp2"
        ELSE
            RETURN "SigReCp3"
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterMensagemErro
    * Retorna ultima mensagem de erro registrada
    *==========================================================================
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *==========================================================================
    * DesmarcarTodos
    * Remove marca de todos os tipos de movimentacao (equivalente ao btn apaga)
    *==========================================================================
    PROCEDURE DesmarcarTodos()
        IF USED("cursor_4c_TipoMov")
            SELECT cursor_4c_TipoMov
            REPLACE ALL Marca WITH 0
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * MarcarTodos
    * Marca todos os tipos de movimentacao (equivalente ao btn SelTudo)
    *==========================================================================
    PROCEDURE MarcarTodos()
        IF USED("cursor_4c_TipoMov")
            SELECT cursor_4c_TipoMov
            REPLACE ALL Marca WITH 1
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * PrepararDados
    * Executa processamento principal: seleciona movimentacoes e composicoes.
    * Equivalente ao metodo "processamento" do form legado SIGRECMP.
    * Popula cursores TmpRelat e dbCabecalho para uso pelo REPORT FORM.
    *==========================================================================
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_cOperacao, loc_nNume, loc_cEmpresa, loc_cGrupop
        LOCAL loc_cGrdGru, loc_cSubGru, loc_cGrupo, loc_cConta
        LOCAL loc_nOpcao, loc_lChkOp, loc_nNopi, loc_nNopf
        LOCAL loc_lServico, loc_lPendente, loc_nObs, loc_lOrdem
        LOCAL loc_cDtI, loc_cDtF, loc_cDatos
        LOCAL loc_llTipoSel, loc_cFilTipo, loc_cWhere, loc_cSQL
        LOCAL loc_cEmpresaDesc, loc_cNomeEmpresa
        LOCAL loc_cTitulo, loc_cPeriodo, loc_cSubTit, loc_cTot
        LOCAL loc_lcChave, loc_cGrupoRel, loc_cContaRel
        LOCAL loc_lnQtde, loc_lnPeso, loc_cDgru, loc_cNop
        LOCAL loc_nLnOpi, loc_nLnOpf, loc_nRegs, loc_cEmpPro, loc_cSqlPen
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Extrair valores dos filtros das propriedades do BO
            loc_cOperacao = PADR(ALLTRIM(THIS.this_cOperacao), 20)
            loc_nNume     = THIS.this_nNumes
            loc_cEmpresa  = THIS.this_cEmpresa
            loc_cGrupop   = PADR(ALLTRIM(THIS.this_cGrupo), 3)
            loc_cGrdGru   = THIS.this_cGrdGrupo
            loc_cSubGru   = THIS.this_cSubGrupo
            loc_cGrupo    = PADR(ALLTRIM(THIS.this_cGrEstoque), 10)
            loc_cConta    = PADR(ALLTRIM(THIS.this_cEstoque), 10)
            loc_nOpcao    = THIS.this_nOpcaoSituacao
            loc_lChkOp    = THIS.this_lChkImpOp
            loc_nNopi     = THIS.this_nOpi
            loc_nNopf     = IIF(THIS.this_nOpf = 0, 999999, THIS.this_nOpf)
            loc_lServico  = THIS.this_lServico
            loc_lPendente = THIS.this_lPendente
            loc_nObs      = THIS.this_nCodObs
            loc_lOrdem    = THIS.this_lOrdem

            *-- Formatar datas para SQL Server (pDtI/pDtF do legado)
            loc_cDatos = DTOS(THIS.this_dDtFinal)
            loc_cDtI   = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtF   = "'" + LEFT(loc_cDatos, 4) + "-" + ;
                         SUBSTR(loc_cDatos, 5, 2) + "-" + ;
                         RIGHT(loc_cDatos, 2) + " 23:59:59'"

            *-- Verificar se ha tipos selecionados no grid de tipos
            loc_llTipoSel = .F.
            loc_cFilTipo  = ""
            IF USED("cursor_4c_TipoMov")
                SELECT cursor_4c_TipoMov
                GO TOP
                LOCATE FOR Marca = 1
                IF !EOF()
                    loc_llTipoSel = .T.
                ENDIF
            ENDIF

            *-- Fechar cursores de resultado anteriores
            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            IF USED("CrSigMvCab")
                USE IN CrSigMvCab
            ENDIF
            IF USED("CrSigCdEmp")
                USE IN CrSigCdEmp
            ENDIF
            IF USED("CrSigMvItn")
                USE IN CrSigMvItn
            ENDIF
            IF USED("CrSigOpPic")
                USE IN CrSigOpPic
            ENDIF

            *-- Buscar empresas para cabecalho e processamento
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                       IIF(EMPTY(loc_cEmpresa), "", " WHERE Cemps = " + EscaparSQL(loc_cEmpresa))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdEmp") < 1
                THIS.this_cMensagemErro = "Erro ao carregar empresas"
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                SELECT CrSigCdEmp
                GO TOP
                loc_cEmpresaDesc = IIF(EOF(), "", ALLTRIM(CrSigCdEmp.Razas))

            *-- Buscar razao social da empresa logada no sistema
            loc_cNomeEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpSis") > 0
                SELECT cursor_4c_EmpSis
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_EmpSis.Razas)
                ENDIF
                USE IN cursor_4c_EmpSis
            ENDIF

            *-- Montar textos do cabecalho do relatorio
            loc_cTitulo  = "Listagem de Composi" + CHR(231) + CHR(227) + ;
                           "o por Movimenta" + CHR(231) + CHR(227) + "o ( " + ;
                           ALLTRIM(loc_cOperacao) + ;
                           IIF(loc_nNume <> 0, ": " + ALLTRIM(STR(loc_nNume, 6)), "") + " )"
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           IIF(EMPTY(loc_cEmpresa), "Geral", ;
                               "Empresa: " + loc_cEmpresa + " - " + ALLTRIM(loc_cEmpresaDesc))
            loc_cSubTit  = IIF(loc_nNopi <> 0, ;
                               "OP: " + ALLTRIM(STR(loc_nNopi, 6)) + ;
                               " " + CHR(224) + " " + ALLTRIM(STR(loc_nNopf, 6)), ;
                               "")

            *-- Criar cursor de cabecalho (dbCabecalho legado)
            CREATE CURSOR dbCabecalho ;
                (NomeEmpresa C(80), Titulo C(80), Periodo C(150), ;
                 SubTitulo C(80), lCompo L, Total M(4))
            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo, SubTitulo) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cSubTit)

            *-- Criar cursor de resultado principal (TmpRelat legado)
            CREATE CURSOR TmpRelat ;
                (Emps C(3), Razas C(40), CGrus C(3), DGrus C(20), ;
                 Grupo C(10), Conta C(10), DConta C(40), Tps C(1), ;
                 CPros C(14), DPros C(40), cUnis C(3), Qtds N(12, 3), ;
                 QtPds N(10), Pesoms N(8, 4), Pesos N(12, 3), ;
                 Datas D(8), NDias N(8), Imps N(1), reffs C(40), ;
                 Mats C(14), DMats C(40), unicompos C(3), cunips C(3), ;
                 Nops C(10), ObsOfs C(50), RefMats C(20))
            INDEX ON Grupo + Conta + Emps + CPros TAG EmpCPro
            INDEX ON Grupo + Conta + Emps + Tps + CGrus + CPros TAG EmpCGruPro
            INDEX ON Grupo + Conta + Emps + Tps + CGrus + CPros TAG EGP
            INDEX ON Mats + Reffs + CPros TAG MatRef
            INDEX ON CPros + Nops + Mats + Reffs TAG CproMatRef

            *-- ==============================================================
            *-- MONTAR WHERE para consulta de movimentacoes (SigMvCab)
            *-- ==============================================================
            loc_cWhere = ""
            IF loc_lChkOp
                *-- Filtro por intervalo de OP (chkImpOp marcado)
                loc_cWhere = " a.Nops BETWEEN " + ALLTRIM(STR(loc_nNopi)) + ;
                             " AND " + ALLTRIM(STR(loc_nNopf)) + ;
                             " AND b.produc = 1"
                IF !EMPTY(loc_cEmpresa)
                    loc_cWhere = loc_cWhere + " AND a.Emps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
            ELSE
                *-- Filtro por operacao e datas
                IF !EMPTY(ALLTRIM(loc_cOperacao))
                    loc_cWhere = " a.Dopes = " + EscaparSQL(ALLTRIM(loc_cOperacao))
                ENDIF
                IF EMPTY(ALLTRIM(loc_cOperacao)) AND !loc_llTipoSel
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + " b.produc = 1"
                ENDIF
                IF loc_nNume <> 0
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                 " a.Numes = " + ALLTRIM(STR(loc_nNume, 6))
                ENDIF
                IF loc_nNume = 0
                    IF THIS.this_nOptData = 1
                        loc_cWhere = loc_cWhere + ;
                                     IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                     " a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
                    ELSE
                        loc_cWhere = loc_cWhere + ;
                                     IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                     " a.PrazoEnts BETWEEN " + loc_cDtI + " AND " + loc_cDtF
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cEmpresa)
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                 " a.Emps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
                IF loc_nOpcao = 1
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + " a.Nops = 0"
                ENDIF
                IF loc_nOpcao = 2
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + " a.Nops <> 0"
                ENDIF
            ENDIF

            *-- Adicionar filtro pelos tipos de movimentacao selecionados no grid
            IF USED("cursor_4c_TipoMov") AND loc_llTipoSel
                SELECT cursor_4c_TipoMov
                GO TOP
                SCAN FOR Marca = 1
                    IF EMPTY(loc_cFilTipo)
                        loc_cFilTipo = ALLTRIM(STR(cursor_4c_TipoMov.Codigos))
                    ELSE
                        loc_cFilTipo = loc_cFilTipo + "," + ;
                                       ALLTRIM(STR(cursor_4c_TipoMov.Codigos))
                    ENDIF
                ENDSCAN
            ENDIF
            IF !EMPTY(loc_cFilTipo)
                loc_cWhere = loc_cWhere + ;
                             IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                             " b.TipoOps IN (" + loc_cFilTipo + ")"
            ENDIF

            *-- ==============================================================
            *-- SELECIONAR MOVIMENTACOES (SigMvCab JOIN SigCdOpe)
            *-- ==============================================================
            WAIT WINDOW "Aguarde! Selecionando Movimenta" + ;
                        CHR(231) + CHR(245) + "es..." NOWAIT

            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Datas, " + ;
                       "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, " + ;
                       "a.EmpDopNums, a.Nops, b.Globalizas, b.Servicos " + ;
                       "FROM SigMvCab a INNER JOIN SigCdOpe b ON a.Dopes = b.Dopes"
            IF !EMPTY(loc_cWhere)
                loc_cSQL = loc_cSQL + " WHERE " + loc_cWhere
            ENDIF
            IF loc_nObs <> 0
                loc_cSQL = loc_cSQL + ;
                           IIF(!EMPTY(loc_cWhere), " AND", " WHERE") + ;
                           " a.CodObs = " + ALLTRIM(STR(loc_nObs))
            ENDIF
            loc_cSQL = loc_cSQL + ;
                       " ORDER BY a.Emps, a.Dopes, a.Numes, a.Datas, " + ;
                       "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.EmpDopNums"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvCab") < 1
                THIS.this_cMensagemErro = "Erro ao carregar movimenta" + ;
                                          CHR(231) + CHR(245) + "es"
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
            SELECT CrSigMvCab
            INDEX ON EmpDopNums TAG EmpDopNums
            GO TOP
            WAIT CLEAR

            *-- ==============================================================
            *-- PROCESSAR POR EMPRESA
            *-- ==============================================================
            SELECT CrSigCdEmp
            GO TOP
            SCAN
                loc_cEmpPro = CrSigCdEmp.Cemps

                SELECT CrSigMvCab
                COUNT FOR Emps = loc_cEmpPro TO loc_nRegs
                GO TOP

                IF SEEK(loc_cEmpPro, "CrSigMvCab", "EmpDopNums")
                    WAIT WINDOW "Verificando Movimenta" + CHR(231) + ;
                                CHR(245) + "es..." NOWAIT

                    SCAN WHILE CrSigMvCab.Emps = loc_cEmpPro
                        loc_cGrupoRel = ""
                        loc_cContaRel = ""

                        *-- Pular industrializacoes de servico se nao marcado
                        IF !loc_lServico AND EMPTY(ALLTRIM(loc_cOperacao)) AND ;
                           INLIST(CrSigMvCab.Servicos, 1, 2)
                            LOOP
                        ENDIF

                        *-- Filtrar por grupo/conta estoque se informados
                        IF !EMPTY(ALLTRIM(loc_cGrupo)) OR !EMPTY(ALLTRIM(loc_cConta))
                            IF CrSigMvCab.Globalizas = 1 OR CrSigMvCab.Servicos = 1
                                IF !EMPTY(ALLTRIM(loc_cGrupo)) AND ;
                                   (loc_cGrupo <> CrSigMvCab.GrupoOs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                IF !EMPTY(ALLTRIM(loc_cConta)) AND ;
                                   (loc_cConta <> CrSigMvCab.ContaOs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                loc_cGrupoRel = CrSigMvCab.GrupoOs
                                loc_cContaRel = CrSigMvCab.ContaOs
                            ENDIF
                            IF CrSigMvCab.Globalizas = 2 OR CrSigMvCab.Servicos = 2
                                IF !EMPTY(ALLTRIM(loc_cGrupo)) AND ;
                                   (loc_cGrupo <> CrSigMvCab.GrupoDs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                IF !EMPTY(ALLTRIM(loc_cConta)) AND ;
                                   (loc_cConta <> CrSigMvCab.ContaDs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                loc_cGrupoRel = CrSigMvCab.GrupoDs
                                loc_cContaRel = CrSigMvCab.ContaDs
                            ENDIF
                        ELSE
                            loc_cGrupoRel = SPACE(10)
                            loc_cContaRel = SPACE(10)
                        ENDIF

                        loc_lcChave = CrSigMvCab.EmpDopNums

                        *-- Fechar cursor de itens da iteracao anterior
                        IF USED("CrSigMvItn")
                            USE IN CrSigMvItn
                        ENDIF

                        *-- ======================================================
                        *-- QUERY DE COMPONENTES DA MOVIMENTACAO (UNION ALL)
                        *-- Parte 1: Componentes diretos (SigSubMv + SigMvItn)
                        *-- ======================================================
                        loc_cSQL = "SELECT a.mats, a.CPros, a.Pesos, a.Qtds, a.QtBaixas, " + ;
                                   "b.Dpros AS Dmats, b.CGrus, b.CUnis, b.PesoMs, b.CustoFs, " + ;
                                   "b.Reffs AS RefMats, c.DGrus, d.FatDivs, b.Reffs, e.Dpros, " + ;
                                   "a.cunis AS unicompos, a.cunips, " + ;
                                   "CASE WHEN g.Qtds IS NULL THEN f.Qtds ELSE g.Qtds END AS QtdPed, " + ;
                                   "d.Fators, f.Citens, SPACE(50) AS ObsOFs, a.EmpDopNums, " + ;
                                   "CASE WHEN g.CodCors IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodCors END AS CodCors, " + ;
                                   "CASE WHEN g.CodTams IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodTams END AS CodTams " + ;
                                   "FROM SigSubMv a " + ;
                                   "INNER JOIN SigCdPro e ON e.Cpros = a.Cpros " + ;
                                   "INNER JOIN SigMvItn f ON f.empdopnums = a.empdopnums " + ;
                                   "AND f.citens = a.citem2 " + ;
                                   "INNER JOIN SigCdPro b ON b.CPros = a.mats " + ;
                                   "LEFT JOIN SigCdGrp c ON c.CGrus = b.CGrus " + ;
                                   "LEFT JOIN SigCdUni d ON d.CUnis = b.CUnis " + ;
                                   "LEFT JOIN SigMvIts g ON g.EmpDopNums = f.EmpDopNums " + ;
                                   "AND g.Citens = f.Citens " + ;
                                   "WHERE a.empdopnums = " + EscaparSQL(loc_lcChave)
                        IF !EMPTY(ALLTRIM(loc_cGrdGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.Mercs = " + EscaparSQL(ALLTRIM(loc_cGrdGru))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cGrupop))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.CGrus = " + EscaparSQL(ALLTRIM(loc_cGrupop))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cSubGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.SGrus = " + EscaparSQL(ALLTRIM(loc_cSubGru))
                        ENDIF

                        *-- Parte 2: Componentes do plano (SigPrCpo + SigMvItn)
                        loc_cSQL = loc_cSQL + ;
                                   " UNION ALL " + ;
                                   "SELECT a.mats, a.CPros, " + ;
                                   "CASE WHEN h.Pesos IS NULL THEN a.Pesos ELSE h.Pesos END AS Pesos, " + ;
                                   "CASE WHEN h.Qtds IS NULL THEN a.Qtds ELSE h.Qtds END AS Qtds, " + ;
                                   "0 AS QtBaixas, b.Dpros AS DMats, b.CGrus, b.CUnis, " + ;
                                   "b.PesoMs, b.CustoFs, b.Reffs AS RefMats, c.DGrus, " + ;
                                   "d.FatDivs, f.reffs, e.Dpros, a.unicompos, a.cunips, " + ;
                                   "CASE WHEN g.Qtds IS NULL THEN e.Qtds ELSE g.Qtds END AS QtdPed, " + ;
                                   "d.Fators, e.Citens, CAST(a.ObsOFs AS CHAR(50)) AS ObsOFs, " + ;
                                   "e.EmpDopNums, " + ;
                                   "CASE WHEN g.CodCors IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodCors END AS CodCors, " + ;
                                   "CASE WHEN g.CodTams IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodTams END AS CodTams " + ;
                                   "FROM SigMvItn e " + ;
                                   "LEFT JOIN SigMvIts g ON e.EmpDopNums = g.EmpDopNums " + ;
                                   "AND e.Citens = g.Citens " + ;
                                   "INNER JOIN SigPrCpo a ON e.cpros = a.cpros " + ;
                                   "LEFT JOIN SigSubCp h ON a.Cpros = h.Cpros " + ;
                                   "AND a.Mats = h.Mats AND h.CodTams = g.CodTams " + ;
                                   "INNER JOIN SigCdPro f ON e.Cpros = f.Cpros " + ;
                                   "INNER JOIN SigCdPro b ON b.CPros = a.mats " + ;
                                   "LEFT JOIN SigCdGrp c ON c.CGrus = b.CGrus " + ;
                                   "LEFT JOIN SigCdUni d ON d.CUnis = b.CUnis " + ;
                                   "WHERE e.empdopnums = " + EscaparSQL(loc_lcChave)
                        IF !EMPTY(ALLTRIM(loc_cGrdGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.Mercs = " + EscaparSQL(ALLTRIM(loc_cGrdGru))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cGrupop))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.CGrus = " + EscaparSQL(ALLTRIM(loc_cGrupop))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cSubGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.SGrus = " + EscaparSQL(ALLTRIM(loc_cSubGru))
                        ENDIF
                        IF loc_lOrdem
                            loc_cSQL = loc_cSQL + " AND a.OrdTs = 0"
                        ENDIF
                        loc_cSQL = loc_cSQL + ;
                                   " AND e.citens NOT IN (" + ;
                                   "SELECT e.citens FROM SigMvItn e, SigSubMv a " + ;
                                   "WHERE e.empdopnums = " + EscaparSQL(loc_lcChave) + ;
                                   " AND e.empdopnums = a.empdopnums " + ;
                                   "AND e.citens = a.citem2 GROUP BY e.citens)"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvItn") < 1
                            SELECT CrSigMvCab
                            LOOP
                        ENDIF
                        SELECT CrSigMvItn
                        INDEX ON CPros + STR(Pesos, 12, 3) + STR(Qtds, 12, 3) TAG Ordem

                        *-- Buscar dados de OP se a movimentacao possuir Nops
                        IF !EMPTY(CrSigMvCab.Nops)
                            loc_nLnOpi = CrSigMvCab.Nops * 10000
                            loc_nLnOpf = (CrSigMvCab.Nops + 1) * 10000

                            IF USED("CrSigOpPic")
                                USE IN CrSigOpPic
                            ENDIF

                            loc_cSQL = "SELECT a.Nops, a.cpros, a.Emps, a.empdopnops, " + ;
                                       "a.EmpDopNums, SUM(a.qtds) AS Qtds, " + ;
                                       "a.codcors, a.CodTams, b.descs AS desccors, a.citens " + ;
                                       "FROM SigOpPic a " + ;
                                       "LEFT JOIN SigCdCor b ON a.codcors = b.cods " + ;
                                       "WHERE a.Nops BETWEEN " + ;
                                       ALLTRIM(STR(loc_nLnOpi, 10)) + ;
                                       " AND " + ALLTRIM(STR(loc_nLnOpf, 10)) + ;
                                       " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                                       " GROUP BY a.Nops, a.cpros, a.emps, a.empdopnops, " + ;
                                       "a.EmpDopNums, a.codcors, a.CodTams, b.descs, a.citens"

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpPic") > 0
                                SELECT CrSigOpPic
                                INDEX ON STR(Citens, 4) + Cpros + STR(Nops, 10) TAG CproNop
                                INDEX ON STR(Citens, 4) + Cpros + CodCors + ;
                                         CodTams + EmpDopNums + STR(Nops, 10) TAG CproNop2
                            ENDIF
                        ENDIF

                        *-- ======================================================
                        *-- ITERAR SOBRE OS COMPONENTES E ACUMULAR EM TmpRelat
                        *-- ======================================================
                        SELECT CrSigMvItn
                        GO TOP
                        SCAN
                            loc_cNop = ""

                            IF !EMPTY(CrSigMvCab.Nops) AND USED("CrSigOpPic")
                                *-- Com OP: usar quantidades do SigOpPic
                                SELECT CrSigOpPic
                                =SEEK(STR(CrSigMvItn.Citens, 4) + CrSigMvItn.Cpros + ;
                                      CrSigMvItn.CodCors + CrSigMvItn.CodTams + ;
                                      CrSigMvItn.EmpDopNums, "CrSigOpPic", "CproNop2")

                                SCAN FOR CrSigOpPic.Cpros = CrSigMvItn.Cpros AND ;
                                         CrSigOpPic.Citens = CrSigMvItn.Citens AND ;
                                         CrSigOpPic.EmpDopNums = CrSigMvItn.EmpDopNums AND ;
                                         CrSigOpPic.CodCors = CrSigMvItn.CodCors AND ;
                                         CrSigOpPic.CodTams = CrSigMvItn.CodTams

                                                IF loc_lPendente
                                        loc_cSqlPen = "SELECT ChkSubn FROM SigCdNec " + ;
                                                      "WHERE EmpDnPs = " + ;
                                                      EscaparSQL(ALLTRIM(CrSigOpPic.EmpdopNops))
                                        IF SQLEXEC(gnConnHandle, loc_cSqlPen, "TmpNens") > 0
                                            SELECT TmpNens
                                            IF !EOF() AND TmpNens.ChkSubn
                                                IF USED("TmpNens")
                                                    USE IN TmpNens
                                                ENDIF
                                                SELECT CrSigOpPic
                                                LOOP
                                            ENDIF
                                            IF USED("TmpNens")
                                                USE IN TmpNens
                                            ENDIF
                                        ENDIF
                                    ENDIF

                                    loc_lnQtde = ROUND(CrSigOpPic.Qtds * CrSigMvItn.Qtds, 3)
                                    loc_lnPeso = ROUND(CrSigOpPic.Qtds * CrSigMvItn.Pesos, 3)
                                    loc_cDgru  = NVL(CrSigMvItn.DGrus, "")
                                    loc_cNop   = IIF(THIS.this_nAgrupamento = 2, ;
                                                     ALLTRIM(STR(CrSigOpPic.Nops)), "")

                                    SELECT TmpRelat
                                    SET ORDER TO CproMatRef
                                    IF !SEEK(CrSigMvItn.Cpros + PADR(loc_cNop, 10) + ;
                                             CrSigMvItn.Mats + CrSigMvItn.Reffs, ;
                                             "TmpRelat", "CproMatRef")
                                        INSERT INTO TmpRelat ;
                                            (Grupo, Conta, Emps, Razas, CGrus, DGrus, ;
                                             CPros, DPros, Cunis, Pesoms, reffs, Mats, ;
                                             Dmats, unicompos, cunips, Nops, ObsOfs, RefMats) ;
                                            VALUES (loc_cGrupoRel, loc_cContaRel, ;
                                                    CrSigMvCab.Emps, CrSigCdEmp.Razas, ;
                                                    CrSigMvItn.CGrus, loc_cDgru, ;
                                                    CrSigMvItn.CPros, CrSigMvItn.DPros, ;
                                                    CrSigMvItn.Cunis, loc_lnPeso, ;
                                                    CrSigMvItn.Reffs, CrSigMvItn.Mats, ;
                                                    CrSigMvItn.DMats, CrSigMvItn.unicompos, ;
                                                    CrSigMvItn.cunips, loc_cNop, ;
                                                    CrSigMvItn.ObsOfs, CrSigMvItn.RefMats)
                                    ENDIF
                                    REPLACE Qtds  WITH TmpRelat.Qtds + loc_lnQtde, ;
                                            Pesos WITH TmpRelat.Pesos + loc_lnPeso ;
                                            IN TmpRelat
                                    SELECT CrSigOpPic
                                ENDSCAN

                            ELSE
                                *-- Sem OP: usar quantidade do pedido (QtdPed do SigMvItn)
                                loc_lnQtde = ROUND(CrSigMvItn.QtdPed * CrSigMvItn.Qtds, 3)
                                loc_lnPeso = ROUND(CrSigMvItn.QtdPed * CrSigMvItn.Pesos, 3)
                                loc_cDgru  = NVL(CrSigMvItn.DGrus, "")

                                SELECT TmpRelat
                                SET ORDER TO EmpCPro

                                IF !SEEK(CrSigMvItn.Cpros + SPACE(10) + ;
                                         CrSigMvItn.Mats + CrSigMvItn.Reffs, ;
                                         "TmpRelat", "CproMatRef")
                                    INSERT INTO TmpRelat ;
                                        (Grupo, Conta, Emps, Razas, CGrus, DGrus, ;
                                         CPros, DPros, Cunis, Pesoms, reffs, Mats, ;
                                         Dmats, unicompos, cunips, Nops, ObsOfs, RefMats) ;
                                        VALUES (loc_cGrupoRel, loc_cContaRel, ;
                                                CrSigMvCab.Emps, CrSigCdEmp.Razas, ;
                                                CrSigMvItn.CGrus, loc_cDgru, ;
                                                CrSigMvItn.CPros, CrSigMvItn.DPros, ;
                                                CrSigMvItn.Cunis, loc_lnPeso, ;
                                                CrSigMvItn.Reffs, CrSigMvItn.Mats, ;
                                                CrSigMvItn.DMats, CrSigMvItn.unicompos, ;
                                                CrSigMvItn.cunips, loc_cNop, ;
                                                CrSigMvItn.ObsOfs, CrSigMvItn.RefMats)
                                ENDIF
                                REPLACE Qtds  WITH TmpRelat.Qtds + loc_lnQtde, ;
                                        Pesos WITH TmpRelat.Pesos + loc_lnPeso ;
                                        IN TmpRelat
                            ENDIF

                            SELECT CrSigMvItn
                        ENDSCAN

                        SELECT CrSigMvCab
                    ENDSCAN

                    WAIT CLEAR
                ENDIF

                SELECT CrSigCdEmp
            ENDSCAN

            *-- ==============================================================
            *-- POS-PROCESSAMENTO: limpeza, totais e ordenacao
            *-- ==============================================================

            *-- Remover registros sem movimentacao real
            DELETE FROM TmpRelat WHERE Qtds <= 0 AND Pesos <= 0
            LOCATE FOR .F.

            *-- Calcular totais por unidade de medida para cabecalho
            SELECT UniCompos, SUM(Qtds) AS Qtds, CUniPs, SUM(Pesos) AS Pesos ;
                FROM TmpRelat ;
                GROUP BY UniCompos, CUniPs ;
                INTO CURSOR crTotFims READWRITE

            loc_cTot = "  Qtd 1. Ped.  |Uni|  Qtd 2. Ped. |Uni|"
            IF USED("crTotFims")
                SELECT crTotFims
                GO TOP
                SCAN
                    loc_cTot = loc_cTot + CHR(13) + ;
                               TRANSFORM(crTotFims.Qtds, "999,999,999.999") + "|" + ;
                               ALLTRIM(crTotFims.UniCompos) + "|" + ;
                               TRANSFORM(crTotFims.Pesos, "99,999,999.999") + "|" + ;
                               ALLTRIM(crTotFims.CUniPs) + "|"
                ENDSCAN
                USE IN crTotFims
            ENDIF

            SELECT dbCabecalho
            GO TOP
            REPLACE Total WITH Total + loc_cTot IN dbCabecalho

            *-- Ordenar TmpRelat conforme agrupamento selecionado
            SELECT TmpRelat
            IF THIS.this_nAgrupamento = 1
                SET ORDER TO MatRef
            ELSE
                SET ORDER TO CproMatRef
            ENDIF
            GO TOP

            loc_lSucesso = .T.
            ENDIF && loc_lContinuar (CrSigMvCab)
            ENDIF && loc_lContinuar (CrSigCdEmp)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            WAIT CLEAR
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Visualizar
    * Executa PrepararDados e exibe relatorio em modo Preview (visualizacao)
    * Equivalente ao metodo "visualizacao" do form legado
    *==========================================================================
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterNomeRelatorio()
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Imprimir
    * Executa PrepararDados e imprime com dialogo de selecao de impressora
    * Equivalente ao metodo "impressao" do form legado
    *==========================================================================
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterNomeRelatorio()
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarDocumento
    * Executa PrepararDados e envia direto para impressora (sem dialogo)
    * Equivalente ao metodo "documento" do form legado
    *==========================================================================
    PROCEDURE GerarDocumento()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterNomeRelatorio()
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria
    * Registra operacao no log de auditoria (uso em Inserir/Atualizar)
    * Em BO de RELATORIO nao ha persistencia, portanto registra apenas leitura
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Operacao, Tabela, ChavePrimaria) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL("SigReCmp") + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor
    * NAO APLICAVEL para BO de relatorio (sem tabela direta).
    * Mantido como stub para compatibilidade com pipeline de migracao.
    * Relatorios obtem dados via PrepararDados() agregando multiplas tabelas.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "CarregarDoCursor n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + "vel para relat" + ;
                                   CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Inserir
    * NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Mantido como stub para compatibilidade com pipeline de migracao.
    * Auditoria de execucao do relatorio eh registrada em PrepararDados.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Inserir n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + ;
                                   "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Atualizar
    * NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Mantido como stub para compatibilidade com pipeline de migracao.
    *==========================================================================
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Atualizar n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + ;
                                   "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Destroy - Fecha todos os cursores abertos pelo BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_TipoMov")
            USE IN cursor_4c_TipoMov
        ENDIF
        IF USED("CrSigMvCab")
            USE IN CrSigMvCab
        ENDIF
        IF USED("CrSigMvItn")
            USE IN CrSigMvItn
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        IF USED("CrSigOpPic")
            USE IN CrSigOpPic
        ENDIF
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crTotFims")
            USE IN crTotFims
        ENDIF
        IF USED("TmpNens")
            USE IN TmpNens
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

