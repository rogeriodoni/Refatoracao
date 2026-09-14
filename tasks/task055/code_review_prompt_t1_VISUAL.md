# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (25)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TipoMov' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TipoMov' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Descrs. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCmp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2714 linhas total):

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

*-- Linhas 271 a 350:
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
283: 
284:             *-- Inicializar cursor de tipos de movimentacao antes de criar o grid
285:             IF VARTYPE(THIS.this_oRelatorio) = "O"
286:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
287:                     THIS.this_oRelatorio.InicializarDados()
288:                 ELSE
289:                     *-- Modo validacao UI: criar cursor vazio para o grid funcionar
290:                     IF !USED("cursor_4c_TipoMov")
291:                         CREATE CURSOR cursor_4c_TipoMov ;
292:                             (Marca N(1), Descri C(40), Codigos N(2))
293:                     ENDIF
294:                 ENDIF
295:             ENDIF
296: 
297:             *-- ===== ROW 1: PERIODO =====
298:             loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
299:             WITH loc_oPagina.lbl_4c_Lbl_periodo
300:                 .Top       = 38
301:                 .Left      = 55
302:                 .Width     = 45
303:                 .Height    = 18
304:                 .Caption   = "Per" + CHR(237) + "odo :"
305:                 .FontName  = "Tahoma"
306:                 .FontSize  = 8
307:                 .ForeColor = RGB(90, 90, 90)
308:                 .BackStyle = 0
309:                 .Visible   = .T.
310:             ENDWITH
311: 
312:             loc_oPagina.AddObject("txt_4c__dt_inicial", "TextBox")
313:             WITH loc_oPagina.txt_4c__dt_inicial
314:                 .Top           = 33
315:                 .Left          = 104
316:                 .Width         = 80
317:                 .Height        = 25
318:                 .Value         = DATE()
319:                 .InputMask     = "99/99/9999"
320:                 .FontName      = "Tahoma"
321:                 .FontSize      = 8
322:                 .ForeColor     = RGB(90, 90, 90)
323:                 .BackColor     = RGB(255, 255, 255)
324:                 .SpecialEffect = 0
325:                 .Visible       = .T.
326:             ENDWITH
327: 
328:             loc_oPagina.AddObject("lbl_4c_Lbl_periodo_a", "Label")
329:             WITH loc_oPagina.lbl_4c_Lbl_periodo_a
330:                 .Top       = 38
331:                 .Left      = 188
332:                 .Width     = 18
333:                 .Height    = 18
334:                 .Caption   = "at" + CHR(233)
335:                 .FontName  = "Tahoma"
336:                 .FontSize  = 8
337:                 .ForeColor = RGB(90, 90, 90)
338:                 .BackStyle = 0
339:                 .Visible   = .T.
340:             ENDWITH
341: 
342:             loc_oPagina.AddObject("txt_4c__dt_final", "TextBox")
343:             WITH loc_oPagina.txt_4c__dt_final
344:                 .Top           = 33
345:                 .Left          = 212
346:                 .Width         = 80
347:                 .Height        = 25
348:                 .Value         = DATE()
349:                 .InputMask     = "99/99/9999"
350:                 .FontName      = "Tahoma"

