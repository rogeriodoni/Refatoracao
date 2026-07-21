# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 275: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 297: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2064 linhas total):

*-- Linhas 69 a 90:
69:                 THIS.ConfigurarContainerOpCompra()
70:                 THIS.TornarControlesVisiveis()
71:                 THIS.ConfigurarBINDEVENTs()
72: 
73:                 *-- Propagar titulo para labels do cabecalho
74:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
75:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
76: 
77:                 *-- Estado inicial do contador de registros
78:                 THIS.txt_4c_Registro.Value = 0
79: 
80:                 loc_lSucesso = .T.
81:             ENDIF
82:         CATCH TO loc_oErro
83:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
84:                     " PROC=" + loc_oErro.Procedure, "Erro FormSigPrCcc.InicializarForm")
85:         ENDTRY
86: 
87:         RETURN loc_lSucesso
88:     ENDPROC
89: 
90:     *==========================================================================

*-- Linhas 97 a 536:
97: 
98:     *==========================================================================
99:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
100:     *==========================================================================
101:     PROTECTED PROCEDURE ConfigurarCabecalho
102:         THIS.AddObject("cnt_4c_Sombra", "Container")
103:         WITH THIS.cnt_4c_Sombra
104:             .Visible    = .T.
105:             .Top        = 0
106:             .Left       = 0
107:             .Width      = THIS.Width
108:             .Height     = 80
109:             .BorderWidth= 0
110:             .BackColor  = RGB(100,100,100)
111:             .AddObject("lbl_4c_LblSombra", "Label")
112:             WITH .lbl_4c_LblSombra
113:                 .FontBold      = .T.
114:                 .FontName      = "Tahoma"
115:                 .FontSize      = 18
116:                 .FontUnderline = .F.
117:                 .WordWrap      = .T.
118:                 .Alignment     = 0
119:                 .AutoSize      = .F.
120:                 .BackStyle     = 0
121:                 .Caption       = THIS.Caption
122:                 .Height        = 40
123:                 .Left          = 10
124:                 .Top           = 18
125:                 .Width         = THIS.Width
126:                 .ForeColor     = RGB(0,0,0)
127:             ENDWITH
128:             .AddObject("lbl_4c_LblTitulo", "Label")
129:             WITH .lbl_4c_LblTitulo
130:                 .FontBold   = .T.
131:                 .FontName   = "Tahoma"
132:                 .FontSize   = 18
133:                 .WordWrap   = .T.
134:                 .Alignment  = 0
135:                 .AutoSize   = .F.
136:                 .BackStyle  = 0
137:                 .Caption    = THIS.Caption
138:                 .Height     = 46
139:                 .Left       = 10
140:                 .Top        = 17
141:                 .Width      = THIS.Width
142:                 .ForeColor  = RGB(255,255,255)
143:             ENDWITH
144:         ENDWITH
145:     ENDPROC
146: 
147:     *==========================================================================
148:     * ConfigurarControlesPrincipais - Shape, CheckBoxes, Botoes, LblEnd, Registro
149:     *==========================================================================
150:     PROTECTED PROCEDURE ConfigurarControlesPrincipais
151:         *-- Shape decorativo (Shape1 original)
152:         THIS.AddObject("shp_4c_Shape1", "Shape")
153:         WITH THIS.shp_4c_Shape1
154:             .Top         = 7
155:             .Left        = 697
156:             .Height      = 110
157:             .Width       = 90
158:             .BackStyle   = 0
159:             .BorderStyle = 0
160:             .BorderColor = RGB(136,189,188)
161:         ENDWITH
162: 
163:         *-- CheckBox C.C. (Conta original - Left=350)
164:         THIS.AddObject("chk_4c_Conta", "CheckBox")
165:         WITH THIS.chk_4c_Conta
166:             .Top           = 3
167:             .Left          = 350
168:             .Height        = 75
169:             .Width         = 75
170:             .FontBold      = .T.
171:             .FontItalic    = .T.
172:             .FontName      = "Tahoma"
173:             .FontSize      = 8
174:             .AutoSize      = .F.
175:             .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
176:             .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
177:             .Alignment     = 1
178:             .BackStyle     = 0
179:             .Caption       = "C.C."
180:             .Value         = 0
181:             .SpecialEffect = 0
182:             .Style         = 1
183:             .ToolTipText   = "Conta Corrente"
184:             .ForeColor     = RGB(90,90,90)
185:             .BackColor     = RGB(255,255,255)
186:             .Themes        = .F.
187:         ENDWITH
188: 
189:         *-- CheckBox Estoque (Estoque original - Left=425)
190:         THIS.AddObject("chk_4c_Estoque", "CheckBox")
191:         WITH THIS.chk_4c_Estoque
192:             .Top           = 3
193:             .Left          = 425
194:             .Height        = 75
195:             .Width         = 75
196:             .FontBold      = .T.
197:             .FontItalic    = .T.
198:             .FontName      = "Tahoma"
199:             .FontSize      = 8
200:             .AutoSize      = .F.
201:             .Picture       = gc_4c_CaminhoIcones + "folder22.ico"
202:             .DownPicture   = gc_4c_CaminhoIcones + "a_diamd1.bmp"
203:             .Alignment     = 1
204:             .BackStyle     = 0
205:             .Caption       = "Estoque"
206:             .Value         = 0
207:             .SpecialEffect = 0
208:             .Style         = 1
209:             .ForeColor     = RGB(90,90,90)
210:             .BackColor     = RGB(255,255,255)
211:             .Themes        = .F.
212:         ENDWITH
213: 
214:         *-- CheckBox Custo (btnCusto original - Left=500)
215:         THIS.AddObject("chk_4c_BtnCusto", "CheckBox")
216:         WITH THIS.chk_4c_BtnCusto
217:             .Top           = 3
218:             .Left          = 500
219:             .Height        = 75
220:             .Width         = 75
221:             .FontBold      = .T.
222:             .FontItalic    = .T.
223:             .FontName      = "Tahoma"
224:             .FontSize      = 8
225:             .AutoSize      = .F.
226:             .Picture       = gc_4c_CaminhoIcones + "folder34.ico"
227:             .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
228:             .Alignment     = 1
229:             .BackStyle     = 0
230:             .Caption       = "Custo"
231:             .Value         = 0
232:             .SpecialEffect = 0
233:             .Style         = 1
234:             .ForeColor     = RGB(90,90,90)
235:             .BackColor     = RGB(255,255,255)
236:             .Themes        = .F.
237:         ENDWITH
238: 
239:         *-- CheckBox Ultima Compra (btnCompra original - Left=575)
240:         THIS.AddObject("chk_4c_BtnCompra", "CheckBox")
241:         WITH THIS.chk_4c_BtnCompra
242:             .Top           = 3
243:             .Left          = 575
244:             .Height        = 75
245:             .Width         = 75
246:             .FontBold      = .T.
247:             .FontItalic    = .T.
248:             .FontName      = "Tahoma"
249:             .FontSize      = 8
250:             .AutoSize      = .F.
251:             .Picture       = gc_4c_CaminhoIcones + "folder27.ico"
252:             .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
253:             .Alignment     = 1
254:             .BackStyle     = 0
255:             .Caption       = CHR(218) + "lt. Compra"
256:             .Value         = 0
257:             .SpecialEffect = 0
258:             .Style         = 1
259:             .ToolTipText   = CHR(218) + "ltima Compra"
260:             .ForeColor     = RGB(90,90,90)
261:             .BackColor     = RGB(255,255,255)
262:             .Themes        = .F.
263:         ENDWITH
264: 
265:         *-- Botao Processar (Processa original - Left=650)
266:         *-- Themes=.T. + DisabledPicture obrigatorio para standalone com Picture e Enabled=.F.
267:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
268:         WITH THIS.cmd_4c_Processa
269:             .Top            = 3
270:             .Left           = 650
271:             .Height         = 75
272:             .Width          = 75
273:             .FontBold       = .T.
274:             .FontItalic     = .T.
275:             .FontName       = "Comic Sans MS"
276:             .FontSize       = 8
277:             .Picture        = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
278:             .DisabledPicture= gc_4c_CaminhoIcones + "geral_processar_60.jpg"
279:             .Caption        = "Processar"
280:             .Enabled        = .F.
281:             .SpecialEffect  = 0
282:             .ForeColor      = RGB(90,90,90)
283:             .BackColor      = RGB(255,255,255)
284:             .Themes         = .T.
285:             .ToolTipText    = "Processar"
286:         ENDWITH
287: 
288:         *-- Botao Encerrar/Cancela (Cancela original - Left=725, Cancel=.T.)
289:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
290:         WITH THIS.cmd_4c_Cancela
291:             .Top            = 3
292:             .Left           = 725
293:             .Height         = 75
294:             .Width          = 75
295:             .FontBold       = .T.
296:             .FontItalic     = .T.
297:             .FontName       = "Comic Sans MS"
298:             .FontSize       = 8
299:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
300:             .DisabledPicture= gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
301:             .Cancel         = .T.
302:             .Caption        = "Encerrar"
303:             .SpecialEffect  = 0
304:             .ForeColor      = RGB(90,90,90)
305:             .BackColor      = RGB(255,255,255)
306:             .Themes         = .T.
307:             .ToolTipText    = "[ESC] Sair"
308:         ENDWITH
309: 
310:         *-- Label "Processamento Concluido" (LblEnd - inicialmente invisivel)
311:         THIS.AddObject("lbl_4c_LblEnd", "Label")
312:         WITH THIS.lbl_4c_LblEnd
313:             .AutoSize   = .T.
314:             .FontBold   = .T.
315:             .FontItalic = .F.
316:             .FontName   = "Arial"
317:             .FontSize   = 12
318:             .WordWrap   = .F.
319:             .Alignment  = 2
320:             .BackStyle  = 0
321:             .Caption    = "Processamento Conclu" + CHR(237) + "do"
322:             .Height     = 22
323:             .Left       = 361
324:             .Top        = 545
325:             .Width      = 205
326:             .ForeColor  = RGB(255,0,0)
327:             .Visible    = .F.
328:         ENDWITH
329: 
330:         *-- Label "Registros :" (Label1 original)
331:         THIS.AddObject("lbl_4c_LblRegistros", "Label")
332:         WITH THIS.lbl_4c_LblRegistros
333:             .AutoSize   = .T.
334:             .FontBold   = .T.
335:             .FontItalic = .F.
336:             .FontName   = "Tahoma"
337:             .FontSize   = 8
338:             .WordWrap   = .F.
339:             .BackStyle  = 0
340:             .Caption    = "Registros : "
341:             .Height     = 15
342:             .Left       = 171
343:             .Top        = 547
344:             .Width      = 65
345:             .ForeColor  = RGB(90,90,90)
346:         ENDWITH
347: 
348:         *-- TextBox contador de registros (Get_Registro original)
349:         THIS.AddObject("txt_4c_Registro", "TextBox")
350:         WITH THIS.txt_4c_Registro
351:             .FontName      = "Tahoma"
352:             .FontSize      = 8
353:             .Height        = 23
354:             .InputMask     = "999,999,999"
355:             .Left          = 238
356:             .SpecialEffect = 1
357:             .Top           = 543
358:             .Width         = 93
359:             .ReadOnly      = .T.
360:             .Value         = 0
361:         ENDWITH
362:     ENDPROC
363: 
364:     *==========================================================================
365:     * ConfigurarContainerOpConta - Conta Corrente: empresa, grupo, conta, moeda, data
366:     *==========================================================================
367:     PROTECTED PROCEDURE ConfigurarContainerOpConta
368:         THIS.AddObject("cnt_4c_OpConta", "Container")
369:         WITH THIS.cnt_4c_OpConta
370:             .Top           = 114
371:             .Left          = 139
372:             .Width         = THIS.LarguraOpConta
373:             .Height        = 81
374:             .BackStyle     = 0
375:             .BorderWidth   = 2
376:             .SpecialEffect = 2
377:             .Visible       = .F.
378:             .BackColor     = RGB(192,192,255)
379:             .BorderColor   = RGB(90,90,90)
380: 
381:             .AddObject("lbl_4c_TituloOp", "Label")
382:             WITH .lbl_4c_TituloOp
383:                 .AutoSize      = .T.
384:                 .FontBold      = .T.
385:                 .FontName      = "Tahoma"
386:                 .FontSize      = 8
387:                 .FontUnderline = .T.
388:                 .BackStyle     = 0
389:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
390:                 .Left          = 171
391:                 .Top           = 2
392:                 .ForeColor     = RGB(90,90,90)
393:             ENDWITH
394: 
395:             .AddObject("lbl_4c_LblEmpresa", "Label")
396:             WITH .lbl_4c_LblEmpresa
397:                 .AutoSize   = .T.
398:                 .FontBold   = .T.
399:                 .FontName   = "Tahoma"
400:                 .FontSize   = 8
401:                 .BackStyle  = 0
402:                 .Caption    = "Empresa :"
403:                 .Height     = 15
404:                 .Left       = 16
405:                 .Top        = 23
406:                 .Width      = 57
407:                 .ForeColor  = RGB(90,90,90)
408:             ENDWITH
409:             .AddObject("txt_4c_Empresa", "TextBox")
410:             WITH .txt_4c_Empresa
411:                 .FontName      = "Tahoma"
412:                 .FontSize      = 8
413:                 .Alignment     = 3
414:                 .Height        = 23
415:                 .Left          = 75
416:                 .MaxLength     = 3
417:                 .SpecialEffect = 1
418:                 .Top           = 20
419:                 .Width         = 31
420:                 .ForeColor     = RGB(0,0,0)
421:                 .Value         = go_4c_Sistema.cCodEmpresa
422:             ENDWITH
423: 
424:             .AddObject("lbl_4c_LblGrupos", "Label")
425:             WITH .lbl_4c_LblGrupos
426:                 .AutoSize   = .T.
427:                 .FontBold   = .T.
428:                 .FontName   = "Tahoma"
429:                 .FontSize   = 8
430:                 .BackStyle  = 0
431:                 .Caption    = "Grupo :"
432:                 .Height     = 15
433:                 .Left       = 122
434:                 .Top        = 24
435:                 .Width      = 42
436:                 .ForeColor  = RGB(90,90,90)
437:             ENDWITH
438:             .AddObject("txt_4c_TxtGrupos", "TextBox")
439:             WITH .txt_4c_TxtGrupos
440:                 .FontName      = "Tahoma"
441:                 .FontSize      = 8
442:                 .Format        = "K"
443:                 .Height        = 23
444:                 .Left          = 166
445:                 .MaxLength     = 10
446:                 .SpecialEffect = 1
447:                 .Top           = 20
448:                 .Width         = 80
449:                 .ForeColor     = RGB(0,0,0)
450:             ENDWITH
451: 
452:             .AddObject("lbl_4c_LblContas", "Label")
453:             WITH .lbl_4c_LblContas
454:                 .AutoSize   = .T.
455:                 .FontBold   = .T.
456:                 .FontName   = "Tahoma"
457:                 .FontSize   = 8
458:                 .BackStyle  = 0
459:                 .Caption    = "Conta :"
460:                 .Height     = 15
461:                 .Left       = 255
462:                 .Top        = 24
463:                 .Width      = 41
464:                 .ForeColor  = RGB(90,90,90)
465:             ENDWITH
466:             .AddObject("txt_4c_TxtContas", "TextBox")
467:             WITH .txt_4c_TxtContas
468:                 .FontName      = "Tahoma"
469:                 .FontSize      = 8
470:                 .Format        = "K"
471:                 .Height        = 23
472:                 .Left          = 298
473:                 .MaxLength     = 10
474:                 .SpecialEffect = 1
475:                 .Top           = 20
476:                 .Width         = 80
477:                 .ForeColor     = RGB(0,0,0)
478:             ENDWITH
479: 
480:             .AddObject("lbl_4c_LblMoedas", "Label")
481:             WITH .lbl_4c_LblMoedas
482:                 .AutoSize   = .T.
483:                 .FontBold   = .T.
484:                 .FontName   = "Tahoma"
485:                 .FontSize   = 8
486:                 .BackStyle  = 0
487:                 .Caption    = "Moeda :"
488:                 .Height     = 15
489:                 .Left       = 27
490:                 .Top        = 50
491:                 .Width      = 46
492:                 .ForeColor  = RGB(90,90,90)
493:             ENDWITH
494:             .AddObject("txt_4c_TxtMoedas", "TextBox")
495:             WITH .txt_4c_TxtMoedas
496:                 .FontName      = "Tahoma"
497:                 .FontSize      = 8
498:                 .Format        = "K"
499:                 .Height        = 23
500:                 .Left          = 75
501:                 .MaxLength     = 3
502:                 .SpecialEffect = 1
503:                 .Top           = 46
504:                 .Width         = 31
505:                 .ForeColor     = RGB(0,0,0)
506:             ENDWITH
507: 
508:             .AddObject("lbl_4c_LblData", "Label")
509:             WITH .lbl_4c_LblData
510:                 .AutoSize   = .T.
511:                 .FontBold   = .T.
512:                 .FontName   = "Tahoma"
513:                 .FontSize   = 8
514:                 .BackStyle  = 0
515:                 .Caption    = "A partir de :"
516:                 .Height     = 15
517:                 .Left       = 121
518:                 .Top        = 50
519:                 .Width      = 68
520:                 .ForeColor  = RGB(90,90,90)
521:             ENDWITH
522:             .AddObject("txt_4c_TxtData", "TextBox")
523:             WITH .txt_4c_TxtData
524:                 .FontName      = "Tahoma"
525:                 .FontSize      = 8
526:                 .Alignment     = 3
527:                 .Format        = "D"
528:                 .Height        = 23
529:                 .Left          = 191
530:                 .SpecialEffect = 1
531:                 .Top           = 46
532:                 .Width         = 80
533:                 .ForeColor     = RGB(0,0,0)
534:                 .Value         = {}
535:             ENDWITH
536:         ENDWITH

