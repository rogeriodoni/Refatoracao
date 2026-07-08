# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 181: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 202: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 224: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReDpD.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2628 linhas total):

*-- Linhas 47 a 55:
47:         loc_lContinuar = .T.
48: 
49:         TRY
50:             THIS.Caption = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"
51: 
52:             IF TYPE("gc_4c_CaminhoIcones") = "U"
53:                 gc_4c_CaminhoIcones = ""
54:             ENDIF
55:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 72 a 81:
72:                 THIS.ConfigurarContainerOperacoes()
73:                 THIS.VincularEventos()
74:                 THIS.LimparCampos()
75:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
76:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
77:                 THIS.Visible = .T.
78:                 loc_lSucesso = .T.
79:             ENDIF
80: 
81:         CATCH TO loc_oErro

*-- Linhas 94 a 166:
94:     PROTECTED PROCEDURE ConfigurarCabecalho()
95:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
96:         WITH THIS.cnt_4c_Cabecalho
97:             .Top         = 0
98:             .Left        = 0
99:             .Width       = THIS.Width
100:             .Height      = 80
101:             .BackStyle   = 1
102:             .BackColor   = RGB(100, 100, 100)
103:             .BorderWidth = 0
104:             .Visible     = .T.
105: 
106:             .AddObject("lbl_4c_Sombra", "Label")
107:             WITH .lbl_4c_Sombra
108:                 .Top       = 22
109:                 .Left      = 22
110:                 .Width     = THIS.Width
111:                 .Height    = 30
112:                 .Caption   = THIS.Caption
113:                 .FontName  = "Tahoma"
114:                 .FontSize  = 14
115:                 .FontBold  = .T.
116:                 .ForeColor = RGB(0, 0, 0)
117:                 .BackStyle = 0
118:                 .Visible   = .T.
119:             ENDWITH
120: 
121:             .AddObject("lbl_4c_Titulo", "Label")
122:             WITH .lbl_4c_Titulo
123:                 .Top       = 20
124:                 .Left      = 20
125:                 .Width     = THIS.Width
126:                 .Height    = 30
127:                 .Caption   = THIS.Caption
128:                 .FontName  = "Tahoma"
129:                 .FontSize  = 14
130:                 .FontBold  = .T.
131:                 .ForeColor = RGB(255, 255, 255)
132:                 .BackStyle = 0
133:                 .Visible   = .T.
134:             ENDWITH
135:         ENDWITH
136:     ENDPROC
137: 
138:     *--------------------------------------------------------------------------
139:     * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
140:     * Original: btnReport.Left=527, Top=3 -> canonico Left=529, Top=0
141:     *--------------------------------------------------------------------------
142:     PROTECTED PROCEDURE ConfigurarBotoes()
143:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
144:         WITH THIS.cmg_4c_Botoes
145:             .Top           = 0
146:             .Left          = 529
147:             .Width         = 273
148:             .Height        = 80
149:             .ButtonCount   = 4
150:             .BackStyle     = 0
151:             .BorderStyle   = 0
152:             .SpecialEffect = 1
153:             .Themes        = .F.
154:             .Visible       = .T.
155: 
156:             WITH .Buttons(1)
157:                 .Top             = 5
158:                 .Left            = 5
159:                 .Width           = 65
160:                 .Height          = 70
161:                 .Caption         = "Visualizar"
162:                 .FontBold        = .T.
163:                 .FontItalic      = .T.
164:                 .BackColor       = RGB(255, 255, 255)
165:                 .ForeColor       = RGB(90, 90, 90)
166:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 173 a 187:
173:             ENDWITH
174: 
175:             WITH .Buttons(2)
176:                 .Top             = 5
177:                 .Left            = 71
178:                 .Width           = 65
179:                 .Height          = 70
180:                 .Caption         = "Imprimir"
181:                 .FontName        = "Comic Sans MS"
182:                 .FontBold        = .T.
183:                 .FontItalic      = .T.
184:                 .FontSize        = 8
185:                 .BackColor       = RGB(255, 255, 255)
186:                 .ForeColor       = RGB(90, 90, 90)
187:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 194 a 208:
194:             ENDWITH
195: 
196:             WITH .Buttons(3)
197:                 .Top             = 5
198:                 .Left            = 137
199:                 .Width           = 65
200:                 .Height          = 70
201:                 .Caption         = "Excel"
202:                 .FontName        = "Comic Sans MS"
203:                 .FontBold        = .T.
204:                 .FontItalic      = .T.
205:                 .FontSize        = 8
206:                 .BackColor       = RGB(255, 255, 255)
207:                 .ForeColor       = RGB(90, 90, 90)
208:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 215 a 230:
215:             ENDWITH
216: 
217:             WITH .Buttons(4)
218:                 .Top             = 5
219:                 .Left            = 203
220:                 .Width           = 65
221:                 .Height          = 70
222:                 .Caption         = "Encerrar"
223:                 .Cancel          = .T.
224:                 .FontName        = "Comic Sans MS"
225:                 .FontBold        = .T.
226:                 .FontItalic      = .T.
227:                 .FontSize        = 8
228:                 .BackColor       = RGB(255, 255, 255)
229:                 .ForeColor       = RGB(90, 90, 90)
230:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 248 a 262:
248:         loc_oPgf = THIS.pgf_4c_Paginas
249: 
250:         loc_oPgf.PageCount  = 1
251:         loc_oPgf.Top        = 85
252:         loc_oPgf.Left       = -1
253:         loc_oPgf.Width      = THIS.Width + 2
254:         loc_oPgf.Height     = THIS.Height - 85
255:         loc_oPgf.Tabs       = .F.
256: 
257:         loc_oPgf.Page1.Caption   = "Filtros"
258:         loc_oPgf.Page1.FontName  = "Tahoma"
259:         loc_oPgf.Page1.FontSize  = 8
260:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
261:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
262:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 274 a 475:
274:         loc_oPg = THIS.pgf_4c_Paginas.Page1
275: 
276:         *-- "Periodo :" (Say_Conta: Top=97->12, Left=73)
277:         loc_oPg.AddObject("lbl_4c_Periodo", "Label")
278:         WITH loc_oPg.lbl_4c_Periodo
279:             .Top       = 12
280:             .Left      = 73
281:             .Width     = 45
282:             .Height    = 17
283:             .Caption   = "Per" + CHR(237) + "odo :"
284:             .FontName  = "Tahoma"
285:             .FontSize  = 8
286:             .ForeColor = RGB(90, 90, 90)
287:             .BackStyle = 0
288:             .AutoSize  = .T.
289:             .Visible   = .T.
290:         ENDWITH
291: 
292:         *-- "ate" (Say1: Top=97->12, Left=204)
293:         loc_oPg.AddObject("lbl_4c_Ate", "Label")
294:         WITH loc_oPg.lbl_4c_Ate
295:             .Top       = 12
296:             .Left      = 204
297:             .Width     = 24
298:             .Height    = 17
299:             .Caption   = " at" + CHR(233) + " "
300:             .FontSize  = 8
301:             .BackStyle = 0
302:             .Visible   = .T.
303:         ENDWITH
304: 
305:         *-- "Tipo de OP:" (Label5: Top=123->38, Left=60)
306:         loc_oPg.AddObject("lbl_4c_TpGOp", "Label")
307:         WITH loc_oPg.lbl_4c_TpGOp
308:             .Top       = 38
309:             .Left      = 60
310:             .Width     = 58
311:             .Height    = 15
312:             .Caption   = "Tipo de OP:"
313:             .FontName  = "Tahoma"
314:             .FontSize  = 8
315:             .ForeColor = RGB(90, 90, 90)
316:             .BackStyle = 0
317:             .Visible   = .T.
318:         ENDWITH
319: 
320:         *-- "Movimentacao :" (lbl_dopes: Top=149->64, Left=40)
321:         loc_oPg.AddObject("lbl_4c_GetDopes", "Label")
322:         WITH loc_oPg.lbl_4c_GetDopes
323:             .Top       = 64
324:             .Left      = 40
325:             .Width     = 78
326:             .Height    = 15
327:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
328:             .FontName  = "Tahoma"
329:             .FontSize  = 8
330:             .ForeColor = RGB(90, 90, 90)
331:             .BackStyle = 0
332:             .AutoSize  = .T.
333:             .Visible   = .T.
334:         ENDWITH
335: 
336:         *-- "Grupo :" (Say2: Top=175->90, Left=80)
337:         loc_oPg.AddObject("lbl_4c_Grupo", "Label")
338:         WITH loc_oPg.lbl_4c_Grupo
339:             .Top       = 90
340:             .Left      = 80
341:             .Width     = 38
342:             .Height    = 17
343:             .Caption   = "Grupo :"
344:             .FontName  = "Tahoma"
345:             .FontSize  = 8
346:             .ForeColor = RGB(90, 90, 90)
347:             .BackStyle = 0
348:             .AutoSize  = .T.
349:             .Visible   = .T.
350:         ENDWITH
351: 
352:         *-- "Conta :" (Say3: Top=201->116, Left=80)
353:         loc_oPg.AddObject("lbl_4c_Conta", "Label")
354:         WITH loc_oPg.lbl_4c_Conta
355:             .Top       = 116
356:             .Left      = 80
357:             .Width     = 38
358:             .Height    = 17
359:             .Caption   = "Conta :"
360:             .FontName  = "Tahoma"
361:             .FontSize  = 8
362:             .ForeColor = RGB(90, 90, 90)
363:             .BackStyle = 0
364:             .AutoSize  = .T.
365:             .Visible   = .T.
366:         ENDWITH
367: 
368:         *-- "Grande Grupo :" (Say7: Top=227->142, Left=42)
369:         loc_oPg.AddObject("lbl_4c_GGrp", "Label")
370:         WITH loc_oPg.lbl_4c_GGrp
371:             .Top       = 142
372:             .Left      = 42
373:             .Width     = 76
374:             .Height    = 15
375:             .Caption   = "Grande Grupo :"
376:             .FontName  = "Tahoma"
377:             .FontSize  = 8
378:             .ForeColor = RGB(90, 90, 90)
379:             .BackStyle = 0
380:             .Visible   = .T.
381:         ENDWITH
382: 
383:         *-- "Grupo Mat. Prima :" (Say8: Top=253->168, Left=26)
384:         loc_oPg.AddObject("lbl_4c_GruMat", "Label")
385:         WITH loc_oPg.lbl_4c_GruMat
386:             .Top       = 168
387:             .Left      = 26
388:             .Width     = 92
389:             .Height    = 15
390:             .Caption   = "Grupo Mat. Prima :"
391:             .FontName  = "Tahoma"
392:             .FontSize  = 8
393:             .ForeColor = RGB(90, 90, 90)
394:             .BackStyle = 0
395:             .Visible   = .T.
396:         ENDWITH
397: 
398:         *-- "Tipo de Material :" (Say4: Top=279->194, Left=33)
399:         loc_oPg.AddObject("lbl_4c_TpOps", "Label")
400:         WITH loc_oPg.lbl_4c_TpOps
401:             .Top       = 194
402:             .Left      = 33
403:             .Width     = 85
404:             .Height    = 15
405:             .Caption   = "Tipo de Material :"
406:             .FontName  = "Tahoma"
407:             .FontSize  = 8
408:             .ForeColor = RGB(90, 90, 90)
409:             .BackStyle = 0
410:             .AutoSize  = .T.
411:             .Visible   = .T.
412:         ENDWITH
413: 
414:         *-- "Envelope :" (Say5: Top=279->194, Left=252)
415:         loc_oPg.AddObject("lbl_4c_Envelope", "Label")
416:         WITH loc_oPg.lbl_4c_Envelope
417:             .Top       = 194
418:             .Left      = 252
419:             .Width     = 53
420:             .Height    = 15
421:             .Caption   = "Envelope :"
422:             .FontSize  = 8
423:             .BackStyle = 0
424:             .Visible   = .T.
425:         ENDWITH
426: 
427:         *-- "OP :" (Say6: Top=279->194, Left=396)
428:         loc_oPg.AddObject("lbl_4c_Nop", "Label")
429:         WITH loc_oPg.lbl_4c_Nop
430:             .Top       = 194
431:             .Left      = 396
432:             .Width     = 23
433:             .Height    = 15
434:             .Caption   = "OP :"
435:             .FontSize  = 8
436:             .ForeColor = RGB(0, 0, 0)
437:             .BackStyle = 0
438:             .Visible   = .T.
439:         ENDWITH
440: 
441:         *-- "Cliente :" (Say10: Top=305->220, Left=76)
442:         loc_oPg.AddObject("lbl_4c_Cliente", "Label")
443:         WITH loc_oPg.lbl_4c_Cliente
444:             .Top       = 220
445:             .Left      = 76
446:             .Width     = 42
447:             .Height    = 15
448:             .Caption   = "Cliente :"
449:             .FontName  = "Tahoma"
450:             .FontSize  = 8
451:             .ForeColor = RGB(90, 90, 90)
452:             .BackStyle = 0
453:             .AutoSize  = .T.
454:             .Visible   = .T.
455:         ENDWITH
456:     ENDPROC
457: 
458:     *--------------------------------------------------------------------------
459:     * ConfigurarPaginaControles - Adiciona campos de entrada e checkboxes na Page1
460:     * Posicoes: original_Top - 85 (offset do PageFrame)
461:     *--------------------------------------------------------------------------
462:     PROTECTED PROCEDURE ConfigurarPaginaControles()
463:         LOCAL loc_oPg
464:         loc_oPg = THIS.pgf_4c_Paginas.Page1
465: 
466:         *-- Data Inicial (Get_Datai: Top=93->8, Left=123, W=80)
467:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
468:         WITH loc_oPg.txt_4c_DtInicial
469:             .Top           = 8
470:             .Left          = 123
471:             .Width         = 80
472:             .Height        = 23
473:             .Value         = {}
474:             .Format        = "D"
475:             .Alignment     = 3

