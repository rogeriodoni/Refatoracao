# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 199: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 226: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 278: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 310: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 334: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1910 linhas total):

*-- Linhas 76 a 94:
76: 
77:             *-- Criar estrutura visual
78:             THIS.ConfigurarCabecalho()
79:             THIS.ConfigurarCheckboxes()
80:             THIS.ConfigurarBotoesPrincipais()
81:             THIS.ConfigurarContaineresOpcoes()
82:             THIS.ConfigurarPaginaDados()
83:             THIS.ConfigurarBINDEVENTs()
84:             THIS.ConfigurarRodape()
85: 
86:             *-- Tornar controles visiveis (exceto containers de opcoes e LblEnd)
87:             THIS.TornarControlesVisiveis(THIS)
88: 
89:             *-- Aplicar estado inicial: checkboxes off, containers ocultos,
90:             *   contador zerado, botao Processar desabilitado
91:             THIS.ConfigurarPaginaLista()
92: 
93:             loc_lSucesso = .T.
94:         CATCH TO loc_oErro

*-- Linhas 106 a 114:
106:         LOCAL loc_cImgFundo
107: 
108:         *-- Titulo do form (para telemetria/tracing; TitleBar=0 nao mostra)
109:         THIS.Caption = "Rec" + CHR(225) + "lculo de Saldos"
110: 
111:         *-- Imagem de fundo do framework
112:         loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
113:         IF FILE(loc_cImgFundo)
114:             THIS.Picture = loc_cImgFundo

*-- Linhas 126 a 288:
126:     *--------------------------------------------------------------------------
127:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH THIS.cnt_4c_Cabecalho
129:             .Top         = 0
130:             .Left        = 0
131:             .Width       = 1000
132:             .Height      = 80
133:             .BackStyle   = 1
134:             .BackColor   = RGB(100, 100, 100)
135:             .BorderWidth = 0
136:             .Visible     = .T.
137: 
138:             .AddObject("lbl_4c_Sombra", "Label")
139:             WITH .lbl_4c_Sombra
140:                 .Top       = 18
141:                 .Left      = 10
142:                 .Width     = THIS.Width
143:                 .Height    = 40
144:                 .AutoSize  = .F.
145:                 .BackStyle = 0
146:                 .FontBold  = .T.
147:                 .FontName  = "Tahoma"
148:                 .FontSize  = 18
149:                 .ForeColor = RGB(0, 0, 0)
150:                 .Caption   = "Rec" + CHR(225) + "lculo de Saldos"
151:                 .Visible   = .T.
152:             ENDWITH
153: 
154:             .AddObject("lbl_4c_Titulo", "Label")
155:             WITH .lbl_4c_Titulo
156:                 .Top       = 17
157:                 .Left      = 10
158:                 .Width     = THIS.Width
159:                 .Height    = 46
160:                 .AutoSize  = .F.
161:                 .BackStyle = 0
162:                 .FontBold  = .T.
163:                 .FontName  = "Tahoma"
164:                 .FontSize  = 18
165:                 .ForeColor = RGB(255, 255, 255)
166:                 .Caption   = "Rec" + CHR(225) + "lculo de Saldos"
167:                 .Visible   = .T.
168:             ENDWITH
169:         ENDWITH
170:     ENDPROC
171: 
172:     *--------------------------------------------------------------------------
173:     PROTECTED PROCEDURE ConfigurarCheckboxes()
174:     *  Shape de fundo decorativo + 4 checkboxes de selecao de modulo
175:     *  Posicoes escaladas 1.25x do original (800->1000)
176:     *--------------------------------------------------------------------------
177:         *-- Shape decorativo de fundo dos botoes de acao (direita)
178:         THIS.AddObject("shp_4c_Shape1", "Shape")
179:         WITH THIS.shp_4c_Shape1
180:             .Top         = 7
181:             .Left        = 871
182:             .Height      = 110
183:             .Width       = 112
184:             .BackStyle   = 0
185:             .BorderStyle = 0
186:             .BorderColor = RGB(136, 189, 188)
187:             .Visible     = .T.
188:         ENDWITH
189: 
190:         *-- CheckBox: Conta Corrente (original Left=350 -> 437)
191:         THIS.AddObject("chk_4c_Conta", "CheckBox")
192:         WITH THIS.chk_4c_Conta
193:             .Top           = 3
194:             .Left          = 437
195:             .Height        = 75
196:             .Width         = 75
197:             .FontBold      = .T.
198:             .FontItalic    = .T.
199:             .FontName      = "Comic Sans MS"
200:             .FontSize      = 8
201:             .AutoSize      = .F.
202:             .Alignment     = 1
203:             .BackStyle     = 0
204:             .Caption       = "C.C."
205:             .Value         = 0
206:             .SpecialEffect = 0
207:             .Style         = 1
208:             .ToolTipText   = "Conta Corrente"
209:             .ForeColor     = RGB(90, 90, 90)
210:             .BackColor     = RGB(255, 255, 255)
211:             .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
212:             .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
213:             .Themes        = .F.
214:             .Visible       = .T.
215:         ENDWITH
216: 
217:         *-- CheckBox: Estoque (original Left=425 -> 531)
218:         THIS.AddObject("chk_4c_Estoque", "CheckBox")
219:         WITH THIS.chk_4c_Estoque
220:             .Top           = 3
221:             .Left          = 531
222:             .Height        = 75
223:             .Width         = 75
224:             .FontBold      = .T.
225:             .FontItalic    = .T.
226:             .FontName      = "Comic Sans MS"
227:             .FontSize      = 8
228:             .AutoSize      = .F.
229:             .Alignment     = 1
230:             .BackStyle     = 0
231:             .Caption       = "Estoque"
232:             .Value         = 0
233:             .SpecialEffect = 0
234:             .Style         = 1
235:             .ForeColor     = RGB(90, 90, 90)
236:             .BackColor     = RGB(255, 255, 255)
237:             .Picture       = gc_4c_CaminhoIcones + "folder22.ico"
238:             .DownPicture   = gc_4c_CaminhoIcones + "a_diamd1.bmp"
239:             .Themes        = .F.
240:             .Visible       = .T.
241:         ENDWITH
242: 
243:         *-- CheckBox: Custo de Produto (original Left=500 -> 625)
244:         THIS.AddObject("chk_4c_BtnCusto", "CheckBox")
245:         WITH THIS.chk_4c_BtnCusto
246:             .Top           = 3
247:             .Left          = 625
248:             .Height        = 75
249:             .Width         = 75
250:             .FontBold      = .T.
251:             .FontItalic    = .T.
252:             .FontName      = "Comic Sans MS"
253:             .FontSize      = 8
254:             .AutoSize      = .F.
255:             .Alignment     = 1
256:             .BackStyle     = 0
257:             .Caption       = "Custo"
258:             .Value         = 0
259:             .SpecialEffect = 0
260:             .Style         = 1
261:             .ForeColor     = RGB(90, 90, 90)
262:             .BackColor     = RGB(255, 255, 255)
263:             .Picture       = gc_4c_CaminhoIcones + "folder34.ico"
264:             .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
265:             .Themes        = .F.
266:             .Visible       = .T.
267:         ENDWITH
268: 
269:         *-- CheckBox: Ultima Compra (original Left=575 -> 718)
270:         THIS.AddObject("chk_4c_BtnCompra", "CheckBox")
271:         WITH THIS.chk_4c_BtnCompra
272:             .Top           = 3
273:             .Left          = 718
274:             .Height        = 75
275:             .Width         = 75
276:             .FontBold      = .T.
277:             .FontItalic    = .T.
278:             .FontName      = "Comic Sans MS"
279:             .FontSize      = 8
280:             .AutoSize      = .F.
281:             .Alignment     = 1
282:             .BackStyle     = 0
283:             .Caption       = CHR(218) + "lt. Compra"
284:             .Value         = 0
285:             .SpecialEffect = 0
286:             .Style         = 1
287:             .ToolTipText   = CHR(218) + "ltima Compra"
288:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 298 a 364:
298:     PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
299:     *  Botoes Processar e Encerrar (original Left=650/725 -> 812/906)
300:     *--------------------------------------------------------------------------
301:         *-- Botao Processar (inicia desabilitado - habilita quando algum checkbox marcado)
302:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
303:         WITH THIS.cmd_4c_Processar
304:             .Top             = 3
305:             .Left            = 812
306:             .Height          = 75
307:             .Width           = 75
308:             .FontBold        = .T.
309:             .FontItalic      = .T.
310:             .FontName        = "Comic Sans MS"
311:             .FontSize        = 8
312:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
313:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
314:             .Caption         = "Processar"
315:             .Enabled         = .F.
316:             .ToolTipText     = "Processar"
317:             .SpecialEffect   = 0
318:             .ForeColor       = RGB(90, 90, 90)
319:             .BackColor       = RGB(255, 255, 255)
320:             .Themes          = .T.
321:             .WordWrap        = .T.
322:             .Visible         = .T.
323:         ENDWITH
324: 
325:         *-- Botao Encerrar (Cancel=.T. -> ESC fecha o form)
326:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
327:         WITH THIS.cmd_4c_Encerrar
328:             .Top           = 3
329:             .Left          = 906
330:             .Height        = 75
331:             .Width         = 75
332:             .FontBold      = .T.
333:             .FontItalic    = .T.
334:             .FontName      = "Comic Sans MS"
335:             .FontSize      = 8
336:             .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
337:             .Cancel        = .T.
338:             .Caption       = "Encerrar"
339:             .ToolTipText   = "[ESC] Sair"
340:             .SpecialEffect = 0
341:             .ForeColor     = RGB(90, 90, 90)
342:             .BackColor     = RGB(255, 255, 255)
343:             .Themes           = .T.
344:             .WordWrap      = .T.
345:             .Visible       = .T.
346:         ENDWITH
347:     ENDPROC
348: 
349:     *--------------------------------------------------------------------------
350:     PROTECTED PROCEDURE ConfigurarContaineresOpcoes()
351:     *  4 containers de parametros - iniciam ocultos, toggled pelos checkboxes
352:     *  Posicoes escaladas 1.25x: Left=139->173, Width=536->670
353:     *--------------------------------------------------------------------------
354: 
355:         *-- Container: Opcoes de Conta Corrente (original Top=114)
356:         THIS.AddObject("cnt_4c_OpConta", "Container")
357:         WITH THIS.cnt_4c_OpConta
358:             .Top           = 114
359:             .Left          = 173
360:             .Width         = 670
361:             .Height        = 81
362:             .BackStyle     = 0
363:             .BorderWidth   = 2
364:             .SpecialEffect = 2