*-- Linhas 542 a 723:
542:     PROTECTED PROCEDURE ConfigurarContainerOpEstoque
543:         THIS.AddObject("cnt_4c_OpEstoque", "Container")
544:         WITH THIS.cnt_4c_OpEstoque
545:             .Top           = 200
546:             .Left          = 139
547:             .Width         = THIS.LarguraOpEstoque
548:             .Height        = 143
549:             .BackStyle     = 0
550:             .BorderWidth   = 2
551:             .SpecialEffect = 2
552:             .Visible       = .F.
553:             .BackColor     = RGB(192,192,255)
554:             .BorderColor   = RGB(90,90,90)
555: 
556:             .AddObject("lbl_4c_TituloOp", "Label")
557:             WITH .lbl_4c_TituloOp
558:                 .AutoSize      = .T.
559:                 .FontBold      = .T.
560:                 .FontName      = "Tahoma"
561:                 .FontSize      = 8
562:                 .FontUnderline = .T.
563:                 .BackStyle     = 0
564:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Estoque"
565:                 .Left          = 182
566:                 .Top           = 2
567:                 .ForeColor     = RGB(90,90,90)
568:             ENDWITH
569: 
570:             .AddObject("lbl_4c_LblEmpresa", "Label")
571:             WITH .lbl_4c_LblEmpresa
572:                 .AutoSize   = .T.
573:                 .FontBold   = .T.
574:                 .FontName   = "Tahoma"
575:                 .FontSize   = 8
576:                 .BackStyle  = 0
577:                 .Caption    = "Empresa :"
578:                 .Height     = 15
579:                 .Left       = 31
580:                 .Top        = 15
581:                 .Width      = 57
582:                 .ForeColor  = RGB(90,90,90)
583:             ENDWITH
584:             .AddObject("txt_4c_Empresa", "TextBox")
585:             WITH .txt_4c_Empresa
586:                 .FontName      = "Tahoma"
587:                 .FontSize      = 8
588:                 .Alignment     = 3
589:                 .Height        = 23
590:                 .Left          = 90
591:                 .MaxLength     = 3
592:                 .SpecialEffect = 1
593:                 .Top           = 12
594:                 .Width         = 31
595:                 .ForeColor     = RGB(0,0,0)
596:                 .Value         = go_4c_Sistema.cCodEmpresa
597:             ENDWITH
598: 
599:             .AddObject("lbl_4c_LblGrupos", "Label")
600:             WITH .lbl_4c_LblGrupos
601:                 .AutoSize   = .T.
602:                 .FontBold   = .T.
603:                 .FontName   = "Tahoma"
604:                 .FontSize   = 8
605:                 .BackStyle  = 0
606:                 .Caption    = "Grupo :"
607:                 .Left       = 46
608:                 .Top        = 40
609:                 .Width      = 42
610:                 .ForeColor  = RGB(90,90,90)
611:             ENDWITH
612:             .AddObject("txt_4c_TxtGrupos", "TextBox")
613:             WITH .txt_4c_TxtGrupos
614:                 .FontName      = "Tahoma"
615:                 .FontSize      = 8
616:                 .Format        = "K"
617:                 .Height        = 23
618:                 .Left          = 90
619:                 .MaxLength     = 10
620:                 .SpecialEffect = 1
621:                 .Top           = 37
622:                 .Width         = 80
623:                 .ForeColor     = RGB(0,0,0)
624:             ENDWITH
625: 
626:             .AddObject("lbl_4c_LblEstoque", "Label")
627:             WITH .lbl_4c_LblEstoque
628:                 .AutoSize   = .T.
629:                 .FontBold   = .T.
630:                 .FontName   = "Tahoma"
631:                 .FontSize   = 8
632:                 .BackStyle  = 0
633:                 .Caption    = "Estoque :"
634:                 .Height     = 15
635:                 .Left       = 35
636:                 .Top        = 65
637:                 .Width      = 53
638:                 .ForeColor  = RGB(90,90,90)
639:             ENDWITH
640:             .AddObject("txt_4c_Estoque", "TextBox")
641:             WITH .txt_4c_Estoque
642:                 .FontName      = "Tahoma"
643:                 .FontSize      = 8
644:                 .Alignment     = 3
645:                 .Height        = 23
646:                 .Left          = 90
647:                 .MaxLength     = 10
648:                 .SpecialEffect = 1
649:                 .Top           = 62
650:                 .Width         = 80
651:                 .ForeColor     = RGB(0,0,0)
652:             ENDWITH
653: 
654:             .AddObject("lbl_4c_LblProduto", "Label")
655:             WITH .lbl_4c_LblProduto
656:                 .AutoSize   = .T.
657:                 .FontBold   = .T.
658:                 .FontName   = "Tahoma"
659:                 .FontSize   = 8
660:                 .BackStyle  = 0
661:                 .Caption    = "Produto :"
662:                 .Left       = 35
663:                 .Top        = 90
664:                 .Width      = 53
665:                 .ForeColor  = RGB(90,90,90)
666:             ENDWITH
667:             .AddObject("txt_4c_Produto", "TextBox")
668:             WITH .txt_4c_Produto
669:                 .FontName      = "Tahoma"
670:                 .FontSize      = 8
671:                 .Alignment     = 3
672:                 .Height        = 23
673:                 .Left          = 90
674:                 .MaxLength     = 14
675:                 .SpecialEffect = 1
676:                 .Top           = 87
677:                 .Width         = 108
678:                 .ForeColor     = RGB(0,0,0)
679:             ENDWITH
680:             .AddObject("txt_4c_Descricao", "TextBox")
681:             WITH .txt_4c_Descricao
682:                 .FontName      = "Tahoma"
683:                 .FontSize      = 8
684:                 .Alignment     = 3
685:                 .Height        = 23
686:                 .Left          = 199
687:                 .MaxLength     = 40
688:                 .SpecialEffect = 1
689:                 .Top           = 87
690:                 .Width         = 327
691:                 .ForeColor     = RGB(0,0,0)
692:                 .ReadOnly      = .T.
693:             ENDWITH
694: 
695:             .AddObject("lbl_4c_LblData", "Label")
696:             WITH .lbl_4c_LblData
697:                 .AutoSize   = .T.
698:                 .FontBold   = .T.
699:                 .FontName   = "Tahoma"
700:                 .FontSize   = 8
701:                 .BackStyle  = 0
702:                 .Caption    = "A partir de :"
703:                 .Height     = 15
704:                 .Left       = 20
705:                 .Top        = 115
706:                 .Width      = 68
707:                 .ForeColor  = RGB(90,90,90)
708:             ENDWITH
709:             .AddObject("txt_4c_TxtData", "TextBox")
710:             WITH .txt_4c_TxtData
711:                 .FontName      = "Tahoma"
712:                 .FontSize      = 8
713:                 .Alignment     = 3
714:                 .Format        = "D"
715:                 .Height        = 23
716:                 .Left          = 90
717:                 .SpecialEffect = 1
718:                 .Top           = 112
719:                 .Width         = 80
720:                 .ForeColor     = RGB(0,0,0)
721:                 .Value         = {}
722:             ENDWITH
723:         ENDWITH