*-- Linhas 484 a 493:
484:         *-- Data Final (Get_Dataf: Top=93->8, Left=231, W=80)
485:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
486:         WITH loc_oPg.txt_4c_DtFinal
487:             .Top           = 8
488:             .Left          = 231
489:             .Width         = 80
490:             .Height        = 23
491:             .Value         = {}
492:             .Format        = "D"
493:             .Alignment     = 3

*-- Linhas 502 a 511:
502:         *-- Tipo Geracao OP (Get_TpGOp: Top=119->34, Left=123, W=80)
503:         loc_oPg.AddObject("txt_4c_TpGOp", "TextBox")
504:         WITH loc_oPg.txt_4c_TpGOp
505:             .Top           = 34
506:             .Left          = 123
507:             .Width         = 80
508:             .Height        = 23
509:             .Value         = ""
510:             .MaxLength     = 10
511:             .Margin        = 2

*-- Linhas 521 a 530:
521:         *-- DopPs / Movimentacao (Get_Dopes: Top=145->60, Left=123, W=173)
522:         loc_oPg.AddObject("txt_4c_GetDopes", "TextBox")
523:         WITH loc_oPg.txt_4c_GetDopes
524:             .Top           = 60
525:             .Left          = 123
526:             .Width         = 173
527:             .Height        = 23
528:             .Value         = ""
529:             .MaxLength     = 20
530:             .Format        = "K!"

*-- Linhas 540 a 549:
540:         *-- Numero movimentacao (getNumes: Top=145->60, Left=298, W=52)
541:         loc_oPg.AddObject("txt_4c_Numes", "TextBox")
542:         WITH loc_oPg.txt_4c_Numes
543:             .Top           = 60
544:             .Left          = 298
545:             .Width         = 52
546:             .Height        = 23
547:             .Value         = 0
548:             .Format        = "999999"
549:             .Alignment     = 3

*-- Linhas 558 a 567:
558:         *-- Grupo balancete - codigo (Get_grupo: Top=171->86, Left=123, W=80)
559:         loc_oPg.AddObject("txt_4c_GetGrupo", "TextBox")
560:         WITH loc_oPg.txt_4c_GetGrupo
561:             .Top           = 86
562:             .Left          = 123
563:             .Width         = 80
564:             .Height        = 23
565:             .Value         = ""
566:             .FontName      = "Tahoma"
567:             .FontSize      = 8

*-- Linhas 575 a 584:
575:         *-- Grupo balancete - descricao (get_dgrupo: Top=171->86, Left=206, W=279)
576:         loc_oPg.AddObject("txt_4c_GetDGrupo", "TextBox")
577:         WITH loc_oPg.txt_4c_GetDGrupo
578:             .Top           = 86
579:             .Left          = 206
580:             .Width         = 279
581:             .Height        = 23
582:             .Value         = ""
583:             .FontName      = "Tahoma"
584:             .FontSize      = 8

*-- Linhas 592 a 601:
592:         *-- Conta balancete - codigo (Get_conta: Top=197->112, Left=123, W=80)
593:         loc_oPg.AddObject("txt_4c_GetConta", "TextBox")
594:         WITH loc_oPg.txt_4c_GetConta
595:             .Top           = 112
596:             .Left          = 123
597:             .Width         = 80
598:             .Height        = 23
599:             .Value         = ""
600:             .FontName      = "Tahoma"
601:             .FontSize      = 8

*-- Linhas 610 a 619:
610:         *-- Conta balancete - descricao (Get_dconta: Top=197->112, Left=206, W=279)
611:         loc_oPg.AddObject("txt_4c_GetDConta", "TextBox")
612:         WITH loc_oPg.txt_4c_GetDConta
613:             .Top           = 112
614:             .Left          = 206
615:             .Width         = 279
616:             .Height        = 23
617:             .Value         = ""
618:             .FontName      = "Tahoma"
619:             .FontSize      = 8

*-- Linhas 628 a 637:
628:         *-- Grande grupo - codigo (Get_Ggrp: Top=223->138, Left=123, W=31)
629:         loc_oPg.AddObject("txt_4c_GetGgrp", "TextBox")
630:         WITH loc_oPg.txt_4c_GetGgrp
631:             .Top           = 138
632:             .Left          = 123
633:             .Width         = 31
634:             .Height        = 23
635:             .Value         = ""
636:             .MaxLength     = 3
637:             .FontName      = "Tahoma"

*-- Linhas 646 a 655:
646:         *-- Grande grupo - descricao (Get_dGGrp: Top=223->138, Left=157, W=328)
647:         loc_oPg.AddObject("txt_4c_GetDGgrp", "TextBox")
648:         WITH loc_oPg.txt_4c_GetDGgrp
649:             .Top           = 138
650:             .Left          = 157
651:             .Width         = 328
652:             .Height        = 23
653:             .Value         = ""
654:             .FontName      = "Tahoma"
655:             .FontSize      = 8