*-- Linhas 370 a 379:
370:         *-- Container: Opcoes de Estoque (original Top=200)
371:         THIS.AddObject("cnt_4c_OpEstoque", "Container")
372:         WITH THIS.cnt_4c_OpEstoque
373:             .Top           = 200
374:             .Left          = 173
375:             .Width         = 670
376:             .Height        = 143
377:             .BackStyle     = 0
378:             .BorderWidth   = 2
379:             .SpecialEffect = 2

*-- Linhas 385 a 394:
385:         *-- Container: Opcoes de Custo de Produto (original Top=349)
386:         THIS.AddObject("cnt_4c_OpCusto", "Container")
387:         WITH THIS.cnt_4c_OpCusto
388:             .Top           = 349
389:             .Left          = 173
390:             .Width         = 670
391:             .Height        = 92
392:             .BackStyle     = 0
393:             .BorderWidth   = 2
394:             .SpecialEffect = 2

*-- Linhas 400 a 409:
400:         *-- Container: Opcoes de Ultima Compra (original Top=447)
401:         THIS.AddObject("cnt_4c_OpCompra", "Container")
402:         WITH THIS.cnt_4c_OpCompra
403:             .Top           = 447
404:             .Left          = 173
405:             .Width         = 670
406:             .Height        = 91
407:             .BackStyle     = 0
408:             .BorderWidth   = 2
409:             .SpecialEffect = 2

*-- Linhas 419 a 448:
419:     *  Posicoes escaladas 1.25x do original
420:     *--------------------------------------------------------------------------
421:         *-- Label "Registros : " (original Left=171 -> 213)
422:         THIS.AddObject("lbl_4c_Registros", "Label")
423:         WITH THIS.lbl_4c_Registros
424:             .Top       = 547
425:             .Left      = 213
426:             .Width     = 65
427:             .Height    = 15
428:             .AutoSize  = .T.
429:             .BackStyle = 0
430:             .FontBold  = .T.
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .ForeColor = RGB(90, 90, 90)
434:             .Caption   = "Registros : "
435:             .Visible   = .T.
436:         ENDWITH
437: 
438:         *-- TextBox contador (original Left=238 -> 297, Width=93 -> 116)
439:         *  ReadOnly: legado usa When=Return .F. para impedir foco
440:         THIS.AddObject("txt_4c_Registro", "TextBox")
441:         WITH THIS.txt_4c_Registro
442:             .Top           = 543
443:             .Left          = 297
444:             .Width         = 116
445:             .Height        = 23
446:             .FontName      = "Tahoma"
447:             .FontSize      = 8
448:             .InputMask     = "999,999,999"

*-- Linhas 456 a 619:
456: 
457:         *-- Label conclusao (oculto, exibido ao terminar processamento)
458:         *  original Left=361 -> 451, Width=205 -> 256
459:         THIS.AddObject("lbl_4c_LblEnd", "Label")
460:         WITH THIS.lbl_4c_LblEnd
461:             .Top       = 545
462:             .Left      = 451
463:             .Width     = 256
464:             .Height    = 22
465:             .AutoSize  = .T.
466:             .BackStyle = 0
467:             .FontBold  = .T.
468:             .FontName  = "Arial"
469:             .FontSize  = 12
470:             .Alignment = 2
471:             .ForeColor = RGB(255, 0, 0)
472:             .Caption   = "Processamento Conclu" + CHR(237) + "do"
473:             .Visible   = .F.
474:         ENDWITH
475:     ENDPROC
476: 
477:     *--------------------------------------------------------------------------
478:     PROTECTED PROCEDURE ConfigurarConteudoOpConta()
479:     *  Sub-controles de cnt_4c_OpConta (Opcoes Conta Corrente)
480:     *--------------------------------------------------------------------------
481:         LOCAL loc_oCnt
482:         loc_oCnt = THIS.cnt_4c_OpConta
483: 
484:         loc_oCnt.AddObject("lbl_4c_TituloConta", "Label")
485:         WITH loc_oCnt.lbl_4c_TituloConta
486:             .Top       = 2
487:             .Left      = 213
488:             .AutoSize  = .T.
489:             .BackStyle = 0
490:             .FontBold  = .T.
491:             .FontName  = "Tahoma"
492:             .FontSize  = 8
493:             .ForeColor = RGB(0, 0, 128)
494:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
495:             .Visible   = .T.
496:         ENDWITH
497: 
498:         loc_oCnt.AddObject("lbl_4c_EmpresaConta", "Label")
499:         WITH loc_oCnt.lbl_4c_EmpresaConta
500:             .Top       = 23
501:             .Left      = 20
502:             .Width     = 71
503:             .Height    = 15
504:             .AutoSize  = .F.
505:             .BackStyle = 0
506:             .FontName  = "Tahoma"
507:             .FontSize  = 8
508:             .Caption   = "Empresa :"
509:             .Visible   = .T.
510:         ENDWITH
511:         loc_oCnt.AddObject("txt_4c_EmpresaConta", "TextBox")
512:         WITH loc_oCnt.txt_4c_EmpresaConta
513:             .Top       = 20
514:             .Left      = 93
515:             .Width     = 38
516:             .Height    = 23
517:             .FontName  = "Tahoma"
518:             .FontSize  = 8
519:             .Value     = ""
520:             .Visible   = .T.
521:         ENDWITH
522: 
523:         loc_oCnt.AddObject("lbl_4c_GruposConta", "Label")
524:         WITH loc_oCnt.lbl_4c_GruposConta
525:             .Top       = 24
526:             .Left      = 152
527:             .Width     = 52
528:             .Height    = 15
529:             .AutoSize  = .F.
530:             .BackStyle = 0
531:             .FontName  = "Tahoma"
532:             .FontSize  = 8
533:             .Caption   = "Grupo :"
534:             .Visible   = .T.
535:         ENDWITH
536:         loc_oCnt.AddObject("txt_4c_GruposConta", "TextBox")
537:         WITH loc_oCnt.txt_4c_GruposConta
538:             .Top       = 20
539:             .Left      = 207
540:             .Width     = 100
541:             .Height    = 23
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .Value     = ""
545:             .Visible   = .T.
546:         ENDWITH
547: 
548:         loc_oCnt.AddObject("lbl_4c_ContasConta", "Label")
549:         WITH loc_oCnt.lbl_4c_ContasConta
550:             .Top       = 24
551:             .Left      = 318
552:             .Width     = 51
553:             .Height    = 15
554:             .AutoSize  = .F.
555:             .BackStyle = 0
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .Caption   = "Conta :"
559:             .Visible   = .T.
560:         ENDWITH
561:         loc_oCnt.AddObject("txt_4c_ContasConta", "TextBox")
562:         WITH loc_oCnt.txt_4c_ContasConta
563:             .Top       = 20
564:             .Left      = 372
565:             .Width     = 100
566:             .Height    = 23
567:             .FontName  = "Tahoma"
568:             .FontSize  = 8
569:             .Value     = ""
570:             .Visible   = .T.
571:         ENDWITH
572: 
573:         loc_oCnt.AddObject("lbl_4c_MoedasConta", "Label")
574:         WITH loc_oCnt.lbl_4c_MoedasConta
575:             .Top       = 50
576:             .Left      = 33
577:             .Width     = 57
578:             .Height    = 15
579:             .AutoSize  = .F.
580:             .BackStyle = 0
581:             .FontName  = "Tahoma"
582:             .FontSize  = 8
583:             .Caption   = "Moeda :"
584:             .Visible   = .T.
585:         ENDWITH
586:         loc_oCnt.AddObject("txt_4c_MoedasConta", "TextBox")
587:         WITH loc_oCnt.txt_4c_MoedasConta
588:             .Top       = 46
589:             .Left      = 93
590:             .Width     = 38
591:             .Height    = 23
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .Value     = ""
595:             .Visible   = .T.
596:         ENDWITH
597: 
598:         loc_oCnt.AddObject("lbl_4c_DataConta", "Label")
599:         WITH loc_oCnt.lbl_4c_DataConta
600:             .Top       = 50
601:             .Left      = 151
602:             .Width     = 85
603:             .Height    = 15
604:             .AutoSize  = .F.
605:             .BackStyle = 0
606:             .FontName  = "Tahoma"
607:             .FontSize  = 8
608:             .Caption   = "A partir de :"
609:             .Visible   = .T.
610:         ENDWITH
611:         loc_oCnt.AddObject("txt_4c_DataConta", "TextBox")
612:         WITH loc_oCnt.txt_4c_DataConta
613:             .Top       = 46
614:             .Left      = 238
615:             .Width     = 100
616:             .Height    = 23
617:             .FontName  = "Tahoma"
618:             .FontSize  = 8
619:             .Value     = {}