*-- Linhas 729 a 855:
729:     PROTECTED PROCEDURE ConfigurarContainerOpCusto
730:         THIS.AddObject("cnt_4c_OpCusto", "Container")
731:         WITH THIS.cnt_4c_OpCusto
732:             .Top           = 349
733:             .Left          = 139
734:             .Width         = THIS.LarguraOpCusto
735:             .Height        = 92
736:             .BackStyle     = 0
737:             .BorderWidth   = 2
738:             .SpecialEffect = 2
739:             .Visible       = .F.
740:             .BackColor     = RGB(192,192,255)
741:             .BorderColor   = RGB(90,90,90)
742: 
743:             .AddObject("lbl_4c_TituloOp", "Label")
744:             WITH .lbl_4c_TituloOp
745:                 .AutoSize      = .T.
746:                 .FontBold      = .T.
747:                 .FontName      = "Tahoma"
748:                 .FontSize      = 8
749:                 .FontUnderline = .T.
750:                 .BackStyle     = 0
751:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
752:                 .Left          = 155
753:                 .Top           = 2
754:                 .ForeColor     = RGB(90,90,90)
755:             ENDWITH
756: 
757:             .AddObject("lbl_4c_LblEmpresa", "Label")
758:             WITH .lbl_4c_LblEmpresa
759:                 .AutoSize   = .T.
760:                 .FontBold   = .T.
761:                 .FontName   = "Tahoma"
762:                 .FontSize   = 8
763:                 .BackStyle  = 0
764:                 .Caption    = "Empresa :"
765:                 .Height     = 15
766:                 .Left       = 31
767:                 .Top        = 14
768:                 .Width      = 57
769:                 .ForeColor  = RGB(90,90,90)
770:             ENDWITH
771:             .AddObject("txt_4c_Empresa", "TextBox")
772:             WITH .txt_4c_Empresa
773:                 .FontName      = "Tahoma"
774:                 .FontSize      = 8
775:                 .Alignment     = 3
776:                 .Height        = 23
777:                 .Left          = 90
778:                 .MaxLength     = 3
779:                 .SpecialEffect = 1
780:                 .Top           = 11
781:                 .Width         = 31
782:                 .ForeColor     = RGB(0,0,0)
783:                 .Value         = go_4c_Sistema.cCodEmpresa
784:             ENDWITH
785: 
786:             .AddObject("lbl_4c_LblProduto", "Label")
787:             WITH .lbl_4c_LblProduto
788:                 .AutoSize   = .T.
789:                 .FontBold   = .T.
790:                 .FontName   = "Tahoma"
791:                 .FontSize   = 8
792:                 .BackStyle  = 0
793:                 .Caption    = "Produto :"
794:                 .Left       = 35
795:                 .Top        = 39
796:                 .Width      = 53
797:                 .ForeColor  = RGB(90,90,90)
798:             ENDWITH
799:             .AddObject("txt_4c_Produto", "TextBox")
800:             WITH .txt_4c_Produto
801:                 .FontName      = "Tahoma"
802:                 .FontSize      = 8
803:                 .Alignment     = 3
804:                 .Height        = 23
805:                 .Left          = 90
806:                 .MaxLength     = 14
807:                 .SpecialEffect = 1
808:                 .Top           = 36
809:                 .Width         = 108
810:                 .ForeColor     = RGB(0,0,0)
811:             ENDWITH
812:             .AddObject("txt_4c_Descricao", "TextBox")
813:             WITH .txt_4c_Descricao
814:                 .FontName      = "Tahoma"
815:                 .FontSize      = 8
816:                 .Alignment     = 3
817:                 .Height        = 23
818:                 .Left          = 199
819:                 .MaxLength     = 40
820:                 .SpecialEffect = 1
821:                 .Top           = 36
822:                 .Width         = 327
823:                 .ForeColor     = RGB(0,0,0)
824:                 .ReadOnly      = .T.
825:             ENDWITH
826: 
827:             .AddObject("lbl_4c_LblData", "Label")
828:             WITH .lbl_4c_LblData
829:                 .AutoSize   = .T.
830:                 .FontBold   = .T.
831:                 .FontName   = "Tahoma"
832:                 .FontSize   = 8
833:                 .BackStyle  = 0
834:                 .Caption    = "A partir de :"
835:                 .Height     = 15
836:                 .Left       = 20
837:                 .Top        = 64
838:                 .Width      = 68
839:                 .ForeColor  = RGB(90,90,90)
840:             ENDWITH
841:             .AddObject("txt_4c_TxtData", "TextBox")
842:             WITH .txt_4c_TxtData
843:                 .FontName      = "Tahoma"
844:                 .FontSize      = 8
845:                 .Alignment     = 3
846:                 .Format        = "D"
847:                 .Height        = 23
848:                 .Left          = 90
849:                 .SpecialEffect = 1
850:                 .Top           = 61
851:                 .Width         = 80
852:                 .ForeColor     = RGB(0,0,0)
853:                 .Value         = {}
854:             ENDWITH
855:         ENDWITH