*-- Linhas 663 a 672:
663:         *-- Grupo mat. prima - codigo (Get_CGru: Top=249->164, Left=123, W=31)
664:         loc_oPg.AddObject("txt_4c_GetCGru", "TextBox")
665:         WITH loc_oPg.txt_4c_GetCGru
666:             .Top           = 164
667:             .Left          = 123
668:             .Width         = 31
669:             .Height        = 23
670:             .Value         = ""
671:             .MaxLength     = 3
672:             .FontName      = "Tahoma"

*-- Linhas 681 a 690:
681:         *-- Grupo mat. prima - descricao (Get_DGru: Top=249->164, Left=157, W=328)
682:         loc_oPg.AddObject("txt_4c_GetDGru", "TextBox")
683:         WITH loc_oPg.txt_4c_GetDGru
684:             .Top           = 164
685:             .Left          = 157
686:             .Width         = 328
687:             .Height        = 23
688:             .Value         = ""
689:             .FontName      = "Tahoma"
690:             .FontSize      = 8

*-- Linhas 698 a 707:
698:         *-- Tipo operacao (Get_TpOps: Top=275->190, Left=123, W=115)
699:         loc_oPg.AddObject("txt_4c_GetTpOps", "TextBox")
700:         WITH loc_oPg.txt_4c_GetTpOps
701:             .Top           = 190
702:             .Left          = 123
703:             .Width         = 115
704:             .Height        = 23
705:             .Value         = ""
706:             .FontName      = "Tahoma"
707:             .FontSize      = 8

*-- Linhas 715 a 724:
715:         *-- Envelope (get_envelope: Top=275->190, Left=308, W=80)
716:         loc_oPg.AddObject("txt_4c_GetEnvelope", "TextBox")
717:         WITH loc_oPg.txt_4c_GetEnvelope
718:             .Top           = 190
719:             .Left          = 308
720:             .Width         = 80
721:             .Height        = 23
722:             .Value         = 0
723:             .InputMask     = "9999999999"
724:             .MaxLength     = 10

*-- Linhas 734 a 743:
734:         *-- Numero OP (get_Nop: Top=275->190, Left=427, W=58)
735:         loc_oPg.AddObject("txt_4c_GetNop", "TextBox")
736:         WITH loc_oPg.txt_4c_GetNop
737:             .Top           = 190
738:             .Left          = 427
739:             .Width         = 58
740:             .Height        = 23
741:             .Value         = 0
742:             .InputMask     = "999999"
743:             .MaxLength     = 6

*-- Linhas 753 a 762:
753:         *-- Cliente producao - codigo (get_codcli: Top=301->216, Left=123, W=80)
754:         loc_oPg.AddObject("txt_4c_GetCodCli", "TextBox")
755:         WITH loc_oPg.txt_4c_GetCodCli
756:             .Top           = 216
757:             .Left          = 123
758:             .Width         = 80
759:             .Height        = 23
760:             .Value         = ""
761:             .FontName      = "Tahoma"
762:             .FontSize      = 8

*-- Linhas 770 a 944:
770:         *-- Cliente producao - descricao (get_desccli: Top=301->216, Left=206, W=279)
771:         loc_oPg.AddObject("txt_4c_GetDescCli", "TextBox")
772:         WITH loc_oPg.txt_4c_GetDescCli
773:             .Top           = 216
774:             .Left          = 206
775:             .Width         = 279
776:             .Height        = 23
777:             .Value         = ""
778:             .FontSize      = 8
779:             .ForeColor     = RGB(0, 0, 0)
780:             .SpecialEffect = 1
781:             .Themes        = .F.
782:             .ToolTipText   = "Nome do Cliente (F4 = busca por nome)"
783:             .Visible       = .T.
784:         ENDWITH
785: 
786:         *-- Checkbox: Imprimir Tipo de Material (ChkTpoOp: Top=331->246, Left=123)
787:         loc_oPg.AddObject("chk_4c_TpoOp", "CheckBox")
788:         WITH loc_oPg.chk_4c_TpoOp
789:             .Top       = 246
790:             .Left      = 123
791:             .Height    = 15
792:             .Width     = 135
793:             .Caption   = "Imprimir Tipo de Material"
794:             .Value     = 0
795:             .FontName  = "Tahoma"
796:             .FontSize  = 8
797:             .AutoSize  = .T.
798:             .Alignment = 0
799:             .BackStyle = 0
800:             .ForeColor = RGB(90, 90, 90)
801:             .Visible   = .T.
802:         ENDWITH
803: 
804:         *-- Checkbox: Imprimir Valor (chkvalor: Top=349->264, Left=123)
805:         loc_oPg.AddObject("chk_4c_Valor", "CheckBox")
806:         WITH loc_oPg.chk_4c_Valor
807:             .Top       = 264
808:             .Left      = 123
809:             .Height    = 15
810:             .Width     = 83
811:             .Caption   = "Imprimir Valor"
812:             .Value     = 0
813:             .FontName  = "Tahoma"
814:             .FontSize  = 8
815:             .AutoSize  = .T.
816:             .Alignment = 0
817:             .BackStyle = 0
818:             .ForeColor = RGB(90, 90, 90)
819:             .Visible   = .T.
820:         ENDWITH
821: 
822:         *-- Checkbox: Imprimir Quantidade e Peso (chkQtdPes: Top=349->264, Left=250)
823:         loc_oPg.AddObject("chk_4c_QtdPes", "CheckBox")
824:         WITH loc_oPg.chk_4c_QtdPes
825:             .Top       = 264
826:             .Left      = 250
827:             .Height    = 15
828:             .Width     = 150
829:             .Caption   = "Imprimir Quantidade e Peso"
830:             .Value     = 0
831:             .FontName  = "Tahoma"
832:             .FontSize  = 8
833:             .AutoSize  = .T.
834:             .Alignment = 0
835:             .BackStyle = 0
836:             .ForeColor = RGB(90, 90, 90)
837:             .Visible   = .T.
838:         ENDWITH
839: 
840:         *-- Checkbox: Analisar pelo Destino (ChkDestino: Top=367->282, Left=123)
841:         loc_oPg.AddObject("chk_4c_Destino", "CheckBox")
842:         WITH loc_oPg.chk_4c_Destino
843:             .Top       = 282
844:             .Left      = 123
845:             .Height    = 15
846:             .Width     = 118
847:             .Caption   = "Analisar pelo Destino"
848:             .Value     = 0
849:             .FontName  = "Tahoma"
850:             .FontSize  = 8
851:             .AutoSize  = .T.
852:             .Alignment = 0
853:             .BackStyle = 0
854:             .ForeColor = RGB(90, 90, 90)
855:             .Visible   = .T.
856:         ENDWITH
857: 
858:         *-- Checkbox: Imprimir Movimentacoes (Chk_Dopes: Top=386->301, Left=123)
859:         loc_oPg.AddObject("chk_4c_Dopes", "CheckBox")
860:         WITH loc_oPg.chk_4c_Dopes
861:             .Top       = 301
862:             .Left      = 123
863:             .Height    = 15
864:             .Width     = 133
865:             .Caption   = "Imprimir Movimenta" + CHR(231) + CHR(245) + "es"
866:             .Value     = 0
867:             .FontName  = "Tahoma"
868:             .FontSize  = 8
869:             .AutoSize  = .T.
870:             .Alignment = 0
871:             .BackStyle = 0
872:             .ForeColor = RGB(90, 90, 90)
873:             .Visible   = .T.
874:         ENDWITH
875: 
876:         *-- Checkbox: Imprimir Movimentacoes Detalhadas (chk_detalhe: Top=405->320, Left=123)
877:         loc_oPg.AddObject("chk_4c_Detalhe", "CheckBox")
878:         WITH loc_oPg.chk_4c_Detalhe
879:             .Top       = 320
880:             .Left      = 123
881:             .Height    = 15
882:             .Width     = 190
883:             .Caption   = "Imprimir Movimenta" + CHR(231) + CHR(245) + "es Detalhadas"
884:             .Value     = 0
885:             .FontName  = "Tahoma"
886:             .FontSize  = 8
887:             .AutoSize  = .T.
888:             .Alignment = 0
889:             .BackStyle = 0
890:             .ForeColor = RGB(90, 90, 90)
891:             .Visible   = .T.
892:         ENDWITH
893: 
894:         *-- Checkbox: Imprimir Produtos (chkProdutos: Top=426->341, Left=141)
895:         loc_oPg.AddObject("chk_4c_Produtos", "CheckBox")
896:         WITH loc_oPg.chk_4c_Produtos
897:             .Top       = 341
898:             .Left      = 141
899:             .Height    = 15
900:             .Width     = 102
901:             .Caption   = "Imprimir Produtos"
902:             .Value     = 0
903:             .Enabled   = .F.
904:             .FontName  = "Tahoma"
905:             .FontSize  = 8
906:             .AutoSize  = .T.
907:             .Alignment = 0
908:             .BackStyle = 0
909:             .ForeColor = RGB(90, 90, 90)
910:             .Visible   = .T.
911:         ENDWITH
912: 
913:         *-- Checkbox: Imprimir Funcionario/Assinatura (chkFuncs: Top=444->359, Left=141)
914:         loc_oPg.AddObject("chk_4c_Funcs", "CheckBox")
915:         WITH loc_oPg.chk_4c_Funcs
916:             .Top       = 359
917:             .Left      = 141
918:             .Height    = 15
919:             .Width     = 175
920:             .Caption   = "Imprimir Funcion" + CHR(225) + "rio / Assinatura"
921:             .Value     = 0
922:             .Enabled   = .F.
923:             .FontName  = "Tahoma"
924:             .FontSize  = 8
925:             .AutoSize  = .T.
926:             .Alignment = 0
927:             .BackStyle = 0
928:             .ForeColor = RGB(90, 90, 90)
929:             .Visible   = .T.
930:         ENDWITH
931: 
932:         *-- Checkbox: Modelo Relatorio de Producao (chkRelatorio: Top=463->378, Left=159)
933:         loc_oPg.AddObject("chk_4c_Relatorio", "CheckBox")
934:         WITH loc_oPg.chk_4c_Relatorio
935:             .Top       = 378
936:             .Left      = 159
937:             .Height    = 15
938:             .Width     = 161
939:             .Caption   = "Modelo Relat" + CHR(243) + "rio de Produ" + CHR(231) + CHR(227) + "o"
940:             .Value     = 0
941:             .Enabled   = .F.
942:             .FontName  = "Tahoma"
943:             .FontSize  = 8
944:             .AutoSize  = .T.