*-- Linhas 628 a 777:
628:         LOCAL loc_oCnt
629:         loc_oCnt = THIS.cnt_4c_OpEstoque
630: 
631:         loc_oCnt.AddObject("lbl_4c_TituloEst", "Label")
632:         WITH loc_oCnt.lbl_4c_TituloEst
633:             .Top       = 2
634:             .Left      = 227
635:             .AutoSize  = .T.
636:             .BackStyle = 0
637:             .FontBold  = .T.
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .ForeColor = RGB(0, 0, 128)
641:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Estoque"
642:             .Visible   = .T.
643:         ENDWITH
644: 
645:         loc_oCnt.AddObject("lbl_4c_EmpresaEst", "Label")
646:         WITH loc_oCnt.lbl_4c_EmpresaEst
647:             .Top       = 15
648:             .Left      = 38
649:             .Width     = 71
650:             .Height    = 15
651:             .AutoSize  = .F.
652:             .BackStyle = 0
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .Caption   = "Empresa :"
656:             .Visible   = .T.
657:         ENDWITH
658:         loc_oCnt.AddObject("txt_4c_EmpresaEst", "TextBox")
659:         WITH loc_oCnt.txt_4c_EmpresaEst
660:             .Top       = 12
661:             .Left      = 112
662:             .Width     = 38
663:             .Height    = 23
664:             .FontName  = "Tahoma"
665:             .FontSize  = 8
666:             .Value     = ""
667:             .Visible   = .T.
668:         ENDWITH
669: 
670:         loc_oCnt.AddObject("lbl_4c_GruposEst", "Label")
671:         WITH loc_oCnt.lbl_4c_GruposEst
672:             .Top       = 40
673:             .Left      = 57
674:             .Width     = 52
675:             .Height    = 15
676:             .AutoSize  = .F.
677:             .BackStyle = 0
678:             .FontName  = "Tahoma"
679:             .FontSize  = 8
680:             .Caption   = "Grupo :"
681:             .Visible   = .T.
682:         ENDWITH
683:         loc_oCnt.AddObject("txt_4c_GruposEst", "TextBox")
684:         WITH loc_oCnt.txt_4c_GruposEst
685:             .Top       = 37
686:             .Left      = 112
687:             .Width     = 100
688:             .Height    = 23
689:             .FontName  = "Tahoma"
690:             .FontSize  = 8
691:             .Value     = ""
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         loc_oCnt.AddObject("lbl_4c_EstoqueEst", "Label")
696:         WITH loc_oCnt.lbl_4c_EstoqueEst
697:             .Top       = 65
698:             .Left      = 43
699:             .Width     = 66
700:             .Height    = 15
701:             .AutoSize  = .F.
702:             .BackStyle = 0
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .Caption   = "Estoque :"
706:             .Visible   = .T.
707:         ENDWITH
708:         loc_oCnt.AddObject("txt_4c_EstoqueEst", "TextBox")
709:         WITH loc_oCnt.txt_4c_EstoqueEst
710:             .Top       = 62
711:             .Left      = 112
712:             .Width     = 100
713:             .Height    = 23
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .Value     = ""
717:             .Visible   = .T.
718:         ENDWITH
719: 
720:         loc_oCnt.AddObject("lbl_4c_ProdutoEst", "Label")
721:         WITH loc_oCnt.lbl_4c_ProdutoEst
722:             .Top       = 90
723:             .Left      = 43
724:             .Width     = 66
725:             .Height    = 15
726:             .AutoSize  = .F.
727:             .BackStyle = 0
728:             .FontName  = "Tahoma"
729:             .FontSize  = 8
730:             .Caption   = "Produto :"
731:             .Visible   = .T.
732:         ENDWITH
733:         loc_oCnt.AddObject("txt_4c_ProdutoEst", "TextBox")
734:         WITH loc_oCnt.txt_4c_ProdutoEst
735:             .Top       = 87
736:             .Left      = 112
737:             .Width     = 135
738:             .Height    = 23
739:             .FontName  = "Tahoma"
740:             .FontSize  = 8
741:             .Value     = ""
742:             .Visible   = .T.
743:         ENDWITH
744:         loc_oCnt.AddObject("txt_4c_DescsEst", "TextBox")
745:         WITH loc_oCnt.txt_4c_DescsEst
746:             .Top       = 87
747:             .Left      = 248
748:             .Width     = 408
749:             .Height    = 23
750:             .FontName  = "Tahoma"
751:             .FontSize  = 8
752:             .Value     = ""
753:             .Visible   = .T.
754:         ENDWITH
755: 
756:         loc_oCnt.AddObject("lbl_4c_DataEst", "Label")
757:         WITH loc_oCnt.lbl_4c_DataEst
758:             .Top       = 115
759:             .Left      = 25
760:             .Width     = 85
761:             .Height    = 15
762:             .AutoSize  = .F.
763:             .BackStyle = 0
764:             .FontName  = "Tahoma"
765:             .FontSize  = 8
766:             .Caption   = "A partir de :"
767:             .Visible   = .T.
768:         ENDWITH
769:         loc_oCnt.AddObject("txt_4c_DataEst", "TextBox")
770:         WITH loc_oCnt.txt_4c_DataEst
771:             .Top       = 112
772:             .Left      = 112
773:             .Width     = 100
774:             .Height    = 23
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .Value     = {}

*-- Linhas 786 a 885:
786:         LOCAL loc_oCnt
787:         loc_oCnt = THIS.cnt_4c_OpCusto
788: 
789:         loc_oCnt.AddObject("lbl_4c_TituloCusto", "Label")
790:         WITH loc_oCnt.lbl_4c_TituloCusto
791:             .Top       = 2
792:             .Left      = 193
793:             .AutoSize  = .T.
794:             .BackStyle = 0
795:             .FontBold  = .T.
796:             .FontName  = "Tahoma"
797:             .FontSize  = 8
798:             .ForeColor = RGB(0, 0, 128)
799:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
800:             .Visible   = .T.
801:         ENDWITH
802: 
803:         loc_oCnt.AddObject("lbl_4c_EmpresaCusto", "Label")
804:         WITH loc_oCnt.lbl_4c_EmpresaCusto
805:             .Top       = 14
806:             .Left      = 38
807:             .Width     = 71
808:             .Height    = 15
809:             .AutoSize  = .F.
810:             .BackStyle = 0
811:             .FontName  = "Tahoma"
812:             .FontSize  = 8
813:             .Caption   = "Empresa :"
814:             .Visible   = .T.
815:         ENDWITH
816:         loc_oCnt.AddObject("txt_4c_EmpresaCusto", "TextBox")
817:         WITH loc_oCnt.txt_4c_EmpresaCusto
818:             .Top       = 11
819:             .Left      = 112
820:             .Width     = 38
821:             .Height    = 23
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8
824:             .Value     = ""
825:             .Visible   = .T.
826:         ENDWITH
827: 
828:         loc_oCnt.AddObject("lbl_4c_ProdutoCusto", "Label")
829:         WITH loc_oCnt.lbl_4c_ProdutoCusto
830:             .Top       = 39
831:             .Left      = 43
832:             .Width     = 66
833:             .Height    = 15
834:             .AutoSize  = .F.
835:             .BackStyle = 0
836:             .FontName  = "Tahoma"
837:             .FontSize  = 8
838:             .Caption   = "Produto :"
839:             .Visible   = .T.
840:         ENDWITH
841:         loc_oCnt.AddObject("txt_4c_ProdutoCusto", "TextBox")
842:         WITH loc_oCnt.txt_4c_ProdutoCusto
843:             .Top       = 36
844:             .Left      = 112
845:             .Width     = 135
846:             .Height    = 23
847:             .FontName  = "Tahoma"
848:             .FontSize  = 8
849:             .Value     = ""
850:             .Visible   = .T.
851:         ENDWITH
852:         loc_oCnt.AddObject("txt_4c_DescsCusto", "TextBox")
853:         WITH loc_oCnt.txt_4c_DescsCusto
854:             .Top       = 36
855:             .Left      = 248
856:             .Width     = 408
857:             .Height    = 23
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .Value     = ""
861:             .Visible   = .T.
862:         ENDWITH
863: 
864:         loc_oCnt.AddObject("lbl_4c_DataCusto", "Label")
865:         WITH loc_oCnt.lbl_4c_DataCusto
866:             .Top       = 64
867:             .Left      = 25
868:             .Width     = 85
869:             .Height    = 15
870:             .AutoSize  = .F.
871:             .BackStyle = 0
872:             .FontName  = "Tahoma"
873:             .FontSize  = 8
874:             .Caption   = "A partir de :"
875:             .Visible   = .T.
876:         ENDWITH
877:         loc_oCnt.AddObject("txt_4c_DataCusto", "TextBox")
878:         WITH loc_oCnt.txt_4c_DataCusto
879:             .Top       = 61
880:             .Left      = 112
881:             .Width     = 100
882:             .Height    = 23
883:             .FontName  = "Tahoma"
884:             .FontSize  = 8
885:             .Value     = {}