*-- Linhas 861 a 987:
861:     PROTECTED PROCEDURE ConfigurarContainerOpCompra
862:         THIS.AddObject("cnt_4c_OpCompra", "Container")
863:         WITH THIS.cnt_4c_OpCompra
864:             .Top           = 447
865:             .Left          = 139
866:             .Width         = THIS.LarguraOpCompra
867:             .Height        = 91
868:             .BackStyle     = 0
869:             .BorderWidth   = 2
870:             .SpecialEffect = 2
871:             .Visible       = .F.
872:             .BackColor     = RGB(192,192,255)
873:             .BorderColor   = RGB(90,90,90)
874: 
875:             .AddObject("lbl_4c_TituloOp", "Label")
876:             WITH .lbl_4c_TituloOp
877:                 .AutoSize      = .T.
878:                 .FontBold      = .T.
879:                 .FontName      = "Tahoma"
880:                 .FontSize      = 8
881:                 .FontUnderline = .T.
882:                 .BackStyle     = 0
883:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Ultima Compra do Produto/Cliente"
884:                 .Left          = 140
885:                 .Top           = 2
886:                 .ForeColor     = RGB(90,90,90)
887:             ENDWITH
888: 
889:             .AddObject("lbl_4c_LblEmpresa", "Label")
890:             WITH .lbl_4c_LblEmpresa
891:                 .AutoSize   = .T.
892:                 .FontBold   = .T.
893:                 .FontName   = "Tahoma"
894:                 .FontSize   = 8
895:                 .BackStyle  = 0
896:                 .Caption    = "Empresa :"
897:                 .Height     = 15
898:                 .Left       = 31
899:                 .Top        = 14
900:                 .Width      = 57
901:                 .ForeColor  = RGB(90,90,90)
902:             ENDWITH
903:             .AddObject("txt_4c_Empresa", "TextBox")
904:             WITH .txt_4c_Empresa
905:                 .FontName      = "Tahoma"
906:                 .FontSize      = 8
907:                 .Alignment     = 3
908:                 .Height        = 23
909:                 .Left          = 90
910:                 .MaxLength     = 3
911:                 .SpecialEffect = 1
912:                 .Top           = 10
913:                 .Width         = 31
914:                 .ForeColor     = RGB(0,0,0)
915:                 .Value         = go_4c_Sistema.cCodEmpresa
916:             ENDWITH
917: 
918:             .AddObject("lbl_4c_LblProduto", "Label")
919:             WITH .lbl_4c_LblProduto
920:                 .AutoSize   = .T.
921:                 .FontBold   = .T.
922:                 .FontName   = "Tahoma"
923:                 .FontSize   = 8
924:                 .BackStyle  = 0
925:                 .Caption    = "Produto :"
926:                 .Left       = 35
927:                 .Top        = 39
928:                 .Width      = 53
929:                 .ForeColor  = RGB(90,90,90)
930:             ENDWITH
931:             .AddObject("txt_4c_Produto", "TextBox")
932:             WITH .txt_4c_Produto
933:                 .FontName      = "Tahoma"
934:                 .FontSize      = 8
935:                 .Alignment     = 3
936:                 .Height        = 23
937:                 .Left          = 90
938:                 .MaxLength     = 14
939:                 .SpecialEffect = 1
940:                 .Top           = 35
941:                 .Width         = 108
942:                 .ForeColor     = RGB(0,0,0)
943:             ENDWITH
944:             .AddObject("txt_4c_Descricao", "TextBox")
945:             WITH .txt_4c_Descricao
946:                 .FontName      = "Tahoma"
947:                 .FontSize      = 8
948:                 .Alignment     = 3
949:                 .Height        = 23
950:                 .Left          = 199
951:                 .MaxLength     = 40
952:                 .SpecialEffect = 1
953:                 .Top           = 35
954:                 .Width         = 327
955:                 .ForeColor     = RGB(0,0,0)
956:                 .ReadOnly      = .T.
957:             ENDWITH
958: 
959:             .AddObject("lbl_4c_LblData", "Label")
960:             WITH .lbl_4c_LblData
961:                 .AutoSize   = .T.
962:                 .FontBold   = .T.
963:                 .FontName   = "Tahoma"
964:                 .FontSize   = 8
965:                 .BackStyle  = 0
966:                 .Caption    = "A partir de :"
967:                 .Height     = 15
968:                 .Left       = 20
969:                 .Top        = 64
970:                 .Width      = 68
971:                 .ForeColor  = RGB(90,90,90)
972:             ENDWITH
973:             .AddObject("txt_4c_TxtData", "TextBox")
974:             WITH .txt_4c_TxtData
975:                 .FontName      = "Tahoma"
976:                 .FontSize      = 8
977:                 .Alignment     = 3
978:                 .Format        = "D"
979:                 .Height        = 23
980:                 .Left          = 90
981:                 .SpecialEffect = 1
982:                 .Top           = 60
983:                 .Width         = 80
984:                 .ForeColor     = RGB(0,0,0)
985:                 .Value         = {}
986:             ENDWITH
987:         ENDWITH