*-- Linhas 951 a 997:
951: 
952:     *--------------------------------------------------------------------------
953:     * ConfigurarContainerOperacoes - Container com grid de operacoes e botoes
954:     * Original: cntOpe.Top=89->4, Left=492, Width=330, Height=270
955:     * Grid: 2 colunas (Marca=checkbox, Dopps=readonly text)
956:     *--------------------------------------------------------------------------
957:     PROTECTED PROCEDURE ConfigurarContainerOperacoes()
958:         LOCAL loc_oPg, loc_oCnt, loc_oGrd
959:         loc_oPg = THIS.pgf_4c_Paginas.Page1
960: 
961:         loc_oPg.AddObject("cnt_4c_Ope", "Container")
962:         loc_oCnt = loc_oPg.cnt_4c_Ope
963: 
964:         WITH loc_oCnt
965:             .Top         = 4
966:             .Left        = 492
967:             .Width       = 330
968:             .Height      = 270
969:             .BackStyle   = 0
970:             .BorderWidth = 0
971:             .Visible     = .T.
972: 
973:             .AddObject("lbl_4c_LabelOpe", "Label")
974:             WITH .lbl_4c_LabelOpe
975:                 .Top       = 1
976:                 .Left      = 5
977:                 .Width     = 91
978:                 .Height    = 16
979:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
980:                 .FontName  = "Tahoma"
981:                 .FontBold  = .T.
982:                 .BackStyle = 0
983:                 .ForeColor = RGB(90, 90, 90)
984:                 .Visible   = .T.
985:             ENDWITH
986: 
987:             .AddObject("grd_4c_Dados", "Grid")
988:             loc_oGrd = .grd_4c_Dados
989: 
990:             WITH loc_oGrd
991:                 .Top          = 17
992:                 .Left         = 5
993:                 .Width        = 257
994:                 .Height       = 247
995:                 .ColumnCount  = 2
996:                 .AllowRowSizing = .F.
997:                 .DeleteMark   = .F.

*-- Linhas 1011 a 1042:
1011:                     .Alignment = 0
1012:                     .Enabled   = .T.
1013:                     .Sparse    = .F.
1014:                     .AddObject("chk_4c_Marca", "CheckBox")
1015:                     WITH .chk_4c_Marca
1016:                         .Caption   = ""
1017:                         .Alignment = 0
1018:                         .Enabled   = .T.
1019:                         .FontName  = "Tahoma"
1020:                     ENDWITH
1021:                     .CurrentControl = "chk_4c_Marca"
1022:                     .ControlSource  = "CsSigCdOpd.Marca"
1023:                     WITH .Header1
1024:                         .Caption   = ""
1025:                         .FontName  = "Tahoma"
1026:                         .ForeColor = RGB(90, 90, 90)
1027:                     ENDWITH
1028:                 ENDWITH
1029: 
1030:                 WITH .Column2
1031:                     .Width         = 220
1032:                     .ControlSource = "CsSigCdOpd.Dopps"
1033:                     .Enabled       = .T.
1034:                     .ReadOnly      = .T.
1035:                     .Sparse        = .F.
1036:                     WITH .Header1
1037:                         .Caption   = "Descrs"
1038:                         .FontName  = "Tahoma"
1039:                         .ForeColor = RGB(90, 90, 90)
1040:                     ENDWITH
1041:                     WITH .Text1
1042:                         .Enabled     = .T.

*-- Linhas 1050 a 1082:
1050:                 .RecordSource = "CsSigCdOpd"
1051:             ENDWITH
1052: 
1053:             .AddObject("cmd_4c_SelecionarTudo", "CommandButton")
1054:             WITH .cmd_4c_SelecionarTudo
1055:                 .Top          = 110
1056:                 .Left         = 264
1057:                 .Width        = 40
1058:                 .Height       = 40
1059:                 .Caption      = ""
1060:                 .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1061:                 .ToolTipText  = "Marca todos"
1062:                 .BackColor    = RGB(255, 255, 255)
1063:                 .ForeColor    = RGB(36, 84, 155)
1064:                 .FontName     = "Verdana"
1065:                 .FontSize     = 8
1066:                 .TabStop      = .F.
1067:                 .Themes       = .F.
1068:                 .Visible      = .T.
1069:             ENDWITH
1070: 
1071:             .AddObject("cmd_4c_LimparSelecao", "CommandButton")
1072:             WITH .cmd_4c_LimparSelecao
1073:                 .Top          = 150
1074:                 .Left         = 264
1075:                 .Width        = 40
1076:                 .Height       = 40
1077:                 .Caption      = ""
1078:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1079:                 .ToolTipText  = "Desmarca todos"
1080:                 .BackColor    = RGB(255, 255, 255)
1081:                 .ForeColor    = RGB(36, 84, 155)
1082:                 .FontName     = "Verdana"

*-- Linhas 1136 a 1145:
1136:         BINDEVENT(loc_oPg.chk_4c_QtdPes,   "InteractiveChange", THIS, "ChkQtdPesInteractiveChange")
1137:         BINDEVENT(loc_oPg.chk_4c_Funcs,    "InteractiveChange", THIS, "ChkFuncsInteractiveChange")
1138: 
1139:         BINDEVENT(loc_oCnt.cmd_4c_SelecionarTudo, "Click", THIS, "BtnSelecionarTudoClick")
1140:         BINDEVENT(loc_oCnt.cmd_4c_LimparSelecao,  "Click", THIS, "BtnLimparSelecaoClick")
1141: 
1142:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
1143:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
1144:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
1145:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

*-- Linhas 2276 a 2284:
2276:     ENDPROC
2277: 
2278:     *==========================================================================
2279:     * HANDLERS DE CHECKBOX INTERACTIVECHANGE
2280:     *==========================================================================
2281: 
2282:     *-- ChkTpoOp: desmarca valor e qtdpes (mutuamente exclusivos)
2283:     PROCEDURE ChkTpoOpInteractiveChange()
2284:         LOCAL loc_oPg

*-- Linhas 2430 a 2452:
2430:         LOCAL loc_oPg
2431:         loc_oPg = THIS.pgf_4c_Paginas.Page1
2432:         WITH THIS.this_oRelatorio
2433:             loc_oPg.txt_4c_DtInicial.Value   = .this_dDtInicial
2434:             loc_oPg.txt_4c_DtFinal.Value     = .this_dDtFinal
2435:             loc_oPg.txt_4c_GetDopes.Value    = ALLTRIM(.this_cDopp)
2436:             loc_oPg.txt_4c_Numes.Value       = .this_nNumes
2437:             loc_oPg.txt_4c_GetGrupo.Value    = ALLTRIM(.this_cGrupoGcr)
2438:             loc_oPg.txt_4c_GetDGrupo.Value   = ALLTRIM(.this_cDGrupoGcr)
2439:             loc_oPg.txt_4c_GetConta.Value    = ALLTRIM(.this_cCodConta)
2440:             loc_oPg.txt_4c_GetDConta.Value   = ALLTRIM(.this_cNomeConta)
2441:             loc_oPg.txt_4c_GetGgrp.Value     = ALLTRIM(.this_cGgrp)
2442:             loc_oPg.txt_4c_GetDGgrp.Value    = ALLTRIM(.this_cDGgrp)
2443:             loc_oPg.txt_4c_GetCGru.Value     = ALLTRIM(.this_cCGru)
2444:             loc_oPg.txt_4c_GetDGru.Value     = ALLTRIM(.this_cDGru)
2445:             loc_oPg.txt_4c_GetTpOps.Value    = ALLTRIM(.this_cTpOps)
2446:             loc_oPg.txt_4c_GetEnvelope.Value = .this_nEnvelope
2447:             loc_oPg.txt_4c_GetNop.Value      = .this_nNop
2448:             loc_oPg.txt_4c_GetCodCli.Value   = ALLTRIM(.this_cCodCli)
2449:             loc_oPg.txt_4c_GetDescCli.Value  = ALLTRIM(.this_cDescCli)
2450:             loc_oPg.txt_4c_TpGOp.Value       = ALLTRIM(.this_cTpGOp)
2451:             loc_oPg.chk_4c_TpoOp.Value       = IIF(.this_lImprimeTpMat, 1, 0)
2452:             loc_oPg.chk_4c_Destino.Value     = IIF(.this_lAnalisarDestino, 1, 0)