*-- Linhas 894 a 993:
894:         LOCAL loc_oCnt
895:         loc_oCnt = THIS.cnt_4c_OpCompra
896: 
897:         loc_oCnt.AddObject("lbl_4c_TituloCompra", "Label")
898:         WITH loc_oCnt.lbl_4c_TituloCompra
899:             .Top       = 2
900:             .Left      = 175
901:             .AutoSize  = .T.
902:             .BackStyle = 0
903:             .FontBold  = .T.
904:             .FontName  = "Tahoma"
905:             .FontSize  = 8
906:             .ForeColor = RGB(0, 0, 128)
907:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de " + CHR(218) + "ltima Compra do Produto/Cliente"
908:             .Visible   = .T.
909:         ENDWITH
910: 
911:         loc_oCnt.AddObject("lbl_4c_EmpresaCompra", "Label")
912:         WITH loc_oCnt.lbl_4c_EmpresaCompra
913:             .Top       = 14
914:             .Left      = 38
915:             .Width     = 71
916:             .Height    = 15
917:             .AutoSize  = .F.
918:             .BackStyle = 0
919:             .FontName  = "Tahoma"
920:             .FontSize  = 8
921:             .Caption   = "Empresa :"
922:             .Visible   = .T.
923:         ENDWITH
924:         loc_oCnt.AddObject("txt_4c_EmpresaCompra", "TextBox")
925:         WITH loc_oCnt.txt_4c_EmpresaCompra
926:             .Top       = 10
927:             .Left      = 112
928:             .Width     = 38
929:             .Height    = 23
930:             .FontName  = "Tahoma"
931:             .FontSize  = 8
932:             .Value     = ""
933:             .Visible   = .T.
934:         ENDWITH
935: 
936:         loc_oCnt.AddObject("lbl_4c_ProdutoCompra", "Label")
937:         WITH loc_oCnt.lbl_4c_ProdutoCompra
938:             .Top       = 39
939:             .Left      = 43
940:             .Width     = 66
941:             .Height    = 15
942:             .AutoSize  = .F.
943:             .BackStyle = 0
944:             .FontName  = "Tahoma"
945:             .FontSize  = 8
946:             .Caption   = "Produto :"
947:             .Visible   = .T.
948:         ENDWITH
949:         loc_oCnt.AddObject("txt_4c_ProdutoCompra", "TextBox")
950:         WITH loc_oCnt.txt_4c_ProdutoCompra
951:             .Top       = 35
952:             .Left      = 112
953:             .Width     = 135
954:             .Height    = 23
955:             .FontName  = "Tahoma"
956:             .FontSize  = 8
957:             .Value     = ""
958:             .Visible   = .T.
959:         ENDWITH
960:         loc_oCnt.AddObject("txt_4c_DescsCompra", "TextBox")
961:         WITH loc_oCnt.txt_4c_DescsCompra
962:             .Top       = 35
963:             .Left      = 248
964:             .Width     = 408
965:             .Height    = 23
966:             .FontName  = "Tahoma"
967:             .FontSize  = 8
968:             .Value     = ""
969:             .Visible   = .T.
970:         ENDWITH
971: 
972:         loc_oCnt.AddObject("lbl_4c_DataCompra", "Label")
973:         WITH loc_oCnt.lbl_4c_DataCompra
974:             .Top       = 64
975:             .Left      = 25
976:             .Width     = 85
977:             .Height    = 15
978:             .AutoSize  = .F.
979:             .BackStyle = 0
980:             .FontName  = "Tahoma"
981:             .FontSize  = 8
982:             .Caption   = "A partir de :"
983:             .Visible   = .T.
984:         ENDWITH
985:         loc_oCnt.AddObject("txt_4c_DataCompra", "TextBox")
986:         WITH loc_oCnt.txt_4c_DataCompra
987:             .Top       = 60
988:             .Left      = 112
989:             .Width     = 100
990:             .Height    = 23
991:             .FontName  = "Tahoma"
992:             .FontSize  = 8
993:             .Value     = {}

*-- Linhas 1003 a 1012:
1003:         BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkBtnCustoClick")
1004:         BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkBtnCompraClick")
1005: 
1006:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1007:         BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "CmdEncerrarClick")
1008: 
1009:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "KeyPress", THIS, "TxtEmpresaContaKeyPress")
1010:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "DblClick", THIS, "TxtEmpresaContaDblClick")
1011:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "KeyPress", THIS, "TxtMoedasContaKeyPress")
1012:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "DblClick", THIS, "TxtMoedasContaDblClick")

*-- Linhas 1036 a 1070:
1036:     *--------------------------------------------------------------------------
1037:     PROTECTED PROCEDURE AtualizarBotaoProcessar()
1038:     *--------------------------------------------------------------------------
1039:         THIS.cmd_4c_Processar.Enabled = (THIS.chk_4c_Conta.Value     = 1 OR ;
1040:                                          THIS.chk_4c_Estoque.Value   = 1 OR ;
1041:                                          THIS.chk_4c_BtnCusto.Value  = 1 OR ;
1042:                                          THIS.chk_4c_BtnCompra.Value = 1)
1043:     ENDPROC
1044: 
1045:     *--------------------------------------------------------------------------
1046:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1047:     *  Reset do estado inicial (equivalente a Page1/LISTA em forms CRUD,
1048:     *  adaptado para o form OPERACIONAL flat): reseta checkboxes de selecao
1049:     *  de modulos, oculta containers de opcoes, esconde label de conclusao
1050:     *  e zera contador de registros processados.
1051:     *--------------------------------------------------------------------------
1052:         *-- Checkboxes de selecao de modulos: desmarcados
1053:         THIS.chk_4c_Conta.Value       = 0
1054:         THIS.chk_4c_Estoque.Value     = 0
1055:         THIS.chk_4c_BtnCusto.Value    = 0
1056:         THIS.chk_4c_BtnCompra.Value   = 0
1057: 
1058:         *-- Containers de opcoes ocultos (togglados pelos checkboxes)
1059:         THIS.cnt_4c_OpConta.Visible   = .F.
1060:         THIS.cnt_4c_OpEstoque.Visible = .F.
1061:         THIS.cnt_4c_OpCusto.Visible   = .F.
1062:         THIS.cnt_4c_OpCompra.Visible  = .F.
1063: 
1064:         *-- Rodape: label de conclusao oculto e contador zerado
1065:         THIS.lbl_4c_LblEnd.Visible    = .F.
1066:         THIS.txt_4c_Registro.Value    = 0
1067: 
1068:         *-- Botao Processar inicia desabilitado (nenhum modulo selecionado)
1069:         THIS.AtualizarBotaoProcessar()
1070:     ENDPROC

*-- Linhas 1107 a 1125:
1107:             THIS.chk_4c_Estoque.Enabled   = .F.
1108:             THIS.chk_4c_BtnCusto.Enabled  = .F.
1109:             THIS.chk_4c_BtnCompra.Enabled = .F.
1110:             THIS.cmd_4c_Processar.Enabled = .F.
1111:             THIS.cmd_4c_Encerrar.Enabled  = .F.
1112:             THIS.lbl_4c_LblEnd.Visible    = .F.
1113:             THIS.txt_4c_Registro.Value    = 0
1114:         OTHERWISE
1115:             *-- Modo SELECAO (par_nPagina = 1 ou omitido)
1116:             THIS.chk_4c_Conta.Enabled     = .T.
1117:             THIS.chk_4c_Estoque.Enabled   = .T.
1118:             THIS.chk_4c_BtnCusto.Enabled  = .T.
1119:             THIS.chk_4c_BtnCompra.Enabled = .T.
1120:             THIS.cmd_4c_Encerrar.Enabled  = .T.
1121:             THIS.AtualizarBotaoProcessar()
1122:         ENDCASE
1123:     ENDPROC
1124: 
1125:     *--------------------------------------------------------------------------

*-- Linhas 1197 a 1205:
1197:             loc_lSucesso = loc_oBO.Processar(THIS)
1198:             THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1199:             IF loc_lSucesso
1200:                 THIS.lbl_4c_LblEnd.Visible = .T.
1201:                 MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso.", ;
1202:                         "Rec" + CHR(225) + "lculo de Saldos")
1203:             ELSE
1204:                 MsgAviso("Processamento conclu" + CHR(237) + "do com erros.", ;
1205:                          "Rec" + CHR(225) + "lculo de Saldos")

*-- Linhas 1500 a 1526:
1500:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1501:     *  Torna controles visiveis recursivamente.
1502:     *  EXCECOES (permanecem ocultos apos InicializarForm):
1503:     *    - cnt_4c_OpConta/OpEstoque/OpCusto/OpCompra: toggled pelos checkboxes
1504:     *    - lbl_4c_LblEnd: exibido apenas ao concluir processamento
1505:     *--------------------------------------------------------------------------
1506:         LOCAL loc_i, loc_p, loc_oControl
1507:         FOR loc_i = 1 TO par_oContainer.ControlCount
1508:             loc_oControl = par_oContainer.Controls(loc_i)
1509:             IF VARTYPE(loc_oControl) != "O"
1510:                 LOOP
1511:             ENDIF
1512: 
1513:             *-- Containers gerenciados: nao forcar .Visible via este metodo
1514:             *  - CNT_4C_CABECALHO: visivel mas recursao ja garante filhos visiveis
1515:             *  - CNT_4C_OPCONTA/OPESTOQUE/OPCUSTO/OPCOMPRA: toggled pelos checkboxes (inicia .F.)
1516:             *  - LBL_4C_LBLEND: exibido apenas ao concluir processamento (inicia .F.)
1517:             IF INLIST(UPPER(loc_oControl.Name), ;
1518:                 "CNT_4C_CABECALHO", ;
1519:                 "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
1520:                 "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA", ;
1521:                 "LBL_4C_LBLEND")
1522:                 *-- Recursao nos filhos para que fiquem prontos quando container tornar visivel
1523:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1524:                     THIS.TornarControlesVisiveis(loc_oControl)
1525:                 ENDIF
1526:                 LOOP

*-- Linhas 1558 a 1566:
1558:                          "Rec" + CHR(225) + "lculo de Saldos")
1559:                 RETURN
1560:             ENDIF
1561:             THIS.lbl_4c_LblEnd.Visible = .F.
1562:             THIS.txt_4c_Registro.Value = 0
1563:             THIS.CmdProcessarClick()
1564:         CATCH TO loc_oErro
1565:             MsgErro(loc_oErro.Message, "Erro ao iniciar processamento")
1566:         ENDTRY