*-- Linhas 357 a 415:
357: 
358:             loc_oPagina.AddObject("obj_4c_OptData", "OptionGroup")
359:             WITH loc_oPagina.obj_4c_OptData
360:                 .Top         = 33
361:                 .Left        = 292
362:                 .Width       = 185
363:                 .Height      = 25
364:                 .ButtonCount = 2
365:                 .BackStyle   = 0
366:                 .BorderStyle = 0
367:                 .Themes      = .F.
368:                 .Value       = 1
369:                 WITH .Buttons(1)
370:                     .Caption   = "Lan" + CHR(231) + "amento"
371:                     .Top       = 4
372:                     .Left      = 2
373:                     .Width     = 85
374:                     .Height    = 17
375:                     .BackStyle = 0
376:                     .Visible   = .T.
377:                 ENDWITH
378:                 WITH .Buttons(2)
379:                     .Caption   = "Prazo Entrega"
380:                     .FontName  = "Tahoma"
381:                     .FontSize  = 8
382:                     .Top       = 4
383:                     .Left      = 90
384:                     .Width     = 90
385:                     .Height    = 17
386:                     .BackStyle = 0
387:                     .Visible   = .T.
388:                 ENDWITH
389:                 .Visible = .T.
390:             ENDWITH
391: 
392:             *-- ===== ROW 2: MOVIMENTACAO / OP =====
393:             loc_oPagina.AddObject("lbl_4c_Lbl_operacao", "Label")
394:             WITH loc_oPagina.lbl_4c_Lbl_operacao
395:                 .Top       = 66
396:                 .Left      = 22
397:                 .Width     = 78
398:                 .Height    = 18
399:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
400:                 .FontName  = "Tahoma"
401:                 .FontSize  = 8
402:                 .ForeColor = RGB(90, 90, 90)
403:                 .BackStyle = 0
404:                 .Visible   = .T.
405:             ENDWITH
406: 
407:             loc_oPagina.AddObject("txt_4c__operacao", "TextBox")
408:             WITH loc_oPagina.txt_4c__operacao
409:                 .Top           = 61
410:                 .Left          = 104
411:                 .Width         = 150
412:                 .Height        = 25
413:                 .Value         = ""
414:                 .FontName      = "Tahoma"
415:                 .FontSize      = 8

*-- Linhas 421 a 474:
421: 
422:             loc_oPagina.AddObject("txt_4c_Numes", "TextBox")
423:             WITH loc_oPagina.txt_4c_Numes
424:                 .Top           = 61
425:                 .Left          = 257
426:                 .Width         = 54
427:                 .Height        = 25
428:                 .Value         = 0
429:                 .InputMask     = "######"
430:                 .FontName      = "Tahoma"
431:                 .FontSize      = 8
432:                 .ForeColor     = RGB(90, 90, 90)
433:                 .BackColor     = RGB(255, 255, 255)
434:                 .SpecialEffect = 0
435:                 .Visible       = .T.
436:             ENDWITH
437: 
438:             loc_oPagina.AddObject("lbl_4c_Lbl_op", "Label")
439:             WITH loc_oPagina.lbl_4c_Lbl_op
440:                 .Top       = 66
441:                 .Left      = 318
442:                 .Width     = 23
443:                 .Height    = 18
444:                 .Caption   = "OP:"
445:                 .FontName  = "Tahoma"
446:                 .FontSize  = 8
447:                 .ForeColor = RGB(90, 90, 90)
448:                 .BackStyle = 0
449:                 .Visible   = .T.
450:             ENDWITH
451: 
452:             loc_oPagina.AddObject("chk_4c_ChkImpOp", "CheckBox")
453:             WITH loc_oPagina.chk_4c_ChkImpOp
454:                 .Top     = 66
455:                 .Left    = 344
456:                 .Width   = 15
457:                 .Height  = 15
458:                 .Caption = ""
459:                 .Value   = 0
460:                 .FontName = "Tahoma"
461:                 .FontSize = 8
462:                 .Themes  = .F.
463:                 .Visible = .T.
464:             ENDWITH
465: 
466:             loc_oPagina.AddObject("txt_4c_Opi", "TextBox")
467:             WITH loc_oPagina.txt_4c_Opi
468:                 .Top           = 61
469:                 .Left          = 363
470:                 .Width         = 54
471:                 .Height        = 25
472:                 .Value         = 0
473:                 .InputMask     = "######"
474:                 .FontName      = "Tahoma"