*-- Linhas 2516 a 2524:
2516:     *--------------------------------------------------------------------------
2517:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2518:         *-- Form REPORT nao tem Page2 de Dados no padrao CRUD.
2519:         *-- Todos os campos de filtro (Labels + TextBoxes + CheckBoxes) foram
2520:         *-- adicionados em ConfigurarPaginaLabels() e ConfigurarPaginaControles()
2521:         *-- diretamente na pgf_4c_Paginas.Page1 (pagina unica de filtros).
2522:         *-- O container de operacoes com grid CsSigCdOpd foi criado em
2523:         *-- ConfigurarContainerOperacoes().
2524:         RETURN

*-- Linhas 2566 a 2575:
2566:         loc_oPg.chk_4c_Destino.Enabled      = loc_lHab
2567:         loc_oPg.chk_4c_Dopes.Enabled        = loc_lHab
2568:         loc_oPg.chk_4c_Detalhe.Enabled      = loc_lHab
2569:         loc_oPg.cnt_4c_Ope.cmd_4c_SelecionarTudo.Enabled = loc_lHab
2570:         loc_oPg.cnt_4c_Ope.cmd_4c_LimparSelecao.Enabled  = loc_lHab
2571: 
2572:         *-- Campos condicionais respeitam regras originais (When)
2573:         IF loc_lHab
2574:             THIS.AtualizarEstadoConta()
2575:             THIS.AtualizarEstadoCodCli()


### BO (C:\4c\projeto\app\classes\SigReDpDBO.prg):
*==============================================================================
* SIGREDPDBO.PRG
* BO para relatorio de analise de producao por dopps (SigReDpD)
*
* Herda de RelatorioBase
* Carrega cursores de referencia para lookups e processamento do relatorio
*==============================================================================