*-- Linhas 1582 a 1590:
1582:             ENDIF
1583:             IF MsgConfirma("Reexecutar o processamento com as op" + CHR(231) + CHR(245) + "es atuais?", ;
1584:                            "Rec" + CHR(225) + "lculo de Saldos")
1585:                 THIS.lbl_4c_LblEnd.Visible = .F.
1586:                 THIS.txt_4c_Registro.Value = 0
1587:                 THIS.CmdProcessarClick()
1588:             ENDIF
1589:         CATCH TO loc_oErro
1590:             MsgErro(loc_oErro.Message, "Erro ao reexecutar processamento")

*-- Linhas 1612 a 1630:
1612:                        "Custo...............: " + IIF(THIS.chk_4c_BtnCusto.Value = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
1613:                        CHR(250) + "lt. Compra..........: " + IIF(THIS.chk_4c_BtnCompra.Value = 1, "SIM", "N" + CHR(227) + "O")
1614: 
1615:             THIS.lbl_4c_LblEnd.Visible = (loc_nRegistros > 0)
1616:             MsgInfo(loc_cMsg, "Rec" + CHR(225) + "lculo de Saldos")
1617:         CATCH TO loc_oErro
1618:             MsgErro(loc_oErro.Message, "Erro ao visualizar resumo")
1619:         ENDTRY
1620:     ENDPROC
1621: 
1622:     *--------------------------------------------------------------------------
1623:     * BtnExcluirClick - Cancela / reinicia a selecao de opcoes
1624:     * Form OPERACIONAL: nao ha exclusao de dados; a acao reseta os
1625:     * checkboxes, esconde os paineis flutuantes e zera o contador.
1626:     *--------------------------------------------------------------------------
1627:     PROCEDURE BtnExcluirClick()
1628:         LOCAL loc_oErro
1629:         TRY
1630:             IF !MsgConfirma("Limpar todas as op" + CHR(231) + CHR(245) + "es selecionadas?", ;

*-- Linhas 1643 a 1651:
1643:             THIS.cnt_4c_OpCompra.Visible  = .F.
1644: 
1645:             THIS.txt_4c_Registro.Value = 0
1646:             THIS.lbl_4c_LblEnd.Visible = .F.
1647: 
1648:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1649:                 THIS.this_oBusinessObject.this_nRegistros = 0
1650:             ENDIF
1651: 

*-- Linhas 1659 a 1667:
1659:     *--------------------------------------------------------------------------
1660:     PROCEDURE FormParaBO()
1661:     *  Transfere os valores dos campos visuais para as propriedades do BO.
1662:     *  Para o form OPERACIONAL: copia flags dos checkboxes e parametros
1663:     *  de cada secao ativa para as propriedades this_* do BO.
1664:     *--------------------------------------------------------------------------
1665:         LOCAL loc_oBO, loc_oErro
1666:         TRY
1667:             loc_oBO = THIS.this_oBusinessObject

*-- Linhas 1722 a 1743:
1722:                 RETURN
1723:             ENDIF
1724:             THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1725:             THIS.lbl_4c_LblEnd.Visible = (loc_oBO.this_nRegistros > 0)
1726:         CATCH TO loc_oErro
1727:             MsgErro(loc_oErro.Message, "Erro")
1728:         ENDTRY
1729:     ENDPROC
1730: 
1731:     *--------------------------------------------------------------------------
1732:     PROCEDURE LimparCampos()
1733:     *  Limpa todos os campos de entrada nos 4 containers de opcoes e
1734:     *  redefine flags/checkboxes para o estado inicial (sem selecao).
1735:     *--------------------------------------------------------------------------
1736:         LOCAL loc_oErro
1737:         TRY
1738:             *-- Checkboxes
1739:             THIS.chk_4c_Conta.Value     = 0
1740:             THIS.chk_4c_Estoque.Value   = 0
1741:             THIS.chk_4c_BtnCusto.Value  = 0
1742:             THIS.chk_4c_BtnCompra.Value = 0
1743: 

*-- Linhas 1770 a 1778:
1770: 
1771:             *-- Rodape
1772:             THIS.txt_4c_Registro.Value = 0
1773:             THIS.lbl_4c_LblEnd.Visible = .F.
1774: 
1775:             *-- Oculta containers flutuantes
1776:             THIS.cnt_4c_OpConta.Visible   = .F.
1777:             THIS.cnt_4c_OpEstoque.Visible = .F.
1778:             THIS.cnt_4c_OpCusto.Visible   = .F.

*-- Linhas 1797 a 1811:
1797:             THIS.chk_4c_Estoque.Enabled   = par_lHabilitar
1798:             THIS.chk_4c_BtnCusto.Enabled  = par_lHabilitar
1799:             THIS.chk_4c_BtnCompra.Enabled = par_lHabilitar
1800:             THIS.cmd_4c_Encerrar.Enabled  = par_lHabilitar
1801: 
1802:             IF par_lHabilitar
1803:                 *-- Ao habilitar, Processar depende da selecao dos checkboxes
1804:                 THIS.AtualizarBotaoProcessar()
1805:             ELSE
1806:                 THIS.cmd_4c_Processar.Enabled = .F.
1807:             ENDIF
1808:         CATCH TO loc_oErro
1809:             MsgErro(loc_oErro.Message, "Erro")
1810:         ENDTRY
1811:     ENDPROC

*-- Linhas 1821 a 1829:
1821: 
1822:     *--------------------------------------------------------------------------
1823:     PROCEDURE CarregarLista()
1824:     *  Reinicia o form para o estado inicial: desmarca checkboxes, oculta
1825:     *  containers de opcoes e zera o contador. Equivalente ao "recarregar
1826:     *  a lista" nos forms CRUD, adaptado para o form OPERACIONAL flat.
1827:     *--------------------------------------------------------------------------
1828:         LOCAL loc_oErro
1829:         TRY

*-- Linhas 1866 a 1874:
1866:                 RETURN
1867:             ENDIF
1868:             THIS.FormParaBO()
1869:             THIS.lbl_4c_LblEnd.Visible = .F.
1870:             THIS.txt_4c_Registro.Value = 0
1871:             THIS.CmdProcessarClick()
1872:         CATCH TO loc_oErro
1873:             MsgErro(loc_oErro.Message, "Erro ao processar")
1874:         ENDTRY


### BO (C:\4c\projeto\app\classes\SigPrCccBO.prg):
*==============================================================================
* SigPrCccBO.prg - Business Object para Rec?lculo de Saldos
* Herda de: BusinessBase
* Entidade: SigPrCcc
* Tabela principal: SigOpClU (ultima compra por cliente/produto)
*==============================================================================
DEFINE CLASS SigPrCccBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "SigOpClU"
    this_cCampoChave = "CidChaves"

    *-- Filtros secao Conta Corrente (OpConta)
    this_cEmpConta     = ""
    this_cGruposConta  = ""
    this_cContasConta  = ""
    this_cMoedasConta  = ""
    this_dDataConta    = {}

    *-- Filtros secao Estoque (OpEstoque)
    this_cEmpEstoque       = ""
    this_cGruposEstoque    = ""
    this_cEstoqueEstoque   = ""
    this_cProdutoEstoque   = ""
    this_cDescricaoEstoque = ""
    this_dDataEstoque      = {}

    *-- Filtros secao Custo de Produto (OpCusto)
    this_cEmpCusto       = ""
    this_cProdutoCusto   = ""
    this_cDescricaoCusto = ""
    this_dDataCusto      = {}

    *-- Filtros secao Ultima Compra (OpCompra)
    this_cEmpCompra       = ""
    this_cProdutoCompra   = ""
    this_cDescricaoCompra = ""
    this_dDataCompra      = {}

    *-- Flags de processamento (estado dos checkboxes)
    this_lProcessarConta   = .F.
    this_lProcessarEstoque = .F.
    this_lProcessarCusto   = .F.
    this_lProcessarCompra  = .F.

    *-- Contador de registros (exibido no txt_4c_Registro)
    this_nRegistros = 0

    *-- Conexao legada para funcoes de recalculo do Framework
    this_oDataMgr = .NULL.

    *-- Campos da tabela SigOpClU (para CRUD direto)
    this_cCidchaves   = ""
    this_cCpros       = ""
    this_dDatas       = {}
    this_cDopes       = ""
    this_cEmpdopnums  = ""
    this_cEmps        = ""
    this_cIclis       = ""
    this_cMoedas      = ""
    this_nNumes       = 0
    this_nValors      = 0
    this_nQtds        = 0

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *  Retorna a chave primaria (CidChaves) do registro atual.
    *  Se estiver vazia (novo registro), gera nova via SYS(2015)+SYS(2015).
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cCidchaves)
            RETURN SYS(2015) + SYS(2015)
        ENDIF
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
    *  Limpa propriedades da tabela SigOpClU (novo registro)
    *--------------------------------------------------------------------------
        THIS.this_cCidchaves   = ""
        THIS.this_cCpros       = ""
        THIS.this_dDatas       = {}
        THIS.this_cDopes       = ""
        THIS.this_cEmpdopnums  = ""
        THIS.this_cEmps        = ""
        THIS.this_cIclis       = ""
        THIS.this_cMoedas      = ""
        THIS.this_nNumes       = 0
        THIS.this_nValors      = 0
        THIS.this_nQtds        = 0
        THIS.this_cMensagemErro = ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *  Carrega dados de SigOpClU do cursor para as propriedades this_*.
    *  Segue padrao canonico: SELECT (alias) + acesso direto aos campos.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor '" + par_cAliasCursor + "' n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCpros      = TratarNulo(cpros,      "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cDopes      = TratarNulo(dopes,      "C")
            THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
            THIS.this_cEmps       = TratarNulo(emps,       "C")
            THIS.this_cIclis      = TratarNulo(iclis,      "C")
            THIS.this_cMoedas     = TratarNulo(moedas,     "C")
            THIS.this_nNumes      = TratarNulo(numes,      "N")
            THIS.this_nValors     = TratarNulo(valors,     "N")
            THIS.this_nQtds       = TratarNulo(qtds,       "N")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *  Valida campos obrigatorios de SigOpClU antes de INSERT/UPDATE.
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cEmps)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cDopes)
            THIS.this_cMensagemErro = "Documento " + CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF THIS.this_nNumes <= 0
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmpdopnums)
            THIS.this_cEmpdopnums = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                                    PADL(ALLTRIM(TRANSFORM(THIS.this_nNumes)), 6, "0")
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *  INSERT INTO SigOpClU. Gera nova CidChaves se vazia.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpClU " + ;
                       "(cidchaves, cpros, datas, dopes, empdopnums, " + ;
                       " emps, iclis, moedas, numes, valors, qtds) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidchaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCpros))     + ", " + ;
                       IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpdopnums))+ ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps))      + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cIclis))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMoedas))    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)        + ")"

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *  UPDATE SigOpClU pelo cidchaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpClU SET " + ;
                       "cpros = "      + EscaparSQL(ALLTRIM(THIS.this_cCpros))     + ", " + ;
                       "datas = "      + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       "dopes = "      + EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                       "empdopnums = " + EscaparSQL(ALLTRIM(THIS.this_cEmpdopnums))+ ", " + ;
                       "emps = "       + EscaparSQL(ALLTRIM(THIS.this_cEmps))      + ", " + ;
                       "iclis = "      + EscaparSQL(ALLTRIM(THIS.this_cIclis))     + ", " + ;
                       "moedas = "     + EscaparSQL(ALLTRIM(THIS.this_cMoedas))    + ", " + ;
                       "numes = "      + FormatarNumeroSQL(THIS.this_nNumes)       + ", " + ;
                       "valors = "     + FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
                       "qtds = "       + FormatarNumeroSQL(THIS.this_nQtds)        + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao atualizar registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *  DELETE FROM SigOpClU pelo cidchaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigOpClU WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao excluir registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexao()
    *  Cria conexao legada para funcoes de recalculo do Framework (fSqlConector)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oDataMgr) != "O" OR ISNULL(THIS.this_oDataMgr)
                THIS.this_oDataMgr = CREATEOBJECT('fSqlConector', 'RECSALDO', .T.)
                IF THIS.this_oDataMgr.pnIdConn > 0
                    THIS.this_oDataMgr.AddCursor('SigOpClU', 'CidChaves', 'CrSigOpClU')
                    THIS.this_oDataMgr.Cursorquery('SigCdPam', 'CrSigCdPam', .F., .F., ;
                        'GrupoRecs,GrupoPags,ContaRecs,ContaPags,MoeCentral')
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Imposs" + CHR(237) + "vel efetuar conex" + CHR(227) + ;
                            "o com o servidor de banco de dados.", "Erro de Conex" + CHR(227) + "o")
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_oForm)
    *  Metodo principal: executa todos os recalculos selecionados via flags
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.InicializarConexao()
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = .T.

                IF THIS.this_lProcessarConta
                    IF !THIS.ProcessarContaCorrente(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarEstoque
                    IF !THIS.ProcessarEstoque(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarCusto
                    IF !THIS.ProcessarCusto(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarCompra
                    IF !THIS.ProcessarUltimaCompra(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarContaCorrente(par_oForm)
    *  Recalcula saldos de Conta Corrente em SigMvCcr via fRecalculaS
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cGrupo, loc_cConta, loc_cMoeda
        LOCAL loc_dData, loc_cGcm, loc_llConc, loc_cWhere, loc_cWherC
        LOCAL loc_cQuery, loc_lOk, loc_nReg, loc_oProgConta, loc_pData

        loc_lSucesso = .F.
        TRY
            loc_cEmp   = PADR(THIS.this_cEmpConta,    3)
            loc_cGrupo = PADR(THIS.this_cGruposConta, 10)
            loc_cConta = PADR(THIS.this_cContasConta, 10)
            loc_cMoeda = PADR(THIS.this_cMoedasConta,  3)
            loc_dData  = THIS.this_dDataConta
            loc_llConc = .T.
            loc_pData  = IIF(EMPTY(loc_dData), CTOD('01/01/1900'), loc_dData)
            loc_cGcm   = IIF(!EMPTY(loc_cGrupo) .AND. !EMPTY(loc_cConta) .AND. !EMPTY(loc_cMoeda), ;
                             loc_cGrupo + loc_cConta + loc_cMoeda, SPACE(23))

            loc_cWhere = "Where 0 = 0 " + ;
                IIF(!EMPTY(loc_cGrupo), "And Grupos = '" + ALLTRIM(loc_cGrupo) + "' ", " ") + ;
                IIF(!EMPTY(loc_cConta), "And Contas = '" + ALLTRIM(loc_cConta) + "' ", " ") + ;
                IIF(!EMPTY(loc_cMoeda), "And Moedas = '" + ALLTRIM(loc_cMoeda) + "' ", " ") + ;
                IIF(!EMPTY(loc_cEmp),   "And Emps = '"   + ALLTRIM(loc_cEmp)   + "' ", " ") + ;
                IIF(!EMPTY(loc_dData),  "And Datas >= "  + FormatarDataSQL(loc_dData) + " ", " ")

            loc_cWherC = "Where 0 = 0 " + ;
                IIF(!EMPTY(loc_cGrupo), "And Grupos = '"    + ALLTRIM(loc_cGrupo) + "' ", " ") + ;
                IIF(!EMPTY(loc_cConta), "And Contas = '"    + ALLTRIM(loc_cConta) + "' ", " ") + ;
                IIF(!EMPTY(loc_cMoeda), "And Moedas = '"    + ALLTRIM(loc_cMoeda) + "' ", " ") + ;
                IIF(!EMPTY(loc_cEmp),   "And Emps = '"      + ALLTRIM(loc_cEmp)   + "' ", " ") + ;
                IIF(!EMPTY(loc_dData),  "And DataConcs >= " + FormatarDataSQL(loc_dData) + " ", " ") + ;
                "And Concs = 1 "

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF
            CREATE CURSOR TmpConta (Emps C(3), Grupos C(10), Contas C(10), Moedas C(3), CidChaves C(20))
            INDEX ON CidChaves TAG CidChaves

            DO WHILE .T.
                IF !EMPTY(loc_cGcm)
                    IF EMPTY(loc_cEmp)
                        loc_cQuery = "Select Cemps From SigCdEmp"
                        IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpEmps') < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (TmpEmps)", "Erro")
                            EXIT
                        ENDIF
                        SELECT TmpEmps
                        GO TOP
                        SCAN
                            INSERT INTO TmpConta (Emps, Grupos, Contas, Moedas, CidChaves) ;
                                VALUES (TmpEmps.Cemps, loc_cGrupo, loc_cConta, ;
                                        loc_cMoeda, SYS(2015)+SYS(2015))
                            SELECT TmpEmps
                        ENDSCAN
                        IF USED("TmpEmps")
                            USE IN TmpEmps
                        ENDIF
                    ELSE
                        INSERT INTO TmpConta (Emps, Grupos, Contas, Moedas, CidChaves) ;
                            VALUES (loc_cEmp, loc_cGrupo, loc_cConta, ;
                                    loc_cMoeda, SYS(2015)+SYS(2015))
                    ENDIF
                ELSE
                    loc_cQuery = "Select Distinct Emps, Grupos, Contas, Moedas, " + ;
                                 "Space(20) as CidChaves From SigMvCcr " + loc_cWhere + ;
                                 " Union all " + ;
                                 "Select Distinct Emps, Grupos, Contas, Moedas, " + ;
                                 "Space(20) as CidChaves From SigMvCcr " + loc_cWherC
                    IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpConta') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (TmpConta)", "Erro")
                        EXIT
                    ENDIF
                    SELECT TmpConta
                    REPLACE ALL CidChaves WITH SYS(2015)+SYS(2015)
                    INDEX ON CidChaves TAG Cidchaves
                ENDIF

                *-- Processa os registros de TmpConta
                DO WHILE .T.
                    SELECT * FROM TmpConta INTO CURSOR Selecao ORDER BY Emps, Grupos, Contas, Moedas
                    SELECT Selecao
                    IF RECCOUNT() = 0
                        EXIT
                    ENDIF

                    loc_nReg      = RECCOUNT('Selecao')
                    loc_oProgConta = CREATEOBJECT('fwprogressbar', ;
                        'Recalculando Saldo de Conta Corrente', loc_nReg)
                    loc_oProgConta.Titulo.FontBold = .T.
                    loc_oProgConta.Show

                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oProgConta.Update(.T.)
                        loc_oProgConta.SubTitulo.Caption = ALLTRIM(Selecao.Grupos) + " : " + ;
                            ALLTRIM(Selecao.Contas) + "-" + ALLTRIM(Selecao.Moedas)

                        =fRecalculaS(Selecao.Grupos, Selecao.Contas, loc_pData, Selecao.Moedas)
                        loc_lOk = fRecalculaS(.T., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF

                        SELECT TmpConta
                        IF SEEK(Selecao.CidChaves)
                            DELETE
                        ENDIF
                    ENDSCAN

                    loc_oProgConta.Complete(.T.)
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF
                ENDDO

                loc_lSucesso = .T.
                EXIT
            ENDDO

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEstoque(par_oForm)
    *  Recalcula saldos de Estoque em SigMvHst via fRecalculaP
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEstoque, loc_cEmpresa, loc_cGrupo, loc_cProduto
        LOCAL loc_dData, loc_cWhere, loc_cQuery, loc_lOk, loc_nReg, loc_oProgConta
        LOCAL loc_cEmpIni, loc_cGruIni, loc_cEstIni, loc_cEmpFin, loc_cGruFin, loc_cEstFin
        LOCAL loc_pData

        loc_lSucesso = .F.
        TRY
            loc_cEstoque = PADR(THIS.this_cEstoqueEstoque, 10)
            loc_cEmpresa = PADR(THIS.this_cEmpEstoque,     3)
            loc_cGrupo   = PADR(THIS.this_cGruposEstoque,  10)
            loc_cProduto = PADR(THIS.this_cProdutoEstoque, 14)
            loc_dData    = THIS.this_dDataEstoque
            loc_pData    = IIF(EMPTY(loc_dData), CTOD('01/01/1900'), loc_dData)

            DO CASE
                CASE !EMPTY(loc_cEmpresa) .AND. !EMPTY(loc_cGrupo) .AND. !EMPTY(loc_cEstoque)
                    loc_cWhere = "EmpGruEsts = '" + loc_cEmpresa + loc_cGrupo + loc_cEstoque + "' "
                CASE EMPTY(loc_cEmpresa) .AND. EMPTY(loc_cGrupo) .AND. EMPTY(loc_cEstoque)
                    loc_cWhere = ""
                OTHERWISE
                    loc_cEmpIni = IIF(EMPTY(loc_cEmpresa), SPACE(3),  loc_cEmpresa)
                    loc_cGruIni = IIF(EMPTY(loc_cGrupo),   SPACE(10), loc_cGrupo)
                    loc_cEstIni = IIF(EMPTY(loc_cEstoque),  SPACE(10), loc_cEstoque)
                    loc_cEmpFin = IIF(EMPTY(loc_cEmpresa), REPLICATE(CHR(254), 3),  loc_cEmpresa)
                    loc_cGruFin = IIF(EMPTY(loc_cGrupo),   REPLICATE(CHR(254), 10), loc_cGrupo)
                    loc_cEstFin = IIF(EMPTY(loc_cEstoque),  REPLICATE(CHR(254), 10), loc_cEstoque)
                    loc_cWhere  = "EmpGruEsts Between '" + ;
                                  loc_cEmpIni + loc_cGruIni + loc_cEstIni + "' And '" + ;
                                  loc_cEmpFin + loc_cGruFin + loc_cEstFin + "' "
            ENDCASE

            loc_cWhere = IIF(!EMPTY(loc_cProduto), ;
                IIF(!EMPTY(loc_cWhere), loc_cWhere + " And ", "") + ;
                " CPros = '" + ALLTRIM(loc_cProduto) + "' ", loc_cWhere)
            loc_cWhere = IIF(!EMPTY(loc_dData), ;
                IIF(!EMPTY(loc_cWhere), loc_cWhere + " And ", "") + ;
                " Datas >= " + FormatarDataSQL(loc_dData), loc_cWhere)
            loc_cWhere = IIF(!EMPTY(loc_cWhere), "Where " + loc_cWhere, "")

            loc_cQuery = "Select Distinct Emps, Grupos, Estos, Cpros, CodCors, CodTams, " + ;
                         "Space(20) as CidChaves From SigMvHst " + loc_cWhere

            DO WHILE .T.
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpEst') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpEst)", "Erro")
                    EXIT
                ENDIF

                SELECT TmpEst
                REPLACE ALL CidChaves WITH SYS(2015)+SYS(2015)
                INDEX ON CidChaves TAG CidChaves

                DO WHILE .T.
                    SELECT * FROM TmpEst INTO CURSOR Selecao
                    IF RECCOUNT('Selecao') = 0
                        EXIT
                    ENDIF

                    SELECT Selecao
                    loc_nReg       = RECCOUNT('Selecao')
                    loc_oProgConta = CREATEOBJECT('fwprogressbar', ;
                        'Recalculando Saldo do Estoque', loc_nReg)
                    loc_oProgConta.Titulo.FontBold = .T.
                    loc_oProgConta.Show

                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oProgConta.Update(.T.)

                        =fRecalculaP(Selecao.Emps, Selecao.Grupos, Selecao.Estos, ;
                                     Selecao.CPros, loc_pData, Selecao.CodCors, ;
                                     Selecao.CodTams, THIS.this_oDataMgr)
                        loc_lOk = fRecalculaP(.T., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF

                        SELECT TmpEst
                        IF SEEK(Selecao.CidChaves)
                            DELETE
                        ENDIF
                    ENDSCAN

                    loc_oProgConta.Complete(.T., .T.)
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF
                ENDDO

                loc_lSucesso = .T.
                EXIT
            ENDDO

            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarCusto(par_oForm)
    *  Recalcula custo de produtos via fRecalculaC
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cPro, loc_dDat, loc_cQuery
        LOCAL loc_llEmp, loc_nReg, loc_lOk, loc_oCusto, loc_lParou

        loc_lSucesso = .F.
        TRY
            loc_cEmp = PADR(THIS.this_cEmpCusto,    3)
            loc_cPro = PADR(THIS.this_cProdutoCusto, 14)
            loc_dDat = THIS.this_dDataCusto

            loc_cQuery = "Select Cemps From SigCdEmp " + ;
                         "Where Not Cemps = Space(3)" + ;
                         IIF(EMPTY(loc_cEmp), "", " And Cemps = '" + ALLTRIM(loc_cEmp) + "'")

            DO WHILE .T.
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalEmp') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalEmp)", "Erro")
                    EXIT
                ENDIF

                loc_cQuery = "Select Calccustos From SigCdPac"
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalParac') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalParac)", "Erro")
                    EXIT
                ENDIF
                loc_llEmp = (LocalParac.CalcCustos <> 1)

                loc_cQuery = "Select Cpros From SigCdPro " + ;
                             "Where Not Cpros = Space(14)" + ;
                             IIF(EMPTY(loc_cPro), "", " And Cpros = '" + ALLTRIM(loc_cPro) + "'")
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalPro2') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalPro2)", "Erro")
                    EXIT
                ENDIF

                loc_lParou = .F.
                SELECT LocalEmp
                SCAN
                    IF loc_llEmp
                        loc_cQuery = "Select Distinct Cpros From SigMvEst " + ;
                                     "Where Emps = " + EscaparSQL(ALLTRIM(LocalEmp.Cemps)) + " " + ;
                                     "And Not Cpros = Space(14)" + ;
                                     IIF(EMPTY(loc_cPro), "", " And Cpros = " + EscaparSQL(ALLTRIM(loc_cPro)) + " ")
                        IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalPro') < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (LocalPro)", "Erro")
                            loc_lParou = .T.
                            EXIT
                        ENDIF
                    ELSE
                        SELECT * FROM LocalPro2 INTO CURSOR LocalPro READWRITE
                    ENDIF

                    loc_nReg  = RECCOUNT('LocalPro')
                    loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                        'Preparando Arquivo de Rec' + CHR(225) + 'lculo do Custo de Produtos', ;
                        loc_nReg)
                    loc_oCusto.Titulo.FontBold = .T.
                    loc_oCusto.Show

                    SELECT LocalPro
                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oCusto.SubTitulo.Caption = "Empresa : " + LocalEmp.Cemps + ;
                                                        " - Produto : " + LocalPro.CPros
                        loc_oCusto.Update(.T.)

                        =fRecalculaC(LocalEmp.Cemps, LocalPro.CPros, loc_dDat, THIS.this_oDataMgr)
                        loc_lOk = fRecalculaC(.T., .T., .F., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                    ENDSCAN

                    loc_oCusto.Complete(.T., .T.)

                    IF USED("LocalPro")
                        USE IN LocalPro
                    ENDIF
                    IF !loc_llEmp
                        EXIT
                    ENDIF
                ENDSCAN

                IF USED("LocalEmp")
                    USE IN LocalEmp
                ENDIF
                IF USED("LocalPro2")
                    USE IN LocalPro2
                ENDIF
                IF USED("LocalParac")
                    USE IN LocalParac
                ENDIF

                IF !loc_lParou
                    loc_lSucesso = .T.
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarUltimaCompra(par_oForm)
    *  Reconstroi SigOpClU e atualiza SigCdCli/SigCdPro com ultima compra
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cPro, loc_dDat, loc_cSql
        LOCAL loc_nReg, loc_oCusto, loc_cConta, loc_lOk
        LOCAL loc_lnCotaCentral, loc_lnCotaOperac, loc_lnValorCentral, loc_lnValor
        LOCAL loc_cMoeda, loc_ldData, loc_cUpDate

        loc_lSucesso = .F.
        TRY
            *-- Limpa cursor principal de ultima compra
            IF USED("CrSigOpClU")
                SELECT CrSigOpClU
                ZAP
            ENDIF

            loc_cEmp = PADR(THIS.this_cEmpCompra,    3)
            loc_cPro = PADR(THIS.this_cProdutoCompra, 14)
            loc_dDat = THIS.this_dDataCompra

            DO WHILE .T.
                *-- Seleciona movimentos de cabecalho com operacoes de compra
                loc_cSql = "Select a.datas, a.Emps, a.Dopes, a.Numes, a.EmpDopNums, " + ;
                           "a.Valos, a.Contads, a.ContaOs, " + ;
                           "c.GerGdmis, c.atuCompras, c.TpGdmis, b.cOpers, b.cmoes " + ;
                           "From SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                           "Where a.Dopes = b.Dopes And b.TipoOps = c.Codigos And " + ;
                           "((c.GerGdmis = 1 And c.TpGdmis = 1) Or " + ;
                           "(c.GerGdmis = 2 And c.AtuCompras = 1)) " + ;
                           IIF(!EMPTY(loc_dDat), "And a.Datas >= " + FormatarDataSQL(loc_dDat) + " ", "") + ;
                           IIF(!EMPTY(loc_cEmp), "And a.Emps = '" + ALLTRIM(loc_cEmp) + "' ", "")
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'TprMvCab') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TprMvCab)", "Erro")
                    EXIT
                ENDIF

                *-- Seleciona itens dos movimentos de compra por produto
                loc_cSql = "Select Emps, Dopes, Numes, EmpDopNums, Cpros, Units, Moedas " + ;
                           "From SigMvItn " + ;
                           "Where EmpDopNums in (" + ;
                           "Select EmpDopNums From SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                           "Where a.Dopes = b.Dopes And b.TipoOps = c.Codigos And " + ;
                           "c.GerGdmis = 2 And c.AtuCompras = 1 " + ;
                           IIF(!EMPTY(loc_dDat), "And a.Datas >= " + FormatarDataSQL(loc_dDat) + " ", "") + ;
                           IIF(!EMPTY(loc_cEmp), "And a.Emps = '" + ALLTRIM(loc_cEmp) + "' ", "") + ;
                           ") "
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'crTpmMvItn') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (crTpmMvItn)", "Erro")
                    EXIT
                ENDIF

                *-- Carrega registros existentes em SigOpClU para verificar duplicidade
                loc_cSql = "Select EmpDopNums From SigOpClU"
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocCalcU') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocCalcU)", "Erro")
                    EXIT
                ENDIF

                SELECT LocCalcU
                INDEX ON EmpDopNums TAG EmpDopNums
                SELECT TprMvCab
                INDEX ON EmpDopNums TAG EmpDopNums
                SELECT crTpmMvItn
                INDEX ON EmpDopNums TAG EmpDopNums

                loc_nReg  = RECCOUNT('TprMvCab')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Preparando Arquivo de Atualiza' + CHR(231) + CHR(227) + ;
                    'o da Ultima Compra', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT TprMvCab
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = TprMvCab.Emps + " " + ;
                        TprMvCab.Dopes + " " + STR(TprMvCab.Numes, 6)
                    loc_oCusto.Update(.T.)

                    IF SEEK(TprMvCab.EmpDopNums, 'LocCalcU', 'EmpdopNums')
                        LOOP
                    ENDIF

                    *-- Tipo 1: movimento de conta corrente
                    IF (TprMvCab.GerGdmis = 1 .AND. TprMvCab.TpGdmis = 1)
                        loc_cConta = IIF(TprMvCab.Copers = 1, TprMvCab.Contads, TprMvCab.Contaos)

                        IF USED("crSigCdPam") .AND. TprMvCab.CMoes # crSigCdPam.MoeCentral
                            loc_lnCotaCentral  = fBuscarCotacao(crSigCdPam.MoeCentral, ;
                                                     TprMvCab.Datas, THIS.this_oDataMgr)
                            loc_lnCotaOperac   = fBuscarCotacao(TprMvCab.CMoes, ;
                                                     TprMvCab.Datas, THIS.this_oDataMgr)
                            loc_lnValorCentral = ROUND(TprMvCab.Valos * loc_lnCotaOperac / ;
                                                       loc_lnCotaCentral, 2)
                        ELSE
                            loc_lnValorCentral = TprMvCab.Valos
                        ENDIF

                        loc_ldData = TprMvCab.Datas
                        INSERT INTO CrSigOpClU ;
                            (Emps, Dopes, Numes, EmpdopNums, iclis, Valors, Datas, Cidchaves) ;
                            VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, ;
                                    TprMvCab.EmpdopNums, loc_cConta, loc_lnValorCentral, ;
                                    loc_ldData, fUniqueIds())
                    ENDIF

                    *-- Tipo 2: movimento de itens (produtos)
                    IF (TprMvCab.GerGdmis = 2 .AND. TprMvCab.AtuCompras = 1)
                        SELECT crTpmMvItn
                        =SEEK(TprMvCab.EmpDopNums)
                        SCAN WHILE EmpdopNums = TprMvCab.EmpDopNums
                            IF EMPTY(Cpros)
                                LOOP
                            ENDIF

                            loc_cSql = "Select Cpros, UltComps From SigCdPro " + ;
                                       "Where Cpros = '" + ALLTRIM(crTpmMvItn.Cpros) + "'"
                            IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'TmpPro') < 1
                                MsgErro("Falha na conex" + CHR(227) + "o (SigCdPro)", "Erro")
                                LOOP
                            ENDIF

                            loc_ldData  = TprMvCab.Datas
                            loc_lnValor = crTpmMvItn.Units
                            loc_cMoeda  = crTpmMvItn.Moedas

                            INSERT INTO CrSigOpClU ;
                                (Emps, Dopes, Numes, empDopNums, cpros, Valors, ;
                                 Datas, Moedas, Cidchaves) ;
                                VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, ;
                                        TprMvCab.EmpdopNums, crTpmMvItn.Cpros, loc_lnValor, ;
                                        loc_ldData, loc_cMoeda, fUniqueIds())
                        ENDSCAN
                    ENDIF
                ENDSCAN

                loc_oCusto.Complete(.T., .T.)

                *-- Persiste CrSigOpClU no banco
                IF !THIS.this_oDataMgr.Update('CrSigOpClU')
                    MsgErro("Falha na conex" + CHR(227) + "o (Update CrSigOpClU)", "Erro")
                    EXIT
                ENDIF
                THIS.this_oDataMgr.Commit()

                *-- Atualiza SigCdCli: ultima compra por cliente
                loc_cSql = "Select * From SigOpClU"
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'CsSelecao') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (CsSelecao)", "Erro")
                    EXIT
                ENDIF

                SELECT DISTINCT Iclis FROM CsSelecao INTO CURSOR SelecaoIclis

                loc_nReg  = RECCOUNT('SelecaoIclis')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Atualizando Valor da Ultima Compra Clientes ', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT SelecaoIclis
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = "Cliente " + SelecaoIclis.Iclis
                    loc_oCusto.Update(.T.)

                    loc_cConta = SelecaoIclis.Iclis

                    *-- Ultima compra pela data mais recente
                    loc_cSql = "Select Top 1 Iclis, Datas, Valors From SigOpClU " + ;
                               "Where Iclis = '" + ALLTRIM(loc_cConta) + "' Order by Datas Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Data)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_cUpDate = "Update SigCdCli Set UltComps = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", vUltComps = " + ;
                                  STR(IIF(RECCOUNT('LocalCalcU') = 0, 0, LocalCalcU.Valors), 12, 2) + ;
                                  " Where Iclis = '" + ALLTRIM(loc_cConta) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdCli)", "Erro")
                        LOOP
                    ENDIF

                    *-- Ultima compra pelo maior valor
                    loc_cSql = "Select Top 1 Iclis, Datas, Valors From SigOpClU " + ;
                               "Where Iclis = '" + ALLTRIM(loc_cConta) + "' Order by Valors Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Valor)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_cUpDate = "Update SigCdCli Set dtfats = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", mfats = " + ;
                                  STR(IIF(RECCOUNT('LocalCalcU') = 0, 0, LocalCalcU.Valors), 12, 2) + ;
                                  " Where Iclis = '" + ALLTRIM(loc_cConta) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdCli dtfats)", "Erro")
                        LOOP
                    ENDIF

                    THIS.this_oDataMgr.Commit()
                ENDSCAN

                *-- Atualiza SigCdPro: ultima compra por produto
                SELECT DISTINCT Cpros FROM CsSelecao INTO CURSOR SelecaoCpros

                loc_nReg  = RECCOUNT('SelecaoCpros')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Atualizando Valor da Ultima Compra Produtos', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT SelecaoCpros
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = "Produto " + SelecaoCpros.Cpros
                    loc_oCusto.Update(.T.)

                    loc_cSql = "Select Top 1 Cpros, Datas, Valors, Moedas From SigOpClU " + ;
                               "Where Cpros = '" + ALLTRIM(SelecaoCpros.Cpros) + "' " + ;
                               "Order by Datas Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Produto)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData  = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_lnValor = IIF(RECCOUNT('LocalCalcU') = 0, 0,     LocalCalcU.Valors)
                    loc_cMoeda  = IIF(RECCOUNT('LocalCalcU') = 0, "",    ALLTRIM(LocalCalcU.Moedas))

                    loc_cUpDate = "Update SigCdPro Set UltComps = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", vUltComps = " + STR(loc_lnValor, 12, 2) + ;
                                  ", mUltComps = '" + loc_cMoeda + "'" + ;
                                  " Where Cpros = '" + ALLTRIM(SelecaoCpros.Cpros) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdPro)", "Erro")
                        LOOP
                    ENDIF
                    THIS.this_oDataMgr.Commit()
                ENDSCAN

                loc_oCusto.Complete(.T., .T.)

                IF USED("TprMvCab")
                    USE IN TprMvCab
                ENDIF
                IF USED("crTpmMvItn")
                    USE IN crTpmMvItn
                ENDIF
                IF USED("LocCalcU")
                    USE IN LocCalcU
                ENDIF
                IF USED("CsSelecao")
                    USE IN CsSelecao
                ENDIF
                IF USED("SelecaoIclis")
                    USE IN SelecaoIclis
                ENDIF
                IF USED("SelecaoCpros")
                    USE IN SelecaoCpros
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