*-- Linhas 480 a 505:
480:                 .Visible       = .T.
481:             ENDWITH
482: 
483:             loc_oPagina.AddObject("lbl_4c_Label3", "Label")
484:             WITH loc_oPagina.lbl_4c_Label3
485:                 .Top       = 66
486:                 .Left      = 422
487:                 .Width     = 20
488:                 .Height    = 18
489:                 .Caption   = "at" + CHR(233)
490:                 .FontName  = "Tahoma"
491:                 .FontSize  = 8
492:                 .ForeColor = RGB(90, 90, 90)
493:                 .BackStyle = 0
494:                 .Visible   = .T.
495:             ENDWITH
496: 
497:             loc_oPagina.AddObject("txt_4c_Opf", "TextBox")
498:             WITH loc_oPagina.txt_4c_Opf
499:                 .Top           = 61
500:                 .Left          = 445
501:                 .Width         = 54
502:                 .Height        = 25
503:                 .Value         = 0
504:                 .InputMask     = "######"
505:                 .FontName      = "Tahoma"

*-- Linhas 512 a 537:
512:             ENDWITH
513: 
514:             *-- ===== ROW 3: OBSERVACAO =====
515:             loc_oPagina.AddObject("lbl_4c_Label18", "Label")
516:             WITH loc_oPagina.lbl_4c_Label18
517:                 .Top       = 94
518:                 .Left      = 33
519:                 .Width     = 67
520:                 .Height    = 18
521:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
522:                 .FontName  = "Tahoma"
523:                 .FontSize  = 8
524:                 .ForeColor = RGB(90, 90, 90)
525:                 .BackStyle = 0
526:                 .Visible   = .T.
527:             ENDWITH
528: 
529:             loc_oPagina.AddObject("txt_4c_CodObs", "TextBox")
530:             WITH loc_oPagina.txt_4c_CodObs
531:                 .Top           = 90
532:                 .Left          = 104
533:                 .Width         = 31
534:                 .Height        = 23
535:                 .Value         = 0
536:                 .InputMask     = "###"
537:                 .FontName      = "Tahoma"

*-- Linhas 544 a 553:
544: 
545:             loc_oPagina.AddObject("txt_4c_DesObs", "TextBox")
546:             WITH loc_oPagina.txt_4c_DesObs
547:                 .Top           = 90
548:                 .Left          = 138
549:                 .Width         = 361
550:                 .Height        = 23
551:                 .Value         = ""
552:                 .FontName      = "Tahoma"
553:                 .FontSize      = 8

*-- Linhas 559 a 584:
559:             ENDWITH
560: 
561:             *-- ===== ROW 4: EMPRESA =====
562:             loc_oPagina.AddObject("lbl_4c_Lbl_empresa", "Label")
563:             WITH loc_oPagina.lbl_4c_Lbl_empresa
564:                 .Top       = 122
565:                 .Left      = 50
566:                 .Width     = 50
567:                 .Height    = 18
568:                 .Caption   = "Empresa :"
569:                 .FontName  = "Tahoma"
570:                 .FontSize  = 8
571:                 .ForeColor = RGB(90, 90, 90)
572:                 .BackStyle = 0
573:                 .Visible   = .T.
574:             ENDWITH
575: 
576:             loc_oPagina.AddObject("txt_4c__empresa", "TextBox")
577:             WITH loc_oPagina.txt_4c__empresa
578:                 .Top           = 117
579:                 .Left          = 104
580:                 .Width         = 31
581:                 .Height        = 25
582:                 .Value         = ""
583:                 .InputMask     = "XXX"
584:                 .FontName      = "Tahoma"

*-- Linhas 591 a 600:
591: 
592:             loc_oPagina.AddObject("txt_4c__empresa_desc", "TextBox")
593:             WITH loc_oPagina.txt_4c__empresa_desc
594:                 .Top           = 117
595:                 .Left          = 138
596:                 .Width         = 361
597:                 .Height        = 25
598:                 .Value         = ""
599:                 .FontName      = "Tahoma"
600:                 .FontSize      = 8