*-- Linhas 1005 a 1045:
1005:             ENDIF
1006: 
1007:             loc_cNome = UPPER(loc_oControl.Name)
1008: 
1009:             *-- Containers com Visible controlado explicitamente: nao forcar .T.
1010:             IF INLIST(loc_cNome, "CNT_4C_SOMBRA", ;
1011:                                  "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
1012:                                  "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA")
1013:                 *-- Tornar filhos visiveis sem tocar Visible do proprio container
1014:                 THIS.TornarControlesVisiveis(loc_oControl)
1015:                 LOOP
1016:             ENDIF
1017: 
1018:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1019:                 loc_oControl.Visible = .T.
1020:             ENDIF
1021: 
1022:             *-- Recursar em containers e pageframes
1023:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1024:                loc_oControl.ControlCount > 0
1025:                 THIS.TornarControlesVisiveis(loc_oControl)
1026:             ENDIF
1027:         ENDFOR
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     * ConfigurarBINDEVENTs - handlers dos checkboxes e botoes
1032:     *==========================================================================
1033:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1034:         *-- CheckBoxes e botoes principais
1035:         BINDEVENT(THIS.chk_4c_Conta,     "Click", THIS, "ChkContaClick")
1036:         BINDEVENT(THIS.chk_4c_Estoque,   "Click", THIS, "ChkEstoqueClick")
1037:         BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkCustoClick")
1038:         BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkCompraClick")
1039:         BINDEVENT(THIS.cmd_4c_Processa,  "Click", THIS, "BtnProcessarClick")
1040:         BINDEVENT(THIS.cmd_4c_Cancela,   "Click", THIS, "BtnCancelaClick")
1041: 
1042:         *-- OpConta: Empresa, Grupos, Contas, Moedas
1043:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_Empresa,   "KeyPress", THIS, "TxtContaEmpresaKeyPress")
1044:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos, "KeyPress", THIS, "TxtContaGruposKeyPress")
1045:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtContas, "KeyPress", THIS, "TxtContaContasKeyPress")

*-- Linhas 1082 a 1092:
1082:             THIS.chk_4c_Estoque.Enabled   = .F.
1083:             THIS.chk_4c_BtnCusto.Enabled  = .F.
1084:             THIS.chk_4c_BtnCompra.Enabled = .F.
1085:             THIS.cmd_4c_Processa.Enabled  = .F.
1086:             THIS.cmd_4c_Cancela.Enabled   = .F.
1087:             THIS.lbl_4c_LblEnd.Visible    = .F.
1088:             THIS.txt_4c_Registro.Value    = 0
1089:             DOEVENTS
1090: 
1091:             loc_oBO = THIS.this_oBusinessObject
1092:             loc_oBO.this_nRegistros = 0

*-- Linhas 1161 a 1169:
1161:             ENDIF
1162: 
1163:             IF loc_lAlgum
1164:                 THIS.lbl_4c_LblEnd.Visible = .T.
1165:             ENDIF
1166: 
1167:             loc_lSucesso = .T.
1168:         CATCH TO loc_oErro
1169:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 1175 a 1183:
1175:         THIS.chk_4c_Estoque.Enabled   = .T.
1176:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1177:         THIS.chk_4c_BtnCompra.Enabled = .T.
1178:         THIS.cmd_4c_Cancela.Enabled   = .T.
1179:         THIS.AtualizarEstadoProcessa()
1180: 
1181:         IF VARTYPE(loc_oProgress) = "O"
1182:             loc_oProgress.Release()
1183:             loc_oProgress = .NULL.