DEFINE CLASS SigReDpDBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Filtro movimentacao / DopPs
    this_cDopp            = ""
    this_nNumes           = 0

    *-- Filtro grupo balancete (SigCdGcr.Codigos / Descrs)
    this_cGrupoGcr        = ""
    this_cDGrupoGcr       = ""

    *-- Filtro conta balancete (SigCdCli.IClis / RClis)
    this_cCodConta        = ""
    this_cNomeConta       = ""

    *-- Filtro cliente producao (SigCdCli.IClis / RClis) - get_codcli/get_desccli
    this_cCodCli          = ""
    this_cDescCli         = ""

    *-- Filtro grupo materia prima (SigCdGrp.CGrus / DGrus)
    this_cCGru            = ""
    this_cDGru            = ""

    *-- Filtro grande grupo (SigCdGpr.Codigos / Descs)
    this_cGgrp            = ""
    this_cDGgrp           = ""

    *-- Filtro tipo operacao (SigOpOpt.Cods)
    this_cTpOps           = ""

    *-- Filtro envelope e numero de OP
    this_nEnvelope        = 0
    this_nNop             = 0

    *-- Filtro tipo geracao OP (SigInTgo.Codigos) - auto-preenchido se apenas 1 opcao
    this_cTpGOp           = ""

    *-- Flags de impressao (correspondem aos checkboxes do form)
    this_lImprimeTpMat    = .F.
    this_lAnalisarDestino = .F.
    this_lImprimeDopes    = .F.
    this_lDetalhar        = .F.
    this_lImprimeValor    = .F.
    this_lImprimeProdutos = .F.
    this_lImprimeFuncs    = .F.
    this_lRelatorio       = .F.
    this_lImprimeQtdPes   = .F.

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de referencia para lookups e processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                *-- Grupos de balancete (lookup Get_grupo / get_dgrupo)
                IF USED("CrSigCdGcr")
                    USE IN CrSigCdGcr
                ENDIF
                loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGcr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar grupos de balancete"
                    EXIT
                ENDIF
                SELECT CrSigCdGcr
                INDEX ON Codigos TAG BalCodigo
                INDEX ON Descrs  TAG BalDescrs

                *-- Tipos de operacao (lookup Get_TpOps)
                IF USED("CrSigOpOpt")
                    USE IN CrSigOpOpt
                ENDIF
                loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt " + ;
                           "WHERE Situas < 2 AND (Emps = ' ' OR Emps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpOpt")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar tipos de opera" + ;
                        CHR(231) + CHR(227) + "o"
                    EXIT
                ENDIF
                SELECT CrSigOpOpt
                INDEX ON Cods  TAG Cods
                INDEX ON Descs TAG Descs

                *-- Clientes de balancete (lookup Get_conta / Get_dconta / get_codcli)
                IF USED("CrSigCdCli")
                    USE IN CrSigCdCli
                ENDIF
                loc_cSQL = "SELECT IClis, RClis, Inativas FROM SigCdCli WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdCli")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar clientes"
                    EXIT
                ENDIF
                SELECT CrSigCdCli
                INDEX ON IClis TAG BalCodigo
                INDEX ON RClis TAG BalNome

                *-- Parametros SigCdPam (GrTrans filtra grupo transito no processamento)
                IF USED("CrSigCdPam")
                    USE IN CrSigCdPam
                ENDIF
                loc_cSQL = "SELECT GrTrans FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdPam")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros"
                    EXIT
                ENDIF
                SELECT CrSigCdPam
                GO TOP

                *-- Tipos de geracao OP com filtro de acesso do usuario (SigInTgo)
                IF USED("cursor_4c_TmpTpGop")
                    USE IN cursor_4c_TmpTpGop
                ENDIF
                loc_cSQL = "SELECT 0 AS Acesso, Codigos, Descs FROM SigInTgo"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTpGop")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar tipos de gera" + ;
                        CHR(231) + CHR(227) + "o OP"
                    EXIT
                ENDIF
                THIS.FiltrarAcessosTpGop()

                *-- Operacoes de producao com filtro de acesso (SigCdOpd)
                *-- INDEX criado ANTES do filtro (replicando ordem do legado)
                IF USED("CsSigCdOpd")
                    USE IN CsSigCdOpd
                ENDIF
                loc_cSQL = "SELECT 0 AS Marca, DopPs, ndopps, CodTgOps FROM SigCdOpd"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsSigCdOpd")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es"
                    EXIT
                ENDIF
                SELECT CsSigCdOpd
                INDEX ON Dopps TAG Dopps
                THIS.FiltrarAcessosOperacoes()
                SELECT CsSigCdOpd
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Init")
        ENDTRY

        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarAcessosTpGop - Filtra tipos de geracao OP por acesso do usuario
    * Replica: fChecaAcesso('SIGPRGLOT', Codigos) do legado
    * Se apenas 1 tipo com acesso, pre-preenche this_cTpGOp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FiltrarAcessosTpGop()
        LOCAL loc_oErro

        TRY
            SELECT cursor_4c_TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(cursor_4c_TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN cursor_4c_TmpTpGop
                ENDIF
            ENDSCAN

            IF USED("CrTmpTpGop")
                USE IN CrTmpTpGop
            ENDIF
            SELECT * FROM cursor_4c_TmpTpGop WHERE Acesso = 1 ;
                INTO CURSOR CrTmpTpGop READWRITE
            SELECT CrTmpTpGop
            INDEX ON Codigos TAG Codigos
            GO TOP

            IF RECCOUNT("CrTmpTpGop") = 1
                SELECT CrTmpTpGop
                GO TOP
                THIS.this_cTpGOp = ALLTRIM(CrTmpTpGop.Codigos)
            ENDIF

            IF USED("cursor_4c_TmpTpGop")
                USE IN cursor_4c_TmpTpGop
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.FiltrarAcessosTpGop")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarAcessosOperacoes - Remove operacoes sem acesso do usuario
    * Replica: fChecaAcesso('P'+padl(ndopps,8,'0')) do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FiltrarAcessosOperacoes()
        LOCAL loc_oErro

        TRY
            SELECT CsSigCdOpd
            SCAN
                IF !fChecaAcesso("P" + PADL(CsSigCdOpd.ndopps, 8, "0"))
                    DELETE
                ENDIF
            ENDSCAN
            SELECT CsSigCdOpd
            GO TOP

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.FiltrarAcessosOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia carregados no Init
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CrSigCdGcr")
            USE IN CrSigCdGcr
        ENDIF
        IF USED("CrSigOpOpt")
            USE IN CrSigOpOpt
        ENDIF
        IF USED("CrSigCdCli")
            USE IN CrSigCdCli
        ENDIF
        IF USED("CrSigCdPam")
            USE IN CrSigCdPam
        ENDIF
        IF USED("CrTmpTpGop")
            USE IN CrTmpTpGop
        ENDIF
        IF USED("CsSigCdOpd")
            USE IN CsSigCdOpd
        ENDIF
        IF USED("cursor_4c_TmpTpGop")
            USE IN cursor_4c_TmpTpGop
        ENDIF
        THIS.LimparCursoresTemp()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao dos filtros para auditoria
    *
    * Relatorio nao possui chave primaria de registro. Esta funcao monta
    * uma "chave" concatenando os principais filtros aplicados, usada
    * pelo log de auditoria para identificar qual configuracao foi executada.
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = "DT=" + DTOC(THIS.this_dDtInicial) + "-" + DTOC(THIS.this_dDtFinal)
        ENDIF
        IF !EMPTY(THIS.this_cGrupoGcr)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "GRP=" + ALLTRIM(THIS.this_cGrupoGcr)
        ENDIF
        IF !EMPTY(THIS.this_cCodConta)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "CTA=" + ALLTRIM(THIS.this_cCodConta)
        ENDIF
        IF !EMPTY(THIS.this_cDopp)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "DOPP=" + ALLTRIM(THIS.this_cDopp)
        ENDIF
        IF !EMPTY(THIS.this_cTpGOp)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "TGOP=" + ALLTRIM(THIS.this_cTpGOp)
        ENDIF
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de um cursor
    *
    * Permite recuperar configuracao de filtros previamente persistida
    * (ex: historico de execucoes). Mapeia colunas do cursor para as
    * propriedades this_* deste BO, validando tipos antes de atribuir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                                      "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            IF !EOF() AND !BOF()
                IF TYPE("DtInicial") = "D"
                    THIS.this_dDtInicial = NVL(EVALUATE("DtInicial"), {})
                ENDIF
                IF TYPE("DtFinal") = "D"
                    THIS.this_dDtFinal = NVL(EVALUATE("DtFinal"), {})
                ENDIF
                IF TYPE("Dopp") = "C"
                    THIS.this_cDopp = ALLTRIM(NVL(EVALUATE("Dopp"), ""))
                ENDIF
                IF TYPE("Numes") = "N"
                    THIS.this_nNumes = NVL(EVALUATE("Numes"), 0)
                ENDIF
                IF TYPE("GrupoGcr") = "C"
                    THIS.this_cGrupoGcr = ALLTRIM(NVL(EVALUATE("GrupoGcr"), ""))
                ENDIF
                IF TYPE("CodConta") = "C"
                    THIS.this_cCodConta = ALLTRIM(NVL(EVALUATE("CodConta"), ""))
                ENDIF
                IF TYPE("CodCli") = "C"
                    THIS.this_cCodCli = ALLTRIM(NVL(EVALUATE("CodCli"), ""))
                ENDIF
                IF TYPE("CGru") = "C"
                    THIS.this_cCGru = ALLTRIM(NVL(EVALUATE("CGru"), ""))
                ENDIF
                IF TYPE("Ggrp") = "C"
                    THIS.this_cGgrp = ALLTRIM(NVL(EVALUATE("Ggrp"), ""))
                ENDIF
                IF TYPE("TpOps") = "C"
                    THIS.this_cTpOps = ALLTRIM(NVL(EVALUATE("TpOps"), ""))
                ENDIF
                IF TYPE("Envelope") = "N"
                    THIS.this_nEnvelope = NVL(EVALUATE("Envelope"), 0)
                ENDIF
                IF TYPE("Nop") = "N"
                    THIS.this_nNop = NVL(EVALUATE("Nop"), 0)
                ENDIF
                IF TYPE("TpGOp") = "C"
                    THIS.this_cTpGOp = ALLTRIM(NVL(EVALUATE("TpGOp"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReDpDBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de inser" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "SigReDpDBO.Inserir")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de atualiza" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "SigReDpDBO.Atualizar")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *
    * Grava evento de impressao/visualizacao do relatorio para rastreabilidade
    * de quem executou o relatorio de Analise de Producao por DopPs e com
    * quais filtros (datas, grupos, contas, dopp, tipo geracao OP).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF EMPTY(loc_cUsuario)
                loc_cUsuario = "SISTEMA"
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChaveRegistro, DadosNovos) " + ;
                       "VALUES (" + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                       EscaparSQL("SigReDpD") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL("Relat" + CHR(243) + "rio An" + CHR(225) + ;
                                  "lise Produ" + CHR(231) + CHR(227) + "o por DopPs") + ;
                       ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReDpDBO.RegistrarAuditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNomeFRX - Retorna nome do FRX conforme opcoes selecionadas
    * Replica logica de selecao dos 8 relatorios (SigReDp1 a SigReDp8)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterNomeFRX()
        LOCAL loc_cFRX
        IF THIS.this_lDetalhar
            IF THIS.this_lImprimeValor
                IF THIS.this_lRelatorio
                    loc_cFRX = "SigReDp7"
                ELSE
                    loc_cFRX = "SigReDp6"
                ENDIF
            ELSE
                IF THIS.this_lImprimeProdutos
                    loc_cFRX = "SigReDp5"
                ELSE
                    loc_cFRX = "SigReDp1"
                ENDIF
            ENDIF
        ELSE
            IF THIS.this_lImprimeDopes
                loc_cFRX = "SigReDp2"
            ELSE
                IF THIS.this_lImprimeValor
                    loc_cFRX = "SigReDp4"
                ELSE
                    IF THIS.this_lImprimeQtdPes
                        loc_cFRX = "SigReDp8"
                    ELSE
                        loc_cFRX = "SigReDp3"
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        RETURN loc_cFRX
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursoresTemp - Fecha cursores temporarios criados em PrepararDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursoresTemp()
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("TmpNens")
            USE IN TmpNens
        ENDIF
        IF USED("CrSigCdNec")
            USE IN CrSigCdNec
        ENDIF
        IF USED("csLocalMc")
            USE IN csLocalMc
        ENDIF
        IF USED("crEnvelope")
            USE IN crEnvelope
        ENDIF
        IF USED("LocalCli")
            USE IN LocalCli
        ENDIF
        IF USED("LocalPro")
            USE IN LocalPro
        ENDIF
        IF USED("CrTmpCli")
            USE IN CrTmpCli
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        IF USED("CrSigCdPro")
            USE IN CrSigCdPro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa movimentacoes e monta TmpRelat para relatorio
    * Replica: PROCEDURE processamento do legado (SIGREDPD)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cGrupo, loc_cConta, loc_cGruMat, loc_cGgrp
        LOCAL loc_dDatai, loc_dDataf, loc_cDataFimSQL
        LOCAL loc_cDopp, loc_nNumes
        LOCAL loc_lImprimeTpMat, loc_lDestino
        LOCAL loc_cTpOpt, loc_lDope, loc_lDopeDt
        LOCAL loc_nEnvelope, loc_nOp, loc_nOpI, loc_nOpF
        LOCAL loc_cCodCli, loc_cTGOp
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cCab, loc_cSub, loc_cEmp
        LOCAL loc_cTpOps, loc_cGrp, loc_cCta, loc_cPed, loc_nEnv
        LOCAL loc_cPro, loc_cDpr
        LOCAL loc_lAbortarScan

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                THIS.this_cMensagemErro = ""
                THIS.LimparCursoresTemp()

                *-- Capturar valores dos filtros das propriedades
                loc_cGrupo        = ALLTRIM(THIS.this_cGrupoGcr)
                loc_cConta        = ALLTRIM(THIS.this_cCodConta)
                loc_cGruMat       = ALLTRIM(THIS.this_cCGru)
                loc_cGgrp         = ALLTRIM(THIS.this_cGgrp)
                loc_dDatai        = THIS.this_dDtInicial
                loc_dDataf        = THIS.this_dDtFinal
                loc_cDopp         = ALLTRIM(THIS.this_cDopp)
                loc_nNumes        = THIS.this_nNumes
                loc_lImprimeTpMat = THIS.this_lImprimeTpMat
                loc_lDestino      = THIS.this_lAnalisarDestino
                loc_cTpOpt        = ALLTRIM(THIS.this_cTpOps)
                loc_lDope         = THIS.this_lImprimeDopes
                loc_lDopeDt       = THIS.this_lDetalhar
                loc_nEnvelope     = THIS.this_nEnvelope
                loc_nOp           = THIS.this_nNop
                loc_nOpI          = (loc_nOp * 10000) + 1
                loc_nOpF          = (loc_nOp * 10000) + 9999
                loc_cCodCli       = ALLTRIM(THIS.this_cCodCli)
                loc_cTGOp         = ALLTRIM(THIS.this_cTpGOp)

                *-- Data final com 23:59:59 para cobrir todo o dia (replica fDtoSQL do legado)
                loc_cDataFimSQL = "'" + ;
                    PADL(YEAR(loc_dDataf),  4, "0") + "-" + ;
                    PADL(MONTH(loc_dDataf), 2, "0") + "-" + ;
                    PADL(DAY(loc_dDataf),   2, "0") + " 23:59:59'"

                *-- Criar cursor de resultado do processamento
                CREATE CURSOR TmpRelat (;
                    Fase c(10), IClis c(10), RClis c(50), CMats c(14), ;
                    DPros c(40), CPros c(14), DDPros c(40), Qtde n(12,3), ;
                    TpOps c(15), CUnis c(3), Operacaos c(31), Nenvs n(10), ;
                    Datas D, Pesos n(12,3), Valor n(12,2), Fators n(12,3), ;
                    Peso2s n(12,3), CUniPs c(3))
                INDEX ON DTOS(Datas) + Operacaos + STR(Nenvs,10) + CMats ;
                    TAG Operacao
                INDEX ON Fase + IClis + TpOps + CUnis + CUniPs + CMats + ;
                    Operacaos + STR(Nenvs,10) TAG FFuncMat

                *-- SQL principal: SigCdNec (cabecalho) x SigCdNei (itens)
                loc_cSQL = ;
                    "SELECT a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs," + ;
                    "a.GrupoOs,a.ContaOs,b.CMats,b.Qtds,b.TpOps,b.Nenvs," + ;
                    "a.GrupoDs,a.ContaDs,b.Nops,b.Pesos,b.peso2s,b.Fators," + ;
                    "b.Servicos,b.Cats,b.Empdnps " + ;
                    "FROM SigCdNec a, SigCdNei b " + ;
                    "WHERE a.Datas BETWEEN " + FormatarDataSQL(loc_dDatai) + ;
                    " AND " + loc_cDataFimSQL + " AND "

                IF !EMPTY(loc_cGrupo)
                    IF loc_lDestino
                        loc_cSQL = loc_cSQL + "a.GrupoDs = " + EscaparSQL(loc_cGrupo) + " AND "
                    ELSE
                        loc_cSQL = loc_cSQL + "a.GrupoOs = " + EscaparSQL(loc_cGrupo) + " AND "
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cConta)
                    IF loc_lDestino
                        loc_cSQL = loc_cSQL + "a.ContaDs = " + EscaparSQL(loc_cConta) + " AND "
                    ELSE
                        loc_cSQL = loc_cSQL + "a.ContaOs = " + EscaparSQL(loc_cConta) + " AND "
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cDopp)
                    loc_cSQL = loc_cSQL + "a.Dopps = " + EscaparSQL(loc_cDopp) + " AND "
                ENDIF

                IF loc_nNumes > 0
                    loc_cSQL = loc_cSQL + "a.NumPs = " + FormatarNumeroSQL(loc_nNumes) + " AND "
                ENDIF

                loc_cSQL = loc_cSQL + "a.EmpDNPs = b.EmpDNPs ORDER BY a.cIdChaves"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpNens")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = ;
                        "Falha ao consultar movimenta" + CHR(231) + CHR(245) + "es"
                    EXIT
                ENDIF

                *-- Filtrar operacoes marcadas no grid + tipo geracao OP
                SELECT * FROM CsSigCdOpd ;
                    WHERE Marca > 0 ;
                    AND IIF(!EMPTY(loc_cTGOp), CodTgOps = loc_cTGOp, .T.) ;
                    INTO CURSOR csLocalMc READWRITE
                GO TOP IN csLocalMc

                *-- Cruzar movimentacoes com operacoes selecionadas
                IF EMPTY(loc_cDopp) AND !EOF("csLocalMc")
                    SELECT a.* FROM TmpNens a, CsSigCdOpd b ;
                        WHERE a.DopPs = b.DopPs AND b.Marca > 0 ;
                        INTO CURSOR CrSigCdNec READWRITE
                ELSE
                    SELECT a.* FROM TmpNens a, CsSigCdOpd b ;
                        WHERE a.DopPs = b.DopPs ;
                        AND IIF(!EMPTY(loc_cTGOp), b.CodTgOps = loc_cTGOp, .T.) ;
                        INTO CURSOR CrSigCdNec READWRITE
                ENDIF

                *-- Filtro por envelope especifico
                IF loc_nEnvelope > 0
                    SELECT DISTINCT Empdnps FROM CrSigCdNec ;
                        WHERE Nenvs = loc_nEnvelope ;
                        INTO CURSOR crEnvelope READWRITE
                ENDIF

                SELECT CrSigCdNec
                INDEX ON DTOS(Datas) + CIdChaves TAG Datas
                SET ORDER TO Datas
                GO TOP IN CrSigCdNec

                *-- Processar cada registro de movimentacao
                loc_lAbortarScan = .F.
                IF RECCOUNT("CrSigCdNec") > 0
                    SELECT CrSigCdNec
                    SCAN
                        *-- Filtro tipo material/operacao
                        IF !EMPTY(loc_cTpOpt) AND ;
                                ALLTRIM(CrSigCdNec.TpOps) <> ALLTRIM(loc_cTpOpt)
                            LOOP
                        ENDIF

                        *-- Filtro por envelope
                        IF loc_nEnvelope > 0
                            SELECT crEnvelope
                            LOCATE FOR ALLTRIM(Empdnps) = ALLTRIM(CrSigCdNec.Empdnps)
                            IF EOF("crEnvelope")
                                SELECT CrSigCdNec
                                LOOP
                            ENDIF
                            SELECT CrSigCdNec
                        ENDIF

                        *-- Filtro por numero de OP
                        IF loc_nOp > 0 AND ;
                                !BETWEEN(CrSigCdNec.Nops, loc_nOpI, loc_nOpF)
                            LOOP
                        ENDIF

                        *-- Filtro por cliente especifico
                        IF !EMPTY(loc_cCodCli)
                            LOCAL loc_cQLCli
                            IF !EMPTY(CrSigCdNec.Nops) AND CrSigCdNec.Nops <> 0
                                loc_cQLCli = ;
                                    "SELECT CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Iclis ELSE e.Iclis END AS Iclis," + ;
                                    "CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Rclis ELSE e.Rclis END AS Rclis " + ;
                                    "FROM sigoppic a " + ;
                                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                                    "INNER JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
                                    "INNER JOIN SigCdCli d ON b.ContaOs = d.Iclis " + ;
                                    "INNER JOIN SigCdCli e ON b.ContaDs = e.Iclis " + ;
                                    "WHERE a.Nops = " + ;
                                    FormatarNumeroSQL(CrSigCdNec.Nops) + ;
                                    " AND (b.ContaOs = " + EscaparSQL(loc_cCodCli) + ;
                                    " OR b.ContaDs = " + EscaparSQL(loc_cCodCli) + ")"
                            ELSE
                                loc_cQLCli = ;
                                    "SELECT CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Iclis ELSE e.Iclis END AS Iclis," + ;
                                    "CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Rclis ELSE e.Rclis END AS Rclis " + ;
                                    "FROM SigPdMvf f " + ;
                                    "INNER JOIN sigoppic a ON f.Nops = a.Nops " + ;
                                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                                    "INNER JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
                                    "INNER JOIN SigCdCli d ON b.ContaOs = d.Iclis " + ;
                                    "INNER JOIN SigCdCli e ON b.ContaDs = e.Iclis " + ;
                                    "WHERE f.EmpDnPs = " + ;
                                    EscaparSQL(ALLTRIM(CrSigCdNec.EmpDnPs)) + ;
                                    " AND (b.ContaOs = " + EscaparSQL(loc_cCodCli) + ;
                                    " OR b.ContaDs = " + EscaparSQL(loc_cCodCli) + ")"
                            ENDIF
                            IF USED("LocalCli")
                                USE IN LocalCli
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQLCli, "LocalCli") < 1
                                THIS.this_cMensagemErro = "Erro ao verificar cliente"
                                loc_lAbortarScan = .T.
                                EXIT
                            ENDIF
                            IF EOF("LocalCli")
                                SELECT CrSigCdNec
                                LOOP
                            ENDIF
                            SELECT CrSigCdNec
                        ENDIF

                        *-- Ignorar servicos sem OP vinculada
                        IF CrSigCdNec.Servicos AND ;
                                !EMPTY(CrSigCdNec.Nenvs) AND ;
                                EMPTY(ALLTRIM(CrSigCdNec.Cats))
                            LOOP
                        ENDIF

                        *-- Buscar descricao e grupo do material
                        LOCAL loc_cQLPro
                        loc_cQLPro = ;
                            "SELECT a.CPros,a.DPros,a.CGrus,a.CUnis,a.CUniPs,b.Mercs " + ;
                            "FROM SigCdPro a, SigCdGrp b " + ;
                            "WHERE a.CPros = " + ;
                            EscaparSQL(ALLTRIM(CrSigCdNec.CMats)) + ;
                            " AND a.Cgrus = b.Cgrus"
                        IF USED("CrSigCdPro")
                            USE IN CrSigCdPro
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cQLPro, "CrSigCdPro") < 1
                            THIS.this_cMensagemErro = "Erro ao buscar produto"
                            loc_lAbortarScan = .T.
                            EXIT
                        ENDIF
                        SELECT CrSigCdPro

                        *-- Filtro grupo materia prima
                        IF !EMPTY(loc_cGruMat) AND ;
                                ALLTRIM(CrSigCdPro.CGrus) <> ALLTRIM(loc_cGruMat)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Filtro grande grupo
                        IF !EMPTY(loc_cGgrp) AND ;
                                ALLTRIM(CrSigCdPro.Mercs) <> ALLTRIM(loc_cGgrp)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Montar variaveis de agrupamento
                        loc_cTpOps = IIF(loc_lImprimeTpMat, ;
                            CrSigCdNec.TpOps, SPACE(15))
                        loc_cGrp = IIF(loc_lDestino, ;
                            CrSigCdNec.GrupoDs, CrSigCdNec.GrupoOs)
                        loc_cCta = IIF(loc_lDestino, ;
                            CrSigCdNec.Contads, CrSigCdNec.ContaOs)
                        loc_cPed = PADR(IIF(loc_lDope, ;
                            ALLTRIM(CrSigCdNec.Dopps) + "-" + ;
                            ALLTRIM(STR(CrSigCdNec.Numps,10)), " "), 31)
                        loc_nEnv = IIF(loc_lDope, CrSigCdNec.Nenvs, 0)

                        *-- Filtrar grupo de transito (configurado em SigCdPam)
                        IF USED("CrSigCdPam") AND ;
                                ALLTRIM(loc_cGrp) = ALLTRIM(CrSigCdPam.GrTrans)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Buscar produto da OP (apenas quando necessario)
                        loc_cPro = ""
                        loc_cDpr = ""
                        IF !EMPTY(CrSigCdNec.Nops) AND ;
                                CrSigCdNec.Nops <> 0 AND ;
                                THIS.this_lImprimeProdutos
                            LOCAL loc_cQLOpPro
                            loc_cQLOpPro = ;
                                "SELECT TOP 1 a.Cpros, b.DPros " + ;
                                "FROM SigOpPic a " + ;
                                "INNER JOIN SigCdPro b ON a.Cpros = b.Cpros " + ;
                                "WHERE Nops = " + ;
                                FormatarNumeroSQL(CrSigCdNec.Nops)
                            IF USED("LocalPro")
                                USE IN LocalPro
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQLOpPro, "LocalPro") > 0
                                GO TOP IN LocalPro
                                IF !EOF("LocalPro")
                                    loc_cDpr = ALLTRIM(LocalPro.DPros)
                                    loc_cPro = ALLTRIM(LocalPro.Cpros)
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Inserir/acumular em TmpRelat
                        SELECT TmpRelat
                        IF loc_lDopeDt
                            *-- Modo detalhado: agrupa por DopPs + data
                            LOCAL loc_cPedDt, loc_nEnvDt
                            loc_cPedDt = ALLTRIM(CrSigCdNec.Dopps) + "-" + ;
                                ALLTRIM(STR(CrSigCdNec.Numps,10))
                            loc_nEnvDt = CrSigCdNec.Nops
                            SET ORDER TO Operacao
                            IF !SEEK(DTOS(CrSigCdNec.Datas) + ;
                                    PADR(loc_cPedDt,31) + ;
                                    STR(loc_nEnvDt,10) + ;
                                    PADR(ALLTRIM(CrSigCdNec.CMats),14))
                                INSERT INTO TmpRelat ;
                                    (Datas, Operacaos, Nenvs, CMats, Dpros, ;
                                    Cunis, CPros, DDPros, Fators) ;
                                    VALUES (CrSigCdNec.Datas, loc_cPedDt, ;
                                    loc_nEnvDt, ALLTRIM(CrSigCdNec.CMats), ;
                                    ALLTRIM(CrSigCdPro.Dpros), ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    loc_cPro, loc_cDpr, CrSigCdNec.Fators)
                            ENDIF
                            REPLACE Qtde  WITH Qtde  + CrSigCdNec.Qtds, ;
                                    Pesos WITH Pesos + CrSigCdNec.Pesos
                            REPLACE Valor WITH Valor + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)
                        ELSE
                            *-- Modo resumido: agrupa por grupo/conta/material
                            SET ORDER TO FFuncMat
                            IF !SEEK(loc_cGrp + loc_cCta + loc_cTpOps + ;
                                    CrSigCdPro.Cunis + CrSigCdPro.CuniPs + ;
                                    CrSigCdNec.CMats + loc_cPed + ;
                                    STR(loc_nEnv,10))
                                *-- Buscar nome da conta para exibicao
                                LOCAL loc_cRClis, loc_cQLCli2
                                loc_cRClis = ""
                                loc_cQLCli2 = ;
                                    "SELECT IClis, RClis FROM SigCdCli " + ;
                                    "WHERE IClis = " + ;
                                    EscaparSQL(ALLTRIM(loc_cCta))
                                IF USED("CrTmpCli")
                                    USE IN CrTmpCli
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cQLCli2, "CrTmpCli") > 0
                                    SELECT CrTmpCli
                                    IF !EOF("CrTmpCli")
                                        loc_cRClis = ALLTRIM(CrTmpCli.RClis)
                                    ENDIF
                                ENDIF
                                SELECT TmpRelat
                                INSERT INTO TmpRelat ;
                                    (Fase, Iclis, RClis, CMats, Dpros, CPros, ;
                                    DDPros, TpOps, Cunis, Operacaos, Nenvs, ;
                                    Datas, Fators, CuniPs) ;
                                    VALUES (loc_cGrp, loc_cCta, loc_cRClis, ;
                                    ALLTRIM(CrSigCdNec.CMats), ;
                                    ALLTRIM(CrSigCdPro.Dpros), ;
                                    loc_cPro, loc_cDpr, loc_cTpOps, ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    loc_cPed, loc_nEnv, CrSigCdNec.Datas, ;
                                    CrSigCdNec.Fators, ;
                                    ALLTRIM(CrSigCdPro.CuniPs))
                            ENDIF
                            REPLACE Qtde   WITH Qtde   + CrSigCdNec.Qtds, ;
                                    Peso2s WITH Peso2s + CrSigCdNec.Peso2s
                            REPLACE Valor  WITH Valor  + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)

                            *-- Linha de total geral por material
                            SET ORDER TO FFuncMat
                            IF !SEEK(REPLICATE(CHR(255),20) + loc_cTpOps + ;
                                    CrSigCdPro.Cunis + CrSigCdPro.CuniPs + ;
                                    CrSigCdNec.CMats)
                                INSERT INTO TmpRelat ;
                                    (Fase, Iclis, RClis, CMats, TpOps, ;
                                    Cunis, CuniPs) ;
                                    VALUES (REPLICATE(CHR(255),10), ;
                                    REPLICATE(CHR(255),10), ;
                                    "Total Geral : ", ;
                                    ALLTRIM(CrSigCdNec.CMats), ;
                                    loc_cTpOps, ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    ALLTRIM(CrSigCdPro.CuniPs))
                            ENDIF
                            REPLACE Qtde   WITH Qtde   + CrSigCdNec.Qtds, ;
                                    Peso2s WITH Peso2s + CrSigCdNec.Peso2s
                            REPLACE Valor  WITH Valor  + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)
                        ENDIF

                        SELECT CrSigCdNec
                    ENDSCAN
                ENDIF

                IF loc_lAbortarScan
                    EXIT
                ENDIF

                *-- Montar cabecalho do relatorio
                loc_cCab = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"
                loc_cSub = IIF(THIS.this_lRelatorio, "", ;
                    IIF(loc_lDestino, "Por Destino", "Por Origem") + " - ") + ;
                    "Per" + CHR(237) + "odo : " + ;
                    ALLTRIM(DTOC(loc_dDatai)) + ;
                    " at" + CHR(233) + " " + ALLTRIM(DTOC(loc_dDataf))

                IF USED("CrSigCdEmp")
                    USE IN CrSigCdEmp
                ENDIF
                LOCAL loc_cQLEmp
                loc_cQLEmp = "SELECT Cemps, Razas FROM SigCdEmp"
                SQLEXEC(gnConnHandle, loc_cQLEmp, "CrSigCdEmp")
                loc_cEmp = go_4c_Sistema.cCodEmpresa + " - "
                IF USED("CrSigCdEmp")
                    SELECT CrSigCdEmp
                    LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                    IF !EOF("CrSigCdEmp")
                        loc_cEmp = loc_cEmp + ALLTRIM(CrSigCdEmp.Razas)
                    ENDIF
                ENDIF

                IF THIS.this_lImprimeFuncs AND !EMPTY(loc_cConta)
                    LOCAL loc_cQLFuncs
                    loc_cQLFuncs = ;
                        "SELECT a.RClis, a.Cpfs FROM SigCdCli a " + ;
                        "WHERE a.IClis = " + EscaparSQL(PADR(loc_cConta,10))
                    IF USED("LocalCli")
                        USE IN LocalCli
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cQLFuncs, "LocalCli") < 1
                        THIS.this_cMensagemErro = ;
                            "Erro ao buscar funcion" + CHR(225) + "rio"
                        EXIT
                    ENDIF
                    SELECT LocalCli
                    GO TOP IN LocalCli
                    IF !EOF("LocalCli")
                        loc_cSub = loc_cSub + CHR(13) + CHR(13) + ;
                            "NOME: " + ALLTRIM(LocalCli.RClis) + ;
                            " / CPF: " + ALLTRIM(LocalCli.Cpfs)
                    ENDIF
                ENDIF

                CREATE CURSOR dbCabecalho ;
                    (Titulo c(100), SubTitulo c(200), NomeEmpresa c(100), ImpFuncs L)
                INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa, ImpFuncs) ;
                    VALUES (loc_cCab, loc_cSub, loc_cEmp, THIS.this_lImprimeFuncs)

                SELECT TmpRelat
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em tela (preview)
    * Replica: PROCEDURE visualizacao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                loc_cFRX = THIS.ObterNomeFRX()

                IF loc_cFRX = "SigReDp7"
                    SET POINT TO ","
                    SET SEPARATOR TO "."
                    REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) PREVIEW NOCONSOLE
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) PREVIEW NOCONSOLE
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    * par_lComDialogo: .T. = abre dialogo de impressora, .F. = imprime direto
    * Replica: PROCEDURE impressao (prompt) e documento (direto) do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir(par_lComDialogo)
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX, loc_lDialogo

        loc_lSucesso = .F.
        loc_lDialogo = IIF(PCOUNT() >= 1, par_lComDialogo, .F.)

        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                loc_cFRX = THIS.ObterNomeFRX()

                IF loc_cFRX = "SigReDp7"
                    SET POINT TO ","
                    SET SEPARATOR TO "."
                    IF loc_lDialogo
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT NOCONSOLE
                    ENDIF
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                ELSE
                    IF loc_lDialogo
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT NOCONSOLE
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