*-- Linhas 606 a 631:
606:             ENDWITH
607: 
608:             *-- ===== ROW 5 ESQUERDA: GRUPO ESTOQUE =====
609:             loc_oPagina.AddObject("lbl_4c_Label1_GrupoContab", "Label")
610:             WITH loc_oPagina.lbl_4c_Label1_GrupoContab
611:                 .Top       = 150
612:                 .Left      = 62
613:                 .Width     = 38
614:                 .Height    = 18
615:                 .Caption   = "Grupo :"
616:                 .FontName  = "Tahoma"
617:                 .FontSize  = 8
618:                 .ForeColor = RGB(90, 90, 90)
619:                 .BackStyle = 0
620:                 .Visible   = .T.
621:             ENDWITH
622: 
623:             loc_oPagina.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
624:             WITH loc_oPagina.txt_4c__Cd_GrEstoque
625:                 .Top           = 145
626:                 .Left          = 104
627:                 .Width         = 80
628:                 .Height        = 25
629:                 .Value         = ""
630:                 .FontName      = "Tahoma"
631:                 .FontSize      = 8

*-- Linhas 637 a 646:
637: 
638:             loc_oPagina.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
639:             WITH loc_oPagina.txt_4c__Ds_GrEstoque
640:                 .Top           = 145
641:                 .Left          = 187
642:                 .Width         = 312
643:                 .Height        = 25
644:                 .Value         = ""
645:                 .FontName      = "Tahoma"
646:                 .FontSize      = 8

*-- Linhas 652 a 693:
652:             ENDWITH
653: 
654:             *-- ===== ROW 5 DIREITA: LABEL TIPO MOV =====
655:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
656:             WITH loc_oPagina.lbl_4c_Label1
657:                 .Top       = 145
658:                 .Left      = 511
659:                 .Width     = 172
660:                 .Height    = 17
661:                 .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o"
662:                 .FontName  = "Tahoma"
663:                 .FontSize  = 8
664:                 .FontBold  = .T.
665:                 .ForeColor = RGB(90, 90, 90)
666:                 .BackStyle = 0
667:                 .Visible   = .T.
668:             ENDWITH
669: 
670:             *-- ===== ROW 6 ESQUERDA: CONTA ESTOQUE =====
671:             loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
672:             WITH loc_oPagina.lbl_4c_Lbl_estoque
673:                 .Top       = 178
674:                 .Left      = 62
675:                 .Width     = 38
676:                 .Height    = 18
677:                 .Caption   = "Conta :"
678:                 .FontName  = "Tahoma"
679:                 .FontSize  = 8
680:                 .ForeColor = RGB(90, 90, 90)
681:                 .BackStyle = 0
682:                 .Visible   = .T.
683:             ENDWITH
684: 
685:             loc_oPagina.AddObject("txt_4c__cd_estoque", "TextBox")
686:             WITH loc_oPagina.txt_4c__cd_estoque
687:                 .Top           = 173
688:                 .Left          = 104
689:                 .Width         = 80
690:                 .Height        = 25
691:                 .Value         = ""
692:                 .FontName      = "Tahoma"
693:                 .FontSize      = 8

*-- Linhas 700 a 709:
700: 
701:             loc_oPagina.AddObject("txt_4c__ds_estoque", "TextBox")
702:             WITH loc_oPagina.txt_4c__ds_estoque
703:                 .Top           = 173
704:                 .Left          = 187
705:                 .Width         = 312
706:                 .Height        = 25
707:                 .Value         = ""
708:                 .FontName      = "Tahoma"
709:                 .FontSize      = 8