*-- Linhas 1222 a 1230:
1222:                      (THIS.chk_4c_Estoque.Value = 1) OR ;
1223:                      (THIS.chk_4c_BtnCusto.Value = 1) OR ;
1224:                      (THIS.chk_4c_BtnCompra.Value = 1)
1225:         THIS.cmd_4c_Processa.Enabled = loc_lAlgum
1226:     ENDPROC
1227: 
1228:     *==========================================================================
1229:     * KeyPress handlers - OpConta
1230:     *==========================================================================

*-- Linhas 1521 a 1529:
1521:     * Chamado apos processamento concluir OU quando quiser reiniciar selecao.
1522:     *==========================================================================
1523:     PROTECTED PROCEDURE ConfigurarPaginaLista
1524:         *-- Desmarca todos os checkboxes de opcao (Conta, Estoque, Custo, Compra)
1525:         THIS.chk_4c_Conta.Value     = 0
1526:         THIS.chk_4c_Estoque.Value   = 0
1527:         THIS.chk_4c_BtnCusto.Value  = 0
1528:         THIS.chk_4c_BtnCompra.Value = 0
1529: 

*-- Linhas 1535 a 1550:
1535: 
1536:         *-- Limpa contador de registros e oculta label de conclusao
1537:         THIS.txt_4c_Registro.Value  = 0
1538:         THIS.lbl_4c_LblEnd.Visible  = .F.
1539: 
1540:         *-- Reabilita controles (caso venham de processamento anterior)
1541:         THIS.chk_4c_Conta.Enabled     = .T.
1542:         THIS.chk_4c_Estoque.Enabled   = .T.
1543:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1544:         THIS.chk_4c_BtnCompra.Enabled = .T.
1545:         THIS.cmd_4c_Cancela.Enabled   = .T.
1546: 
1547:         *-- Atualiza estado do botao Processar (deve ficar desabilitado sem selecao)
1548:         THIS.AtualizarEstadoProcessa()
1549: 
1550:         RETURN .T.

*-- Linhas 1677 a 1688:
1677:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCompra)
1678: 
1679:         THIS.txt_4c_Registro.Value    = ""
1680:         THIS.lbl_4c_LblEnd.Visible    = .F.
1681: 
1682:         THIS.cmd_4c_Processa.Enabled  = .F.
1683:         THIS.cmd_4c_Cancela.Enabled   = .T.
1684: 
1685:         THIS.Refresh()
1686:     ENDPROC
1687: 
1688:     *==========================================================================

*-- Linhas 1700 a 1708:
1700:         THIS.cnt_4c_OpCusto.Enabled   = (THIS.chk_4c_BtnCusto.Value = 1)
1701:         THIS.cnt_4c_OpCompra.Enabled  = (THIS.chk_4c_BtnCompra.Value = 1)
1702: 
1703:         THIS.cmd_4c_Cancela.Enabled   = .T.
1704:         THIS.AtualizarEstadoProcessa()
1705:         THIS.Refresh()
1706:     ENDPROC
1707: 
1708:     *==========================================================================

*-- Linhas 1734 a 1742:
1734: 
1735:         IF loc_nSel = 0
1736:             loc_cMsg = "Nenhum tipo de rec" + CHR(225) + "lculo selecionado." + CHR(13) + ;
1737:                        "Marque um dos checkboxes para configurar o processamento."
1738:         ELSE
1739:             loc_cMsg = "Tipos selecionados (" + TRANSFORM(loc_nSel) + "):" + CHR(13) + ;
1740:                        loc_cSelecoes + CHR(13) + ;
1741:                        "Registros processados: " + ALLTRIM(TRANSFORM(THIS.txt_4c_Registro.Value))
1742:         ENDIF

*-- Linhas 1760 a 1768:
1760:         THIS.cnt_4c_OpCompra.Visible  = .F.
1761: 
1762:         THIS.txt_4c_Registro.Value    = ""
1763:         THIS.lbl_4c_LblEnd.Visible    = .F.
1764: 
1765:         THIS.AtualizarEstadoProcessa()
1766:         THIS.Refresh()
1767:     ENDPROC
1768: 

*-- Linhas 1909 a 1940:
1909:     ENDPROC
1910: 
1911:     *==========================================================================
1912:     * HabilitarCampos - Habilita/desabilita containers e checkboxes conforme
1913:     * o estado de processamento (par_lHabilitar). Chamado por Processa e
1914:     * ao terminar o processamento para bloquear a UI durante a execucao SQL.
1915:     *==========================================================================
1916:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1917:         LOCAL loc_lHab
1918:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1919: 
1920:         *-- Checkboxes principais
1921:         THIS.chk_4c_Conta.Enabled     = loc_lHab
1922:         THIS.chk_4c_Estoque.Enabled   = loc_lHab
1923:         THIS.chk_4c_BtnCusto.Enabled  = loc_lHab
1924:         THIS.chk_4c_BtnCompra.Enabled = loc_lHab
1925: 
1926:         *-- Containers de opcoes: enabled apenas se o checkbox correspondente
1927:         *-- estiver marcado E o form estiver habilitado
1928:         THIS.cnt_4c_OpConta.Enabled   = loc_lHab AND (THIS.chk_4c_Conta.Value     = 1)
1929:         THIS.cnt_4c_OpEstoque.Enabled = loc_lHab AND (THIS.chk_4c_Estoque.Value   = 1)
1930:         THIS.cnt_4c_OpCusto.Enabled   = loc_lHab AND (THIS.chk_4c_BtnCusto.Value  = 1)
1931:         THIS.cnt_4c_OpCompra.Enabled  = loc_lHab AND (THIS.chk_4c_BtnCompra.Value = 1)
1932: 
1933:         *-- Botoes de acao
1934:         THIS.cmd_4c_Cancela.Enabled  = loc_lHab
1935:         THIS.cmd_4c_Processa.Enabled = loc_lHab AND ( ;
1936:             THIS.chk_4c_Conta.Value = 1 OR THIS.chk_4c_Estoque.Value = 1 OR ;
1937:             THIS.chk_4c_BtnCusto.Value = 1 OR THIS.chk_4c_BtnCompra.Value = 1)
1938: 
1939:         RETURN .T.
1940:     ENDPROC

*-- Linhas 1957 a 1965:
1957:         THIS.cnt_4c_OpCompra.txt_4c_Empresa.Value  = loc_cEmp
1958: 
1959:         THIS.txt_4c_Registro.Value = 0
1960:         THIS.lbl_4c_LblEnd.Visible = .F.
1961: 
1962:         RETURN .T.
1963:     ENDPROC
1964: 
1965:     *==========================================================================

*-- Linhas 1999 a 2018:
1999: 
2000:         DO CASE
2001:             CASE loc_cModo = "PROCESSANDO"
2002:                 THIS.cmd_4c_Processa.Enabled = .F.
2003:                 THIS.cmd_4c_Cancela.Enabled  = .F.
2004:                 THIS.HabilitarCampos(.F.)
2005:             CASE loc_cModo = "CONCLUIDO"
2006:                 THIS.cmd_4c_Processa.Enabled = .F.
2007:                 THIS.cmd_4c_Cancela.Enabled  = .T.
2008:                 THIS.lbl_4c_LblEnd.Visible   = .T.
2009:                 THIS.HabilitarCampos(.F.)
2010:             OTHERWISE
2011:                 *-- INICIAL: aguardando selecao
2012:                 THIS.cmd_4c_Cancela.Enabled  = .T.
2013:                 THIS.lbl_4c_LblEnd.Visible   = .F.
2014:                 THIS.HabilitarCampos(.T.)
2015:                 THIS.AtualizarEstadoProcessa()
2016:         ENDCASE
2017: 
2018:         RETURN .T.