*-- Linhas 718 a 832:
718:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
719:             loc_oGrid = loc_oPagina.grd_4c_Dados
720:             WITH loc_oGrid
721:                 .Top                = 158
722:                 .Left               = 511
723:                 .Width              = 251
724:                 .Height             = 130
725:                 .ColumnCount        = 2
726:                 .RecordSource       = "cursor_4c_TipoMov"
727:                 .RecordSourceType   = 1
728:                 .FontName           = "Verdana"
729:                 .FontSize           = 8
730:                 .ForeColor          = RGB(90, 90, 90)
731:                 .BackColor          = RGB(255, 255, 255)
732:                 .GridLineColor      = RGB(238, 238, 238)
733:                 .HighlightBackColor = RGB(255, 255, 255)
734:                 .HighlightForeColor = RGB(15, 41, 104)
735:                 .HighlightStyle     = 2
736:                 .DeleteMark         = .F.
737:                 .RecordMark         = .F.
738:                 .RowHeight          = 16
739:                 .ScrollBars         = 2
740:                 .Themes             = .F.
741: 
742:                 *-- Column1: CheckBox para Marca (campo booleano de selecao)
743:                 WITH .Column1
744:                     .Width = 25
745:                     .Header1.Caption = ""
746:                     .AddObject("Check1", "CheckBox")
747:                     .Check1.Caption = ""
748:                     .Check1.Value = 0
749:                     .CurrentControl = "Check1"
750:                     .ControlSource = "cursor_4c_TipoMov.Marca"
751:                     .Visible = .T.
752:                 ENDWITH
753: 
754:                 *-- Column2: Descricao do tipo de movimentacao
755:                 WITH .Column2
756:                     .Width = 224
757:                     .ControlSource = "cursor_4c_TipoMov.Descri"
758:                     .ReadOnly = .T.
759:                     .Header1.Caption = "Tipo"
760:                     .Visible = .T.
761:                 ENDWITH
762: 
763:                 .Visible = .T.
764:             ENDWITH
765: 
766:             *-- Re-definir ControlSource apos RecordSource (auto-bind por ordem de campo pode sobrescrever)
767:             loc_oGrid.Column1.ControlSource = "cursor_4c_TipoMov.Marca"
768:             loc_oGrid.Column2.ControlSource = "cursor_4c_TipoMov.Descri"
769: 
770:             *-- Botoes SelTudo / Apaga (direita do grid)
771:             loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
772:             WITH loc_oPagina.cmd_4c_SelTudo
773:                 .Top          = 186
774:                 .Left         = 763
775:                 .Width        = 35
776:                 .Height       = 34
777:                 .Caption      = ""
778:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
779:                 .ToolTipText  = "Selecionar Todos"
780:                 .FontName     = "Tahoma"
781:                 .FontSize     = 8
782:                 .ForeColor    = RGB(90, 90, 90)
783:                 .BackColor    = RGB(255, 255, 255)
784:                 .Themes       = .F.
785:                 .SpecialEffect = 0
786:                 .MousePointer = 15
787:                 .Visible      = .T.
788:             ENDWITH
789: 
790:             loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
791:             WITH loc_oPagina.cmd_4c_Apaga
792:                 .Top          = 221
793:                 .Left         = 763
794:                 .Width        = 35
795:                 .Height       = 34
796:                 .Caption      = ""
797:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
798:                 .ToolTipText  = "Desmarcar Todos"
799:                 .FontName     = "Tahoma"
800:                 .FontSize     = 8
801:                 .ForeColor    = RGB(90, 90, 90)
802:                 .BackColor    = RGB(255, 255, 255)
803:                 .Themes       = .F.
804:                 .SpecialEffect = 0
805:                 .MousePointer = 15
806:                 .Visible      = .T.
807:             ENDWITH
808: 
809:             *-- ===== ROW 7: GRANDE GRUPO =====
810:             loc_oPagina.AddObject("lbl_4c_Label5", "Label")
811:             WITH loc_oPagina.lbl_4c_Label5
812:                 .Top       = 206
813:                 .Left      = 24
814:                 .Width     = 76
815:                 .Height    = 18
816:                 .Caption   = "Grande Grupo :"
817:                 .FontName  = "Tahoma"
818:                 .FontSize  = 8
819:                 .ForeColor = RGB(90, 90, 90)
820:                 .BackStyle = 0
821:                 .Visible   = .T.
822:             ENDWITH
823: 
824:             loc_oPagina.AddObject("txt_4c__cd_ggrupo", "TextBox")
825:             WITH loc_oPagina.txt_4c__cd_ggrupo
826:                 .Top           = 201
827:                 .Left          = 104
828:                 .Width         = 31
829:                 .Height        = 25
830:                 .Value         = ""
831:                 .InputMask     = "##"
832:                 .FontName      = "Tahoma"

*-- Linhas 839 a 848:
839: 
840:             loc_oPagina.AddObject("txt_4c__ds_ggrupo", "TextBox")
841:             WITH loc_oPagina.txt_4c__ds_ggrupo
842:                 .Top           = 201
843:                 .Left          = 138
844:                 .Width         = 361
845:                 .Height        = 25
846:                 .Value         = ""
847:                 .FontName      = "Tahoma"
848:                 .FontSize      = 8

*-- Linhas 854 a 879:
854:             ENDWITH
855: 
856:             *-- ===== ROW 8: GRUPO PRODUTO =====
857:             loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
858:             WITH loc_oPagina.lbl_4c_Lbl_grupo
859:                 .Top       = 235
860:                 .Left      = 21
861:                 .Width     = 79
862:                 .Height    = 18
863:                 .Caption   = "Grupo Produto :"
864:                 .FontName  = "Tahoma"
865:                 .FontSize  = 8
866:                 .ForeColor = RGB(90, 90, 90)
867:                 .BackStyle = 0
868:                 .Visible   = .T.
869:             ENDWITH
870: 
871:             loc_oPagina.AddObject("txt_4c__grupo", "TextBox")
872:             WITH loc_oPagina.txt_4c__grupo
873:                 .Top           = 230
874:                 .Left          = 104
875:                 .Width         = 31
876:                 .Height        = 25
877:                 .Value         = ""
878:                 .InputMask     = "XXX"
879:                 .FontName      = "Tahoma"

*-- Linhas 886 a 895:
886: 
887:             loc_oPagina.AddObject("txt_4c__grupo_desc", "TextBox")
888:             WITH loc_oPagina.txt_4c__grupo_desc
889:                 .Top           = 230
890:                 .Left          = 138
891:                 .Width         = 361
892:                 .Height        = 25
893:                 .Value         = ""
894:                 .FontName      = "Tahoma"
895:                 .FontSize      = 8

*-- Linhas 901 a 926:
901:             ENDWITH
902: 
903:             *-- ===== ROW 9: SUBGRUPO =====
904:             loc_oPagina.AddObject("lbl_4c_Label16", "Label")
905:             WITH loc_oPagina.lbl_4c_Label16
906:                 .Top       = 264
907:                 .Left      = 45
908:                 .Width     = 55
909:                 .Height    = 15
910:                 .Caption   = "Subgrupo :"
911:                 .FontName  = "Tahoma"
912:                 .FontSize  = 8
913:                 .ForeColor = RGB(90, 90, 90)
914:                 .BackStyle = 0
915:                 .Visible   = .T.
916:             ENDWITH
917: 
918:             loc_oPagina.AddObject("txt_4c__cd_sgrupo", "TextBox")
919:             WITH loc_oPagina.txt_4c__cd_sgrupo
920:                 .Top           = 259
921:                 .Left          = 104
922:                 .Width         = 52
923:                 .Height        = 25
924:                 .Value         = ""
925:                 .InputMask     = "XXXXXXX"
926:                 .FontName      = "Tahoma"