### BO (C:\4c\projeto\app\classes\SigPrCccBO.prg):
*==============================================================================
* SigPrCccBO.prg - Business Object para Recalculo de Saldos
* Herda de BusinessBase
* Tabela principal: SigOpClU (Ultima Compra por Cliente/Produto)
* Fases 1-2/8: Propriedades, Init e metodos de recalculo completos
*==============================================================================

DEFINE CLASS SigPrCccBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigOpClU"
    this_cCampoChave = "CidChaves"

    *--------------------------------------------------------------------------
    * Secao Conta Corrente (OpConta) - recalcula SigMvCcr
    *--------------------------------------------------------------------------
    this_cEmpConta    = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoConta  = ""    && txtGrupos   C(10) - grupo de conta
    this_cConta       = ""    && txtContas   C(10) - conta corrente
    this_cMoedaConta  = ""    && txtMoedas   C(3)  - moeda
    this_dDataConta   = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Estoque (OpEstoque) - recalcula SigMvHst
    *--------------------------------------------------------------------------
    this_cEmpEst      = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoEst    = ""    && txtGrupos   C(10) - grupo do deposito
    this_cEstoque     = ""    && Get_Estoque C(10) - codigo do deposito/estoque
    this_cProdEst     = ""    && Get_Produto C(14) - codigo do produto
    this_cDescProdEst = ""    && Get_Descs   C(40) - descricao do produto
    this_dDataEst     = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Custo de Produto (OpCusto) - recalcula custo em SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCusto      = ""  && Get_Empresa C(3)  - empresa filtro
    this_cProdCusto     = ""  && Get_Produto C(14) - codigo do produto
    this_cDescProdCusto = ""  && Get_Descs   C(40) - descricao do produto
    this_dDataCusto     = {}  && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Ultima Compra (OpCompra) - atualiza SigOpClU, SigCdCli, SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCompra      = "" && Get_Empresa C(3)  - empresa filtro
    this_cProdCompra     = "" && Get_Produto C(14) - codigo do produto
    this_cDescProdCompra = "" && Get_Descs   C(40) - descricao do produto
    this_dDataCompra     = {} && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Parametros do sistema (carregados de SigCdPam em InicializarDados)
    *--------------------------------------------------------------------------
    this_cMoeCentral  = ""    && MoeCentral  C(3)  - moeda central para cotacao
    this_cGrupoRecs   = ""    && GrupoRecs   C(10) - grupo recebimentos C.C.
    this_cGrupoPags   = ""    && GrupoPags   C(10) - grupo pagamentos C.C.
    this_cContaRecs   = ""    && ContaRecs   C(10) - conta recebimentos C.C.
    this_cContaPags   = ""    && ContaPags   C(10) - conta pagamentos C.C.

    *--------------------------------------------------------------------------
    * Estado do processamento
    *--------------------------------------------------------------------------
    this_nRegistros   = 0     && Get_Registro N    - contador de registros processados
    this_lProcessando = .F.   && .T. enquanto Processa.Click estiver rodando

    *--------------------------------------------------------------------------
    * Propriedades de linha - SigOpClU (CRUD)
    *--------------------------------------------------------------------------
    this_cChaves     = ""    && cidchaves  C(20) PK
    this_cCpros      = ""    && cpros      C(14)
    this_dDatas      = {}    && datas      datetime
    this_cDopes      = ""    && dopes      C(20)
    this_cEmpDopNums = ""    && empdopnums C(29)
    this_cEmps       = ""    && emps       C(3)
    this_cIclis      = ""    && iclis      C(10)
    this_cMoedas     = ""    && moedas     C(3)
    this_nNumes      = 0     && numes      N(6,0)
    this_nValors     = 0     && valors     N(13,2)
    this_nQtds       = 0     && qtds       N(12,0)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigOpClU"
            THIS.this_cCampoChave = "CidChaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarDados - carrega parametros de SigCdPam no BO
    *==========================================================================
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrupoRecs, GrupoPags, ContaRecs, ContaPags, MoeCentral " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cGrupoRecs  = NVL(GrupoRecs,  "")
                    THIS.this_cGrupoPags  = NVL(GrupoPags,  "")
                    THIS.this_cContaRecs  = NVL(ContaRecs,  "")
                    THIS.this_cContaPags  = NVL(ContaPags,  "")
                    THIS.this_cMoeCentral = NVL(MoeCentral, "")
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de SigCdPam.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega colunas de SigOpClU do cursor informado
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cChaves     = NVL(cidchaves,  SPACE(20))
            THIS.this_cCpros      = NVL(cpros,      SPACE(14))
            THIS.this_dDatas      = NVL(datas,      {})
            THIS.this_cDopes      = NVL(dopes,      SPACE(20))
            THIS.this_cEmpDopNums = NVL(empdopnums, SPACE(29))
            THIS.this_cEmps       = NVL(emps,       SPACE(3))
            THIS.this_cIclis      = NVL(iclis,      SPACE(10))
            THIS.this_cMoedas     = NVL(moedas,     SPACE(3))
            THIS.this_nNumes      = NVL(numes,      0)
            THIS.this_nValors     = NVL(valors,     0)
            THIS.this_nQtds       = NVL(qtds,       0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Inserir - insere um registro em SigOpClU
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            THIS.this_cChaves = SYS(2015) + SYS(2015)

            loc_cSQL = "INSERT INTO SigOpClU " + ;
                "(cidchaves, cpros, datas, dopes, empdopnums, " + ;
                " emps, iclis, moedas, numes, valors, qtds) " + ;
                "VALUES (" + ;
                EscaparSQL(LEFT(THIS.this_cChaves, 20))     + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 0)       + ")"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - atualiza registro em SigOpClU pela chave cidchaves
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpClU SET " + ;
                "cpros      = " + EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                "datas      = " + FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                "dopes      = " + EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                "emps       = " + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                "iclis      = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                "moedas     = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                "numes      = " + FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                "valors     = " + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                "qtds       = " + FormatarNumeroSQL(THIS.this_nQtds, 0)       + " " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna cidchaves do registro atual (para auditoria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaves
    ENDPROC

    *==========================================================================
    * RecalcularSaldosConta - recalcula saldos em SigMvCcr
    * Processa movimentos em ordem cronologica e atualiza saldos acumulados
    *==========================================================================
    PROCEDURE RecalcularSaldosConta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSaldo, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpConta)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "grupos = " + EscaparSQL(THIS.this_cGrupoConta)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "contas = " + EscaparSQL(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_cMoedaConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "moedas = " + EscaparSQL(THIS.this_cMoedaConta)
            ENDIF
            IF !EMPTY(THIS.this_dDataConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataConta)
            ENDIF

            loc_cSQL = "SELECT cidchaves, emps, grupos, contas, moedas, " + ;
                       "       datas, numes, opers, valors " + ;
                       "FROM SigMvCcr" + m.loc_cWhere + ;
                       " ORDER BY emps, grupos, contas, moedas, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CcrRec") > 0
                IF USED("cursor_4c_CcrRec") AND RECCOUNT("cursor_4c_CcrRec") > 0
                    loc_nSaldo  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_CcrRec
                    SCAN
                        loc_cKey = ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(contas) + ALLTRIM(moedas)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSaldo  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSaldo = loc_nSaldo + valors
                        ELSE
                            loc_nSaldo = loc_nSaldo - valors
                        ENDIF
                        loc_cSQL = "UPDATE SigMvCcr SET saldos = " + ;
                                   FormatarNumeroSQL(m.loc_nSaldo, 2) + ;
                                   " WHERE cidchaves = " + EscaparSQL(cidchaves)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CcrRec")
                    USE IN cursor_4c_CcrRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvCcr.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosConta")
            IF USED("cursor_4c_CcrRec")
                USE IN cursor_4c_CcrRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosEstoque - recalcula sqtds em SigMvHst
    * Processa movimentos em ordem e atualiza saldo acumulado de quantidade
    *==========================================================================
    PROCEDURE RecalcularSaldosEstoque()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSqtds, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpEst)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "grupos = " + EscaparSQL(THIS.this_cGrupoEst)
            ENDIF
            IF !EMPTY(THIS.this_cProdEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdEst)
            ENDIF
            IF !EMPTY(THIS.this_dDataEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataEst)
            ENDIF

            loc_cSQL = "SELECT cidchaves, cpros, emps, grupos, estos, " + ;
                       "       datas, numes, opers, qtds, sqtds " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " ORDER BY cpros, emps, grupos, estos, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_HstRec") > 0
                IF USED("cursor_4c_HstRec") AND RECCOUNT("cursor_4c_HstRec") > 0
                    loc_nSqtds  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_HstRec
                    SCAN
                        loc_cKey = ALLTRIM(cpros) + ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(estos)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSqtds  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSqtds = loc_nSqtds + qtds
                        ELSE
                            loc_nSqtds = loc_nSqtds - qtds
                        ENDIF
                        loc_cSQL = "UPDATE SigMvHst SET sqtds = " + ;
                                   FormatarNumeroSQL(m.loc_nSqtds, 3) + ;
                                   " WHERE cidchaves = " + EscaparSQL(cidchaves)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_HstRec")
                    USE IN cursor_4c_HstRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvHst.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosEstoque")
            IF USED("cursor_4c_HstRec")
                USE IN cursor_4c_HstRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCusto - recalcula custofs em SigCdPro
    * Media ponderada de custo a partir dos movimentos de entrada em SigMvHst
    *==========================================================================
    PROCEDURE RecalcularSaldosCusto()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpCusto)
            ENDIF
            IF !EMPTY(THIS.this_cProdCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdCusto)
            ENDIF
            IF !EMPTY(THIS.this_dDataCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataCusto)
            ENDIF

            loc_cSQL = "SELECT cpros, " + ;
                       "       SUM(qtds * units) / NULLIF(SUM(qtds), 0) AS custofsMedio " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CustoRec") > 0
                IF USED("cursor_4c_CustoRec") AND RECCOUNT("cursor_4c_CustoRec") > 0
                    SELECT cursor_4c_CustoRec
                    SCAN
                        IF !ISNULL(custofsMedio)
                            loc_cSQL = "UPDATE SigCdPro SET custofs = " + ;
                                       FormatarNumeroSQL(custofsMedio, 3) + ;
                                       " WHERE cpros = " + EscaparSQL(cpros)
                            SQLEXEC(gnConnHandle, m.loc_cSQL)
                            loc_nRecs = loc_nRecs + 1
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CustoRec")
                    USE IN cursor_4c_CustoRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao calcular custo de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCusto")
            IF USED("cursor_4c_CustoRec")
                USE IN cursor_4c_CustoRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCompra - atualiza SigOpClU com ultima compra por produto
    * Localiza a entrada mais recente em SigMvHst e atualiza SigOpClU
    *==========================================================================
    PROCEDURE RecalcularSaldosCompra()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs
        LOCAL loc_cChkSQL, loc_cUpSQL, loc_cPros, loc_cEmps

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpCompra)
            ENDIF
            IF !EMPTY(THIS.this_cProdCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdCompra)
            ENDIF
            IF !EMPTY(THIS.this_dDataCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataCompra)
            ENDIF

            loc_cSQL = "SELECT cpros, emps, " + ;
                       "       MAX(datas) AS ultimaData, " + ;
                       "       MAX(numes) AS ultimoNume " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros, emps"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraGrp") > 0
                IF USED("cursor_4c_CompraGrp") AND RECCOUNT("cursor_4c_CompraGrp") > 0
                    SELECT cursor_4c_CompraGrp
                    SCAN
                        loc_cPros = ALLTRIM(cpros)
                        loc_cEmps = ALLTRIM(emps)

                        *-- Busca detalhe do movimento mais recente
                        loc_cSQL = "SELECT TOP 1 cidchaves, cpros, emps, datas, numes, " + ;
                                   "            valors, qtds, moedas, dopes, empdopnums " + ;
                                   "FROM SigMvHst " + ;
                                   "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                   "  AND emps = "  + EscaparSQL(m.loc_cEmps) + ;
                                   " ORDER BY datas DESC, numes DESC"

                        IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraUlt") > 0
                            IF USED("cursor_4c_CompraUlt") AND RECCOUNT("cursor_4c_CompraUlt") > 0
                                SELECT cursor_4c_CompraUlt

                                *-- Verificar se ja existe registro em SigOpClU
                                loc_cChkSQL = "SELECT cidchaves FROM SigOpClU " + ;
                                              "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                              "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                IF SQLEXEC(gnConnHandle, m.loc_cChkSQL, "cursor_4c_CompraChk") > 0
                                    IF USED("cursor_4c_CompraChk") AND RECCOUNT("cursor_4c_CompraChk") > 0
                                        *-- UPDATE
                                        SELECT cursor_4c_CompraUlt
                                        loc_cUpSQL = "UPDATE SigOpClU SET " + ;
                                            "datas      = " + FormatarDataSQL(datas)          + ", " + ;
                                            "numes      = " + FormatarNumeroSQL(numes, 0)     + ", " + ;
                                            "valors     = " + FormatarNumeroSQL(valors, 2)    + ", " + ;
                                            "qtds       = " + FormatarNumeroSQL(qtds, 0)      + ", " + ;
                                            "moedas     = " + EscaparSQL(LEFT(moedas, 3))     + ", " + ;
                                            "dopes      = " + EscaparSQL(LEFT(dopes, 20))     + ", " + ;
                                            "empdopnums = " + EscaparSQL(LEFT(empdopnums, 29))+ " " + ;
                                            "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                            "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                        SQLEXEC(gnConnHandle, m.loc_cUpSQL)
                                    ELSE
                                        *-- INSERT novo
                                        SELECT cursor_4c_CompraUlt
                                        THIS.this_cCpros      = LEFT(cpros, 14)
                                        THIS.this_cEmps       = LEFT(emps, 3)
                                        THIS.this_dDatas      = datas
                                        THIS.this_nNumes      = numes
                                        THIS.this_nValors     = valors
                                        THIS.this_nQtds       = qtds
                                        THIS.this_cMoedas     = LEFT(moedas, 3)
                                        THIS.this_cDopes      = LEFT(dopes, 20)
                                        THIS.this_cEmpDopNums = LEFT(empdopnums, 29)
                                        THIS.this_cIclis      = SPACE(10)
                                        THIS.Inserir()
                                    ENDIF
                                    IF USED("cursor_4c_CompraChk")
                                        USE IN cursor_4c_CompraChk
                                    ENDIF
                                    loc_nRecs = loc_nRecs + 1
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_CompraUlt")
                                USE IN cursor_4c_CompraUlt
                            ENDIF
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CompraGrp")
                    USE IN cursor_4c_CompraGrp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar movimentos de compra.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCompra")
            IF USED("cursor_4c_CompraGrp")
                USE IN cursor_4c_CompraGrp
            ENDIF
            IF USED("cursor_4c_CompraUlt")
                USE IN cursor_4c_CompraUlt
            ENDIF
            IF USED("cursor_4c_CompraChk")
                USE IN cursor_4c_CompraChk
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