*-- Linhas 933 a 1124:
933: 
934:             loc_oPagina.AddObject("txt_4c__ds_sgrupo", "TextBox")
935:             WITH loc_oPagina.txt_4c__ds_sgrupo
936:                 .Top           = 259
937:                 .Left          = 158
938:                 .Width         = 341
939:                 .Height        = 25
940:                 .Value         = ""
941:                 .FontName      = "Tahoma"
942:                 .FontSize      = 8
943:                 .ForeColor     = RGB(90, 90, 90)
944:                 .BackColor     = RGB(255, 255, 255)
945:                 .Enabled       = .F.
946:                 .SpecialEffect = 0
947:                 .Visible       = .T.
948:             ENDWITH
949: 
950:             *-- ===== ROW 10: SITUACAO + CHECKBOXES =====
951:             loc_oPagina.AddObject("lbl_4c_Label7", "Label")
952:             WITH loc_oPagina.lbl_4c_Label7
953:                 .Top       = 290
954:                 .Left      = 50
955:                 .Width     = 50
956:                 .Height    = 18
957:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
958:                 .FontName  = "Tahoma"
959:                 .FontSize  = 8
960:                 .ForeColor = RGB(90, 90, 90)
961:                 .BackStyle = 0
962:                 .Visible   = .T.
963:             ENDWITH
964: 
965:             loc_oPagina.AddObject("obj_4c_OptSituas", "OptionGroup")
966:             WITH loc_oPagina.obj_4c_OptSituas
967:                 .Top         = 284
968:                 .Left        = 100
969:                 .Width       = 311
970:                 .Height      = 27
971:                 .ButtonCount = 3
972:                 .BackStyle   = 0
973:                 .BorderStyle = 0
974:                 .Themes      = .F.
975:                 .Value       = 3
976:                 WITH .Buttons(1)
977:                     .Caption   = "N.Ind."
978:                     .Top       = 4
979:                     .Left      = 2
980:                     .Width     = 60
981:                     .Height    = 17
982:                     .BackStyle = 0
983:                     .Visible   = .T.
984:                 ENDWITH
985:                 WITH .Buttons(2)
986:                     .Caption   = "Industrializada"
987:                     .FontName  = "Tahoma"
988:                     .FontSize  = 8
989:                     .Top       = 4
990:                     .Left      = 65
991:                     .Width     = 100
992:                     .Height    = 17
993:                     .BackStyle = 0
994:                     .Visible   = .T.
995:                 ENDWITH
996:                 WITH .Buttons(3)
997:                     .Caption   = "Todos"
998:                     .FontName  = "Tahoma"
999:                     .FontSize  = 8
1000:                     .Top       = 4
1001:                     .Left      = 168
1002:                     .Width     = 60
1003:                     .Height    = 17
1004:                     .BackStyle = 0
1005:                     .Visible   = .T.
1006:                 ENDWITH
1007:                 .Visible = .T.
1008:             ENDWITH
1009: 
1010:             loc_oPagina.AddObject("chk_4c_ChkPendente", "CheckBox")
1011:             WITH loc_oPagina.chk_4c_ChkPendente
1012:                 .Top      = 289
1013:                 .Left     = 421
1014:                 .Width    = 69
1015:                 .Height   = 15
1016:                 .Caption  = "Pendentes"
1017:                 .Value    = 0
1018:                 .FontName = "Tahoma"
1019:                 .FontSize = 8
1020:                 .Enabled  = .F.
1021:                 .Themes   = .F.
1022:                 .Visible  = .T.
1023:             ENDWITH
1024: 
1025:             loc_oPagina.AddObject("chk_4c_ChkOrdem", "CheckBox")
1026:             WITH loc_oPagina.chk_4c_ChkOrdem
1027:                 .Top      = 289
1028:                 .Left     = 516
1029:                 .Width    = 171
1030:                 .Height   = 15
1031:                 .Caption  = "Filtro por Ordem de Composi" + CHR(231) + CHR(227) + "o"
1032:                 .Value    = 0
1033:                 .FontName = "Tahoma"
1034:                 .FontSize = 8
1035:                 .Themes   = .F.
1036:                 .Visible  = .T.
1037:             ENDWITH
1038: 
1039:             *-- ===== ROW 11: AGRUPAMENTO + SERVICO =====
1040:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
1041:             WITH loc_oPagina.lbl_4c_Label2
1042:                 .Top       = 311
1043:                 .Left      = 26
1044:                 .Width     = 74
1045:                 .Height    = 18
1046:                 .Caption   = "Agrupamento :"
1047:                 .FontName  = "Tahoma"
1048:                 .FontSize  = 8
1049:                 .ForeColor = RGB(90, 90, 90)
1050:                 .BackStyle = 0
1051:                 .Visible   = .T.
1052:             ENDWITH
1053: 
1054:             loc_oPagina.AddObject("obj_4c_Optagrupa", "OptionGroup")
1055:             WITH loc_oPagina.obj_4c_Optagrupa
1056:                 .Top         = 306
1057:                 .Left        = 100
1058:                 .Width       = 198
1059:                 .Height      = 25
1060:                 .ButtonCount = 2
1061:                 .BackStyle   = 0
1062:                 .BorderStyle = 0
1063:                 .Themes      = .F.
1064:                 .Value       = 1
1065:                 WITH .Buttons(1)
1066:                     .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
1067:                     .Top       = 4
1068:                     .Left      = 2
1069:                     .Width     = 90
1070:                     .Height    = 17
1071:                     .BackStyle = 0
1072:                     .Visible   = .T.
1073:                 ENDWITH
1074:                 WITH .Buttons(2)
1075:                     .Caption   = "OP"
1076:                     .FontName  = "Tahoma"
1077:                     .FontSize  = 8
1078:                     .Top       = 4
1079:                     .Left      = 95
1080:                     .Width     = 40
1081:                     .Height    = 17
1082:                     .BackStyle = 0
1083:                     .Visible   = .T.
1084:                 ENDWITH
1085:                 .Visible = .T.
1086:             ENDWITH
1087: 
1088:             loc_oPagina.AddObject("chk_4c_Chkservico", "CheckBox")
1089:             WITH loc_oPagina.chk_4c_Chkservico
1090:                 .Top      = 310
1091:                 .Left     = 368
1092:                 .Width    = 110
1093:                 .Height   = 15
1094:                 .Caption  = "Industrializa" + CHR(231) + CHR(227) + "o (S)"
1095:                 .Value    = 0
1096:                 .FontName = "Tahoma"
1097:                 .FontSize = 8
1098:                 .Enabled  = .F.
1099:                 .Themes   = .F.
1100:                 .Visible  = .T.
1101:             ENDWITH
1102: 
1103:             *-- ===== BINDEVENTS =====
1104:             BINDEVENT(loc_oPagina.chk_4c_ChkImpOp, "InteractiveChange", ;
1105:                 THIS, "ChkImpOpChange")
1106:             BINDEVENT(loc_oPagina.obj_4c_OptSituas, "InteractiveChange", ;
1107:                 THIS, "OptSituasChange")
1108:             BINDEVENT(loc_oPagina.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
1109:             BINDEVENT(loc_oPagina.cmd_4c_Apaga,   "Click", THIS, "BtnApagaClick")
1110:             BINDEVENT(loc_oPagina.txt_4c__operacao, "KeyPress", ;
1111:                 THIS, "TxtOperacaoKeyPress")
1112:             BINDEVENT(loc_oPagina.txt_4c_CodObs, "KeyPress", ;
1113:                 THIS, "TxtCodObsKeyPress")
1114:             BINDEVENT(loc_oPagina.txt_4c_DesObs, "KeyPress", ;
1115:                 THIS, "TxtDesObsKeyPress")
1116:             BINDEVENT(loc_oPagina.txt_4c__empresa, "KeyPress", ;
1117:                 THIS, "TxtEmpresaKeyPress")
1118:             BINDEVENT(loc_oPagina.txt_4c__Cd_GrEstoque, "KeyPress", ;
1119:                 THIS, "TxtGrEstoqueKeyPress")
1120:             BINDEVENT(loc_oPagina.txt_4c__cd_ggrupo, "KeyPress", ;
1121:                 THIS, "TxtGrdGrupoKeyPress")
1122:             BINDEVENT(loc_oPagina.txt_4c__ds_ggrupo, "KeyPress", ;
1123:                 THIS, "TxtGrdGrupoDescKeyPress")
1124:             BINDEVENT(loc_oPagina.txt_4c__grupo, "KeyPress", ;

*-- Linhas 1187 a 1195:
1187:                 loc_oPagina.txt_4c_Opf.Enabled = .F.
1188:             ENDIF
1189: 
1190:             *-- Checkboxes contextuais desabilitados ate condicao de habilitacao ser satisfeita
1191:             IF PEMSTATUS(loc_oPagina, "chk_4c_Chkservico", 5)
1192:                 loc_oPagina.chk_4c_Chkservico.Enabled = .F.
1193:             ENDIF
1194:             IF PEMSTATUS(loc_oPagina, "chk_4c_ChkPendente", 5)
1195:                 loc_oPagina.chk_4c_ChkPendente.Enabled = .F.


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
            CREATE CURSOR cursor_4c_TipoMov (Marca N(1), Descri C(40), Codigos N(2))
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

