# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NAVEGACAO-PAGINA] Metodo 'AlternarPagina' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2815 linhas total):

*-- Linhas 60 a 69:
60:                 ELSE
61:                     THIS.ConfigurarPageFrame()
62:                     THIS.ConfigurarPaginaLista()
63:                     THIS.pgf_4c_Principal.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
64:                     THIS.pgf_4c_Principal.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
65:                     THIS.ConfigurarPaginaDados()
66:                     THIS.TornarControlesVisiveis()
67:                     THIS.ConfigurarBINDEVENTs()
68:                     THIS.InicializarValores()
69:                     loc_lSucesso = .T.

*-- Linhas 86 a 104:
86:         loc_oPgf = THIS.pgf_4c_Principal
87: 
88:         loc_oPgf.PageCount = 2
89:         loc_oPgf.Top       = -29
90:         loc_oPgf.Left      = 0
91:         loc_oPgf.Width     = 1003
92:         loc_oPgf.Height    = 635
93:         loc_oPgf.TabIndex  = 1
94:         loc_oPgf.Tabs      = .T.
95: 
96:         loc_oPgf.Page1.Caption = "Filtro"
97:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98: 
99:         loc_oPgf.Page2.Caption = "Dados"
100:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:         loc_oPgf.Page2.Enabled = .F.
102: 
103:         loc_oPgf.Visible    = .T.
104:         loc_oPgf.ActivePage = 1

*-- Linhas 116 a 159:
116:         loc_oP1.AddObject("cnt_4c_Sombra", "Container")
117:         loc_oCnt = loc_oP1.cnt_4c_Sombra
118:         WITH loc_oCnt
119:             .Top         = 0
120:             .Left        = 0
121:             .Width       = 1100
122:             .Height      = 80
123:             .BorderWidth = 0
124:             .BackColor   = RGB(100,100,100)
125:             .AddObject("lbl_4c_Sombra", "Label")
126:             WITH .lbl_4c_Sombra
127:                 .FontBold      = .T.
128:                 .FontName      = "Tahoma"
129:                 .FontSize      = 18
130:                 .FontUnderline = .F.
131:                 .WordWrap      = .T.
132:                 .Alignment     = 0
133:                 .BackStyle     = 0
134:                 .AutoSize      = .F.
135:                 .Caption       = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB"
136:                 .Height        = 40
137:                 .Left          = 10
138:                 .Top           = 18
139:                 .Width         = THIS.Width
140:                 .ForeColor     = RGB(0,0,0)
141:             ENDWITH
142:             .AddObject("lbl_4c_Titulo", "Label")
143:             WITH .lbl_4c_Titulo
144:                 .FontBold   = .T.
145:                 .FontName   = "Tahoma"
146:                 .FontSize   = 18
147:                 .WordWrap   = .T.
148:                 .Alignment  = 0
149:                 .BackStyle  = 0
150:                 .AutoSize   = .F.
151:                 .Caption    = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB"
152:                 .Height     = 46
153:                 .Left       = 10
154:                 .Top        = 17
155:                 .Width      = THIS.Width
156:                 .ForeColor  = RGB(255,255,255)
157:             ENDWITH
158:         ENDWITH
159: 

*-- Linhas 167 a 296:
167:             .BorderStyle   = 0
168:             .Value         = 1
169:             .Height        = 85
170:             .Left          = 844
171:             .SpecialEffect = 1
172:             .Top           = -2
173:             .Width         = 160
174:             .TabIndex      = 12
175:             .BackColor     = RGB(240,240,240)
176:             .Themes        = .F.
177:             WITH .Command1
178:                 .Top           = 5
179:                 .Left          = 5
180:                 .Height        = 75
181:                 .Width         = 75
182:                 .FontBold      = .T.
183:                 .FontItalic    = .T.
184:                 .FontName      = "Tahoma"
185:                 .FontSize      = 8
186:                 .WordWrap      = .T.
187:                 .Picture       = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
188:                 .Caption       = "Processar"
189:                 .MousePointer  = 15
190:                 .SpecialEffect = 0
191:                 .ForeColor     = RGB(90,90,90)
192:                 .BackColor     = RGB(255,255,255)
193:                 .Themes        = .F.
194:                 .Name          = "btnProcessar"
195:             ENDWITH
196:             WITH .Command2
197:                 .Top           = 5
198:                 .Left          = 80
199:                 .Height        = 75
200:                 .Width         = 75
201:                 .FontBold      = .T.
202:                 .FontItalic    = .T.
203:                 .FontName      = "Tahoma"
204:                 .FontSize      = 8
205:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
206:                 .Cancel        = .T.
207:                 .Caption       = "Encerrar"
208:                 .ToolTipText   = "[ESC] Encerrar"
209:                 .ForeColor     = RGB(90,90,90)
210:                 .BackColor     = RGB(255,255,255)
211:                 .Themes        = .F.
212:                 .Name          = "btnsair"
213:             ENDWITH
214:         ENDWITH
215: 
216:         *-- Label "Operacoes :"
217:         loc_oP1.AddObject("lbl_4c_LblOper", "Label")
218:         WITH loc_oP1.lbl_4c_LblOper
219:             .AutoSize   = .T.
220:             .FontBold   = .T.
221:             .FontName   = "Tahoma"
222:             .FontSize   = 8
223:             .BackStyle  = 0
224:             .Caption    = "Oper" + CHR(92) + CHR(60) + "a" + CHR(231) + CHR(245) + "es :"
225:             .Height     = 15
226:             .Left       = 279
227:             .Top        = 96
228:             .Width      = 68
229:             .TabIndex   = 13
230:             .ForeColor  = RGB(90,90,90)
231:         ENDWITH
232: 
233:         *-- OptionGroup processados
234:         loc_oP1.AddObject("opt_4c_Processados", "OptionGroup")
235:         WITH loc_oP1.opt_4c_Processados
236:             .BackStyle   = 0
237:             .BorderStyle = 0
238:             .ButtonCount = 2
239:             .Height      = 19
240:             .Left        = 344
241:             .Top         = 95
242:             .Width       = 235
243:             .Value       = 1
244:             .TabIndex    = 1
245:             WITH .Option1
246:                 .BackStyle = 0
247:                 .Caption   = "N" + CHR(227) + "o Processadas"
248:                 .Left      = 5
249:                 .Top       = 2
250:                 .AutoSize  = .T.
251:                 .ForeColor = RGB(90,90,90)
252:             ENDWITH
253:             WITH .Option2
254:                 .FontName  = "Tahoma"
255:                 .FontSize  = 8
256:                 .BackStyle = 0
257:                 .Caption   = "J" + CHR(225) + " Processadas"
258:                 .Left      = 126
259:                 .Top       = 2
260:                 .AutoSize  = .T.
261:                 .ForeColor = RGB(90,90,90)
262:             ENDWITH
263:         ENDWITH
264: 
265:         *-- Label "Empresa :"
266:         loc_oP1.AddObject("lbl_4c_LblEmpresa", "Label")
267:         WITH loc_oP1.lbl_4c_LblEmpresa
268:             .AutoSize   = .T.
269:             .FontName   = "Tahoma"
270:             .FontSize   = 8
271:             .BackStyle  = 0
272:             .Caption    = "Empresa :"
273:             .Left       = 297
274:             .Top        = 123
275:             .Width      = 50
276:             .TabIndex   = 14
277:             .ForeColor  = RGB(90,90,90)
278:         ENDWITH
279: 
280:         *-- TextBox Codigo Empresa
281:         loc_oP1.AddObject("txt_4c_CdEmpresa", "TextBox")
282:         WITH loc_oP1.txt_4c_CdEmpresa
283:             .FontName      = "Tahoma"
284:             .FontSize      = 8
285:             .Format        = "K"
286:             .Height        = 23
287:             .Left          = 349
288:             .MaxLength     = 3
289:             .SpecialEffect = 1
290:             .TabIndex      = 2
291:             .Top           = 120
292:             .Width         = 31
293:             .Value         = ""
294:             .ForeColor     = RGB(0,0,0)
295:             .BorderColor   = RGB(100,100,100)
296:         ENDWITH

*-- Linhas 302 a 329:
302:             .FontSize      = 8
303:             .Format        = "K"
304:             .Height        = 23
305:             .Left          = 383
306:             .MaxLength     = 40
307:             .SpecialEffect = 1
308:             .TabIndex      = 3
309:             .Top           = 120
310:             .Width         = 290
311:             .Value         = ""
312:             .ForeColor     = RGB(0,0,0)
313:             .BorderColor   = RGB(100,100,100)
314:         ENDWITH
315: 
316:         *-- Label "Periodo :"
317:         loc_oP1.AddObject("lbl_4c_LblPeriodo", "Label")
318:         WITH loc_oP1.lbl_4c_LblPeriodo
319:             .AutoSize   = .T.
320:             .FontName   = "Tahoma"
321:             .FontSize   = 8
322:             .Caption    = "Per" + CHR(237) + "odo :"
323:             .Left       = 302
324:             .Top        = 151
325:             .Width      = 45
326:             .TabIndex   = 16
327:             .BackStyle  = 0
328:             .ForeColor  = RGB(90,90,90)
329:         ENDWITH

*-- Linhas 337 a 361:
337:             .Format        = "KD"
338:             .BorderStyle   = 1
339:             .Value         = {}
340:             .Left          = 349
341:             .SpecialEffect = 1
342:             .TabIndex      = 4
343:             .Top           = 148
344:             .Width         = 80
345:             .ForeColor     = RGB(0,0,0)
346:             .BorderColor   = RGB(100,100,100)
347:         ENDWITH
348: 
349:         *-- Label "ate"
350:         loc_oP1.AddObject("lbl_4c_LblAte", "Label")
351:         WITH loc_oP1.lbl_4c_LblAte
352:             .AutoSize  = .T.
353:             .FontName  = "Tahoma"
354:             .Caption   = "at" + CHR(233)
355:             .Left      = 434
356:             .Top       = 151
357:             .TabIndex  = 17
358:             .BackStyle = 0
359:             .ForeColor = RGB(90,90,90)
360:         ENDWITH
361: 

*-- Linhas 368 a 379:
368:             .Format        = "KD"
369:             .BorderStyle   = 1
370:             .Value         = {}
371:             .Left          = 457
372:             .SpecialEffect = 1
373:             .TabIndex      = 5
374:             .Top           = 148
375:             .Width         = 80
376:             .ForeColor     = RGB(0,0,0)
377:             .BorderColor   = RGB(100,100,100)
378:         ENDWITH
379: 

*-- Linhas 385 a 428:
385:             .BackStyle   = 0
386:             .BorderStyle = 0
387:             .Height      = 25
388:             .Left        = 544
389:             .Top         = 146
390:             .Width       = 168
391:             .Value       = 1
392:             .TabIndex    = 6
393:             WITH .Option1
394:                 .BackStyle = 0
395:                 .Caption   = "Vencimento"
396:                 .Height    = 15
397:                 .Left      = 5
398:                 .Top       = 5
399:                 .Width     = 73
400:                 .AutoSize  = .T.
401:                 .ForeColor = RGB(90,90,90)
402:             ENDWITH
403:             WITH .Option2
404:                 .FontName  = "Tahoma"
405:                 .FontSize  = 8
406:                 .BackStyle = 0
407:                 .Caption   = "Emiss" + CHR(227) + "o"
408:                 .Left      = 96
409:                 .Top       = 5
410:                 .AutoSize  = .T.
411:                 .ForeColor = RGB(90,90,90)
412:             ENDWITH
413:         ENDWITH
414: 
415:         *-- Label "Banco :"
416:         loc_oP1.AddObject("lbl_4c_LblBanco", "Label")
417:         WITH loc_oP1.lbl_4c_LblBanco
418:             .AutoSize   = .T.
419:             .FontName   = "Tahoma"
420:             .FontSize   = 8
421:             .Caption    = "Banco :"
422:             .Left       = 309
423:             .Top        = 180
424:             .Width      = 38
425:             .TabIndex   = 18
426:             .BackStyle  = 0
427:             .ForeColor  = RGB(90,90,90)
428:         ENDWITH

*-- Linhas 434 a 446:
434:             .FontSize      = 8
435:             .Format        = "K"
436:             .Height        = 23
437:             .Left          = 349
438:             .MaxLength     = 10
439:             .SpecialEffect = 1
440:             .TabIndex      = 7
441:             .Top           = 176
442:             .Width         = 79
443:             .Value         = ""
444:             .ForeColor     = RGB(0,0,0)
445:             .BorderColor   = RGB(100,100,100)
446:         ENDWITH

*-- Linhas 452 a 479:
452:             .FontSize      = 8
453:             .Format        = "K"
454:             .Height        = 23
455:             .Left          = 430
456:             .MaxLength     = 40
457:             .SpecialEffect = 1
458:             .TabIndex      = 8
459:             .Top           = 176
460:             .Width         = 290
461:             .Value         = ""
462:             .ForeColor     = RGB(0,0,0)
463:             .BorderColor   = RGB(100,100,100)
464:         ENDWITH
465: 
466:         *-- Label "Titulo Banco :"
467:         loc_oP1.AddObject("lbl_4c_LblTitBan", "Label")
468:         WITH loc_oP1.lbl_4c_LblTitBan
469:             .AutoSize   = .T.
470:             .FontName   = "Tahoma"
471:             .FontSize   = 8
472:             .Caption    = "T" + CHR(237) + "tulo Banco : "
473:             .Left       = 280
474:             .Top        = 206
475:             .Width      = 70
476:             .Height     = 15
477:             .TabIndex   = 19
478:             .BackStyle  = 0
479:             .ForeColor  = RGB(90,90,90)

*-- Linhas 486 a 514:
486:             .FontSize      = 8
487:             .Format        = "K"
488:             .Height        = 23
489:             .Left          = 348
490:             .MaxLength     = 12
491:             .SpecialEffect = 1
492:             .TabIndex      = 9
493:             .Top           = 203
494:             .Width         = 94
495:             .Value         = ""
496:             .ForeColor     = RGB(0,0,0)
497:             .BorderColor   = RGB(100,100,100)
498:         ENDWITH
499: 
500:         *-- Label "Operacao :" (acima do grid SigCdOpe)
501:         loc_oP1.AddObject("lbl_4c_LblOperGrid", "Label")
502:         WITH loc_oP1.lbl_4c_LblOperGrid
503:             .AutoSize   = .T.
504:             .FontName   = "Tahoma"
505:             .FontSize   = 8
506:             .BackStyle  = 0
507:             .Caption    = "Opera" + CHR(231) + CHR(227) + "o :"
508:             .Left       = 291
509:             .Top        = 234
510:             .TabIndex   = 20
511:             .ForeColor  = RGB(90,90,90)
512:         ENDWITH
513: 
514:         *-- Grid de Operacoes SigCdOpe (grdope)

*-- Linhas 521 a 543:
521:             .DeleteMark        = .F.
522:             .GridLines         = 3
523:             .Height            = 344
524:             .Left              = 350
525:             .Panel             = 1
526:             .ScrollBars        = 2
527:             .SplitBar          = .F.
528:             .TabIndex          = 10
529:             .Top               = 232
530:             .Width             = 202
531:             .GridLineColor     = RGB(238,238,238)
532:             .Themes            = .F.
533:             .Column1.Width     = 18
534:             .Column1.Movable   = .F.
535:             .Column1.Resizable = .F.
536:             .Column1.Sparse    = .F.
537:             .Column1.AddObject("Check1", "CheckBox")
538:             .Column1.Check1.Caption = ""
539:             .Column1.Check1.Value   = 0
540:             .Column1.CurrentControl = "Check1"
541:             .Column2.Width     = 150
542:             .Column2.Movable   = .F.
543:             .Column2.Resizable = .F.

*-- Linhas 554 a 590:
554:             .BorderStyle   = 0
555:             .Value         = 0
556:             .Height        = 91
557:             .Left          = 563
558:             .SpecialEffect = 1
559:             .Top           = 315
560:             .Width         = 50
561:             .TabIndex      = 11
562:             .BackColor     = RGB(240,240,240)
563:             .Themes        = .F.
564:             WITH .Command1
565:                 .Top         = 5
566:                 .Left        = 5
567:                 .Height      = 40
568:                 .Width       = 40
569:                 .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
570:                 .Caption     = ""
571:                 .ToolTipText = "Marcar tudo"
572:                 .ForeColor   = RGB(36,84,155)
573:                 .BackColor   = RGB(255,255,255)
574:                 .Themes      = .F.
575:                 .Name        = "btnmarca"
576:             ENDWITH
577:             WITH .Command2
578:                 .Top         = 46
579:                 .Left        = 5
580:                 .Height      = 40
581:                 .Width       = 40
582:                 .FontName    = "Verdana"
583:                 .FontSize    = 8
584:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
585:                 .Caption     = ""
586:                 .ToolTipText = "Desmarcar tudo"
587:                 .ForeColor   = RGB(36,84,155)
588:                 .BackColor   = RGB(255,255,255)
589:                 .Themes      = .F.
590:                 .Name        = "btndesmarca"

*-- Linhas 608 a 645:
608:             .ReadOnly      = .T.
609:             .SpecialEffect = 0
610:             .Height        = 16
611:             .Left          = 370
612:             .Top           = 14
613:             .Width         = 17
614:             .TabStop       = .F.
615:             .Value         = ""
616:         ENDWITH
617: 
618:         *-- Label descricao EndErro
619:         loc_oP2.AddObject("lbl_4c_EndErroInfo", "Label")
620:         WITH loc_oP2.lbl_4c_EndErroInfo
621:             .AutoSize  = .F.
622:             .FontName  = "Tahoma"
623:             .FontSize  = 7
624:             .BackStyle = 0
625:             .Caption   = "Endere" + CHR(231) + "os com tamanho maior que 40 caracteres"
626:             .Height    = 15
627:             .Left      = 390
628:             .Top       = 15
629:             .Width     = 238
630:             .ForeColor = RGB(255,0,0)
631:         ENDWITH
632: 
633:         *-- Label "Protestar apos :"
634:         loc_oP2.AddObject("lbl_4c_Protestar", "Label")
635:         WITH loc_oP2.lbl_4c_Protestar
636:             .Caption   = "Protestar ap" + CHR(243) + "s :"
637:             .Enabled   = .F.
638:             .Height    = 15
639:             .Left      = 370
640:             .Top       = 103
641:             .Width     = 80
642:             .TabIndex  = 5
643:             .BackStyle = 0
644:             .ForeColor = RGB(90,90,90)
645:         ENDWITH

*-- Linhas 653 a 678:
653:             .Height            = 24
654:             .KeyboardHighValue = 99
655:             .KeyboardLowValue  = 0
656:             .Left              = 451
657:             .SpecialEffect     = 1
658:             .SpinnerHighValue  = 99
659:             .SpinnerLowValue   = 0
660:             .TabIndex          = 7
661:             .Top               = 98
662:             .Width             = 45
663:             .Value             = 5
664:         ENDWITH
665: 
666:         *-- Label "dias"
667:         loc_oP2.AddObject("lbl_4c_Dias", "Label")
668:         WITH loc_oP2.lbl_4c_Dias
669:             .Caption   = "dias"
670:             .Enabled   = .F.
671:             .Height    = 15
672:             .Left      = 501
673:             .Top       = 103
674:             .Width     = 21
675:             .TabIndex  = 6
676:             .BackStyle = 0
677:             .ForeColor = RGB(90,90,90)
678:         ENDWITH

*-- Linhas 686 a 709:
686:             .AllowRowSizing    = .F.
687:             .DeleteMark        = .F.
688:             .Height            = 401
689:             .Left              = 7
690:             .Panel             = 1
691:             .RecordMark        = .F.
692:             .ScrollBars        = 2
693:             .SplitBar          = .F.
694:             .TabIndex          = 1
695:             .Top               = 134
696:             .Width             = 981
697:             .GridLineColor     = RGB(238,238,238)
698:             .Themes            = .F.
699:             .Column1.Width     = 18
700:             .Column1.Movable   = .F.
701:             .Column1.Resizable = .F.
702:             .Column1.Sparse    = .F.
703:             .Column1.AddObject("Check1", "CheckBox")
704:             .Column1.Check1.Caption = ""
705:             .Column1.Check1.Value   = 0
706:             .Column1.CurrentControl = "Check1"
707:             .Column2.Width     = 65
708:             .Column2.Movable   = .F.
709:             .Column2.Resizable = .F.

*-- Linhas 744 a 770:
744:             .BorderStyle   = 0
745:             .Value         = 0
746:             .Height        = 85
747:             .Left          = 917
748:             .SpecialEffect = 1
749:             .Top           = -3
750:             .Width         = 85
751:             .TabIndex      = 2
752:             .BackColor     = RGB(240,240,240)
753:             .Themes        = .F.
754:             WITH .Command1
755:                 .Top           = 5
756:                 .Left          = 5
757:                 .Height        = 75
758:                 .Width         = 75
759:                 .FontBold      = .T.
760:                 .FontItalic    = .T.
761:                 .FontName      = "Tahoma"
762:                 .FontSize      = 8
763:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
764:                 .Cancel        = .T.
765:                 .Caption       = "Encerrar"
766:                 .ToolTipText   = "[ESC] Encerrar"
767:                 .ForeColor     = RGB(90,90,90)
768:                 .BackColor     = RGB(255,255,255)
769:                 .Themes        = .F.
770:                 .Name          = "btnsair"

*-- Linhas 781 a 838:
781:             .BorderStyle   = 0
782:             .Value         = 0
783:             .Height        = 85
784:             .Left          = 692
785:             .SpecialEffect = 1
786:             .Top           = -3
787:             .Width         = 235
788:             .TabIndex      = 3
789:             .BackColor     = RGB(240,240,240)
790:             .Themes        = .F.
791:             WITH .Command1
792:                 .Top       = 5
793:                 .Left      = 5
794:                 .Height    = 75
795:                 .Width     = 75
796:                 .FontBold  = .T.
797:                 .FontItalic = .T.
798:                 .FontName  = "Tahoma"
799:                 .FontSize  = 8
800:                 .Picture   = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
801:                 .Caption   = "Gerar CNAB"
802:                 .ForeColor = RGB(90,90,90)
803:                 .BackColor = RGB(255,255,255)
804:                 .Themes    = .F.
805:                 .Name      = "btncnab"
806:             ENDWITH
807:             WITH .Command2
808:                 .Top       = 5
809:                 .Left      = 80
810:                 .Height    = 75
811:                 .Width     = 75
812:                 .FontBold  = .T.
813:                 .FontItalic = .T.
814:                 .FontName  = "Tahoma"
815:                 .FontSize  = 8
816:                 .Picture   = gc_4c_CaminhoIcones + "geral_video_60.jpg"
817:                 .Caption   = "Relat" + CHR(243) + "rio"
818:                 .ForeColor = RGB(90,90,90)
819:                 .BackColor = RGB(255,255,255)
820:                 .Themes    = .F.
821:                 .Name      = "btnrelatorio"
822:             ENDWITH
823:             WITH .Command3
824:                 .Top       = 5
825:                 .Left      = 155
826:                 .Height    = 75
827:                 .Width     = 75
828:                 .FontBold  = .T.
829:                 .FontItalic = .T.
830:                 .FontName  = "Tahoma"
831:                 .FontSize  = 8
832:                 .Picture   = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
833:                 .Caption   = "Boleto"
834:                 .Enabled   = .F.
835:                 .ForeColor = RGB(90,90,90)
836:                 .BackColor = RGB(255,255,255)
837:                 .Themes    = .F.
838:                 .Name      = "btnBoleto"

*-- Linhas 848 a 884:
848:             .BorderStyle   = 0
849:             .Value         = 0
850:             .Height        = 50
851:             .Left          = 7
852:             .SpecialEffect = 1
853:             .Top           = 543
854:             .Width         = 92
855:             .TabIndex      = 4
856:             .BackColor     = RGB(240,240,240)
857:             .Themes        = .F.
858:             WITH .Command1
859:                 .Top         = 5
860:                 .Left        = 7
861:                 .Height      = 40
862:                 .Width       = 40
863:                 .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
864:                 .Caption     = ""
865:                 .ToolTipText = "Marcar tudo"
866:                 .ForeColor   = RGB(36,84,155)
867:                 .BackColor   = RGB(255,255,255)
868:                 .Themes      = .F.
869:                 .Name        = "btnmarca"
870:             ENDWITH
871:             WITH .Command2
872:                 .Top         = 5
873:                 .Left        = 47
874:                 .Height      = 40
875:                 .Width       = 40
876:                 .FontName    = "Verdana"
877:                 .FontSize    = 8
878:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
879:                 .Caption     = ""
880:                 .ToolTipText = "Desmarcar tudo"
881:                 .ForeColor   = RGB(36,84,155)
882:                 .BackColor   = RGB(255,255,255)
883:                 .Themes      = .F.
884:                 .Name        = "btndesmarca"

*-- Linhas 897 a 932:
897: 
898:         loc_oP1 = loc_oPgf.Page1
899:         loc_oP1.cnt_4c_Sombra.Visible               = .T.
900:         loc_oP1.cnt_4c_Sombra.lbl_4c_Sombra.Visible = .T.
901:         loc_oP1.cnt_4c_Sombra.lbl_4c_Titulo.Visible = .T.
902:         loc_oP1.cgp_4c_Filtro.Visible               = .T.
903:         loc_oP1.lbl_4c_LblOper.Visible              = .T.
904:         loc_oP1.opt_4c_Processados.Visible           = .T.
905:         loc_oP1.lbl_4c_LblEmpresa.Visible            = .T.
906:         loc_oP1.txt_4c_CdEmpresa.Visible             = .T.
907:         loc_oP1.txt_4c_DsEmpresa.Visible             = .T.
908:         loc_oP1.lbl_4c_LblPeriodo.Visible            = .T.
909:         loc_oP1.txt_4c_Datai.Visible                 = .T.
910:         loc_oP1.lbl_4c_LblAte.Visible                = .T.
911:         loc_oP1.txt_4c_Dataf.Visible                 = .T.
912:         loc_oP1.opt_4c_Periodo.Visible               = .T.
913:         loc_oP1.lbl_4c_LblBanco.Visible              = .T.
914:         loc_oP1.txt_4c_CdConta.Visible               = .T.
915:         loc_oP1.txt_4c_DsConta.Visible               = .T.
916:         loc_oP1.lbl_4c_LblTitBan.Visible             = .T.
917:         loc_oP1.txt_4c_TitBan.Visible                = .T.
918:         loc_oP1.lbl_4c_LblOperGrid.Visible           = .T.
919:         loc_oP1.grd_4c_Operacoes.Visible             = .T.
920:         loc_oP1.cgp_4c_MarcaOpe.Visible              = .T.
921: 
922:         loc_oP2 = loc_oPgf.Page2
923:         loc_oP2.txt_4c_EndErroInd.Visible            = .T.
924:         loc_oP2.lbl_4c_EndErroInfo.Visible           = .T.
925:         loc_oP2.lbl_4c_Protestar.Visible             = .T.
926:         loc_oP2.spn_4c_Dias.Visible                  = .T.
927:         loc_oP2.lbl_4c_Dias.Visible                  = .T.
928:         loc_oP2.grd_4c_Dados.Visible                 = .T.
929:         loc_oP2.cgp_4c_Encerrar.Visible              = .T.
930:         loc_oP2.cgp_4c_Acoes.Visible                 = .T.
931:         loc_oP2.cgp_4c_MarcaDados.Visible            = .T.
932:     ENDPROC

*-- Linhas 982 a 991:
982:             loc_oGrd.RecordSource           = "cursor_4c_Operacoes"
983:             loc_oGrd.Column1.ControlSource  = "cursor_4c_Operacoes.marca"
984:             loc_oGrd.Column2.ControlSource  = "cursor_4c_Operacoes.Dopes"
985:             loc_oGrd.Column1.Header1.Caption = ""
986:             loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
987:             loc_oGrd.Column2.Header1.Alignment = 2
988:             loc_oGrd.Refresh()
989:         ENDIF
990: 
991:         IF THIS.this_oBusinessObject.CarregarFormasPagto()

*-- Linhas 1415 a 1440:
1415:         loc_oGrd.Column6.ControlSource  = "cursor_4c_Filtro.fpags"
1416:         loc_oGrd.Column7.ControlSource  = "cursor_4c_Filtro.valos"
1417:         loc_oGrd.Column8.ControlSource  = "cursor_4c_Filtro.titulos"
1418:         loc_oGrd.Column1.Header1.Caption = ""
1419:         loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1420:         loc_oGrd.Column3.Header1.Caption = "C" + CHR(243) + "digo"
1421:         loc_oGrd.Column4.Header1.Caption = "Cliente"
1422:         loc_oGrd.Column5.Header1.Caption = "Vencimento"
1423:         loc_oGrd.Column6.Header1.Caption = "Forma Pagto"
1424:         loc_oGrd.Column7.Header1.Caption = "Valor"
1425:         loc_oGrd.Column8.Header1.Caption = "T" + CHR(237) + "tulo"
1426:         loc_oGrd.SetAll("DynamicForeColor", "IIF(cursor_4c_Filtro.EndErro=1,RGB(255,0,0),RGB(0,0,0))", "Column")
1427:         loc_oGrd.Refresh()
1428: 
1429:         *-- Habilita boleto apenas quando mostrando "Ja Processados"
1430:         loc_oP2.cgp_4c_Acoes.Command3.Enabled = !loc_lNaoProc
1431: 
1432:         *-- Ativa protestar dias
1433:         loc_oP2.lbl_4c_Protestar.Enabled = .T.
1434:         loc_oP2.spn_4c_Dias.Enabled      = .T.
1435:         loc_oP2.lbl_4c_Dias.Enabled      = .T.
1436: 
1437:         *-- Muda para page2
1438:         loc_oP1.Enabled = .F.
1439:         loc_oP2.Enabled = .T.
1440:         THIS.pgf_4c_Principal.ActivePage = 2


### BO (C:\4c\projeto\app\classes\SIGPRCNBBO.prg):
*==============================================================================
* SIGPRCNBBO.prg - Business Object para Geracao de Arquivos CNAB
* Herda de: BusinessBase
* Tabela principal: SigPcOoL
* Chave primaria: cidchaves
*==============================================================================

DEFINE CLASS SIGPRCNBBO AS BusinessBase

    *-- Configuracao da tabela principal
    this_cTabela          = "SigPcOoL"
    this_cCampoChave      = "cidchaves"

    *--------------------------------------------------------------------------
    * Filtros da pagina pgfiltro
    *--------------------------------------------------------------------------
    this_cEmps            = ""    && Empresa selecionada char(3)
    this_cDsEmpresa       = ""    && Razao social da empresa char(40)
    this_dDatIni          = {}    && Data inicial do periodo
    this_dDatFim          = {}    && Data final do periodo
    this_cCdCarConta      = ""    && Codigo da conta bancaria char(10)
    this_cDsCarConta      = ""    && Descricao da conta bancaria char(40)
    this_cTitBan          = ""    && Titulo banco char(12)
    this_lNaoProcessadas  = .T.   && .T.=Nao processadas, .F.=Ja processadas
    this_nPeriodo         = 1     && 1=Vencimento, 2=Emissao
    this_nDiasProt        = 5     && Dias para protesto (spinner spndias)

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigPcOoL (schema confirmado)
    *--------------------------------------------------------------------------
    this_cTipos           = ""    && char(10) - tipo do processo ex: SIGPRCNB
    this_cDopes           = ""    && char(20) - codigo da operacao
    this_nNumes           = 0     && numeric(6,0) - numero do titulo
    this_cEmpDs           = ""    && char(3) - empresa destino
    this_cDopeDs          = ""    && char(20) - titulo/nosso numero (dopeds)
    this_nNumeDs          = 0     && numeric(11,0) - nosso numero sequencial (numeds)
    this_dDatas           = {}    && datetime NULL - data/hora do processamento
    this_cUsuars          = ""    && char(10) - usuario que processou
    this_cProdutos        = ""    && text NULL - conteudo do arquivo CNAB gerado
    this_cCidChaves       = ""    && char(20) PK - chave unica do registro
    this_cEdnDests        = ""    && char(29) - endereco destino
    this_cEmpDopNums      = ""    && char(29) - emps+dopes+numes (chave composta)
    this_cProcessos       = ""    && char(20) - tipo de arquivo ex: CNAB
    this_nNopers          = 0     && numeric(9,0) - numero da operacao

    *--------------------------------------------------------------------------
    * INIT - Configura tabela e chave; delega ao BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPcOoL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN DODEFAULT("SigPcOoL")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK do registro corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor de dados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTipos      = NVL(tipos,      "")
                THIS.this_cEmps       = NVL(emps,       "")
                THIS.this_cDopes      = NVL(dopes,      "")
                THIS.this_nNumes      = NVL(numes,      0)
                THIS.this_cEmpDs      = NVL(empds,      "")
                THIS.this_cDopeDs     = NVL(dopeds,     "")
                THIS.this_nNumeDs     = NVL(numeds,     0)
                THIS.this_dDatas      = NVL(datas,      {})
                THIS.this_cUsuars     = NVL(usuars,     "")
                THIS.this_cProdutos   = NVL(produtos,   "")
                THIS.this_cCidChaves  = NVL(cidchaves,  "")
                THIS.this_cEdnDests   = NVL(edndests,   "")
                THIS.this_cEmpDopNums = NVL(empdopnums, "")
                THIS.this_cProcessos  = NVL(processos,  "")
                THIS.this_nNopers     = NVL(nopers,     0)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(THIS.this_cEmps)
            MsgAviso("Empresa obrigat" + CHR(243) + "ria.")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(THIS.this_cDopes)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("C" + CHR(243) + "digo do t" + CHR(237) + "tulo obrigat" + CHR(243) + "rio.")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere registro de processamento na tabela SigPcOoL
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                IF EMPTY(THIS.this_cCidChaves)
                    THIS.this_cCidChaves = fUniqueIds()
                ENDIF
                loc_cSQL = "INSERT INTO SigPcOoL "
                loc_cSQL = loc_cSQL + "(tipos, emps, dopes, numes, empds, dopeds, numeds, datas, usuars, "
                loc_cSQL = loc_cSQL + "produtos, cidchaves, edndests, empdopnums, processos, nopers) "
                loc_cSQL = loc_cSQL + "VALUES ("
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cTipos)         + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmps)          + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDopes)         + ", "
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes)  + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmpDs)         + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDopeDs)        + ", "
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumeDs) + ", "
                loc_cSQL = loc_cSQL + "GETDATE(), "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cUsuars)        + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cProdutos)      + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cCidChaves)     + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEdnDests)      + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmpDopNums)    + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cProcessos)     + ", "
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers) + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de processamento na tabela SigPcOoL
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigPcOoL SET "
                loc_cSQL = loc_cSQL + "tipos = "      + EscaparSQL(THIS.this_cTipos)          + ", "
                loc_cSQL = loc_cSQL + "emps = "       + EscaparSQL(THIS.this_cEmps)           + ", "
                loc_cSQL = loc_cSQL + "dopes = "      + EscaparSQL(THIS.this_cDopes)          + ", "
                loc_cSQL = loc_cSQL + "numes = "      + FormatarNumeroSQL(THIS.this_nNumes)   + ", "
                loc_cSQL = loc_cSQL + "empds = "      + EscaparSQL(THIS.this_cEmpDs)          + ", "
                loc_cSQL = loc_cSQL + "dopeds = "     + EscaparSQL(THIS.this_cDopeDs)         + ", "
                loc_cSQL = loc_cSQL + "numeds = "     + FormatarNumeroSQL(THIS.this_nNumeDs)  + ", "
                loc_cSQL = loc_cSQL + "datas = GETDATE(), "
                loc_cSQL = loc_cSQL + "usuars = "     + EscaparSQL(THIS.this_cUsuars)         + ", "
                loc_cSQL = loc_cSQL + "produtos = "   + EscaparSQL(THIS.this_cProdutos)       + ", "
                loc_cSQL = loc_cSQL + "edndests = "   + EscaparSQL(THIS.this_cEdnDests)       + ", "
                loc_cSQL = loc_cSQL + "empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)     + ", "
                loc_cSQL = loc_cSQL + "processos = "  + EscaparSQL(THIS.this_cProcessos)      + ", "
                loc_cSQL = loc_cSQL + "nopers = "     + FormatarNumeroSQL(THIS.this_nNopers)
                loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigPcOoL (chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPcOoL WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes bancarias para grid de filtro
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            loc_cSQL = "SELECT dopes, CAST(0 AS bit) AS marca "
            loc_cSQL = loc_cSQL + "FROM SigCdOpe "
            loc_cSQL = loc_cSQL + "WHERE parcontas = 1 AND valpends = 1 "
            loc_cSQL = loc_cSQL + "ORDER BY dopes"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFormasPagto - Carrega formas de pagamento bancarias (SigOpFp)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFormasPagto()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_FormaPagto")
                USE IN cursor_4c_FormaPagto
            ENDIF
            loc_cSQL = "SELECT fpags, descrs, infos, situas, nbancos "
            loc_cSQL = loc_cSQL + "FROM SigOpFp "
            loc_cSQL = loc_cSQL + "WHERE situas IN ('R','A') AND infos = 'K' "
            loc_cSQL = loc_cSQL + "ORDER BY fpags"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FormaPagto") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTitulos - Busca titulos a cobrar para geracao do arquivo CNAB
    * par_cOpCodes: codigos de operacao p/ IN clause ex: "'OP1','OP2'"
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTitulos(par_cOpCodes)
        LOCAL loc_lResultado, loc_cSQL, loc_cPeriodo, loc_cMarca
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Filtro")
                USE IN cursor_4c_Filtro
            ENDIF
            IF THIS.this_nPeriodo = 1
                loc_cPeriodo = "SigMvPar.vencs BETWEEN " + ;
                    FormatarDataSQL(THIS.this_dDatIni) + " AND " + ;
                    FormatarDataSQL(THIS.this_dDatFim)
            ELSE
                loc_cPeriodo = "SigMvCcr.dtemis BETWEEN " + ;
                    FormatarDataSQL(THIS.this_dDatIni) + " AND " + ;
                    FormatarDataSQL(THIS.this_dDatFim)
            ENDIF
            IF THIS.this_lNaoProcessadas
                loc_cMarca = "NOT EXISTS (SELECT 1 FROM SigPcOoL "
                loc_cMarca = loc_cMarca + "WHERE SigPcOoL.empdopnums = SigMvPar.empdopnums "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.nopers = SigMvPar.nopers "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.processos = 'CNAB')"
            ELSE
                loc_cMarca = "EXISTS (SELECT 1 FROM SigPcOoL "
                loc_cMarca = loc_cMarca + "WHERE SigPcOoL.empdopnums = SigMvPar.empdopnums "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.nopers = SigMvPar.nopers "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.processos = 'CNAB')"
            ENDIF
            loc_cSQL = "SELECT SigMvPar.empdopnums, SigMvPar.emps, SigMvPar.dopes, "
            loc_cSQL = loc_cSQL + "SigMvPar.numes, SigMvPar.vencs, SigMvPar.valos, "
            loc_cSQL = loc_cSQL + "SigMvPar.fpags, SigMvPar.nopers, "
            loc_cSQL = loc_cSQL + "SigMvCcr.titulos, SigMvCcr.titbans, SigMvCcr.dtemis, SigMvCcr.opers, "
            loc_cSQL = loc_cSQL + "SigMvCab.contads, "
            loc_cSQL = loc_cSQL + "SigCdCli.iclis, SigCdCli.rclis, SigCdCli.razaos, SigCdCli.grupos, "
            loc_cSQL = loc_cSQL + "SigCdCli.endes, SigCdCli.cidas, SigCdCli.estas, SigCdCli.nums, "
            loc_cSQL = loc_cSQL + "SigCdCli.compls, SigCdCli.bairs, SigCdCli.ceps, SigCdCli.cpfs, "
            loc_cSQL = loc_cSQL + "SigCdCli.endcobs, SigCdCli.cepcobs, SigCdCli.estcobs, "
            loc_cSQL = loc_cSQL + "SigCdCli.baicobs, SigCdCli.cidcobs, "
            loc_cSQL = loc_cSQL + "CAST(0 AS bit) AS marca, CAST(0 AS bit) AS EnvErro "
            loc_cSQL = loc_cSQL + "FROM SigMvPar "
            loc_cSQL = loc_cSQL + "INNER JOIN SigOpFp ON SigOpFp.fpags = SigMvPar.fpags "
            loc_cSQL = loc_cSQL + "INNER JOIN SigMvCab ON SigMvCab.empdopnums = SigMvPar.empdopnums "
            loc_cSQL = loc_cSQL + "INNER JOIN SigCdCli ON SigCdCli.iclis = SigMvCab.contads "
            loc_cSQL = loc_cSQL + "LEFT JOIN SigMvCcr ON SigMvCcr.empdopnums = SigMvPar.empdopnums "
            loc_cSQL = loc_cSQL + "AND SigMvCcr.nopers = SigMvPar.nopers "
            loc_cSQL = loc_cSQL + "WHERE SigMvPar.emps = " + EscaparSQL(THIS.this_cEmps)
            loc_cSQL = loc_cSQL + " AND SigMvPar.dopes IN (" + par_cOpCodes + ")"
            loc_cSQL = loc_cSQL + " AND SigOpFp.infos = 'K'"
            loc_cSQL = loc_cSQL + " AND " + loc_cPeriodo
            loc_cSQL = loc_cSQL + " AND " + loc_cMarca
            loc_cSQL = loc_cSQL + " ORDER BY SigMvPar.vencs, SigCdCli.rclis"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Filtro") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEmpresa - Carrega dados da empresa para cabecalho do arquivo CNAB
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEmpresa(par_cEmps)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF
            loc_cSQL = "SELECT cemps, razsocs, cgcs, tel1s, ceps, endes, "
            loc_cSQL = loc_cSQL + "numeros, bairs, cidas, estas, compls "
            loc_cSQL = loc_cSQL + "FROM SigCdEmp "
            loc_cSQL = loc_cSQL + "WHERE cemps = " + EscaparSQL(par_cEmps)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarClientePorConta - Retorna dados do cliente pela conta (iclis)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarClientePorConta(par_cConta)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_ClienteConta")
                USE IN cursor_4c_ClienteConta
            ENDIF
            loc_cSQL = "SELECT iclis, grupos, rclis "
            loc_cSQL = loc_cSQL + "FROM SigCdCli "
            loc_cSQL = loc_cSQL + "WHERE iclis = " + EscaparSQL(par_cConta)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClienteConta") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConvenio - Carrega convenio bancario da conta selecionada no filtro
    * par_cGrupo: SigCdCli.grupos do cliente
    * par_cConta: codigo da conta bancaria selecionada
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConvenio(par_cGrupo, par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_cGruContas
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Convenio")
                USE IN cursor_4c_Convenio
            ENDIF
            loc_cGruContas = par_cGrupo + par_cConta
            loc_cSQL = "SELECT agencias, bancos, nagencias, nbancos, digiagen, "
            loc_cSQL = loc_cSQL + "contas, convenios, grucontas, diasprots, instrus, "
            loc_cSQL = loc_cSQL + "moras, bcoimprime, tpctarqs, tpctbols, arqcnabs "
            loc_cSQL = loc_cSQL + "FROM SIGCDCEB "
            loc_cSQL = loc_cSQL + "WHERE grucontas = " + EscaparSQL(loc_cGruContas)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Convenio") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTituloBanco - Retorna titulo e nosso numero do titulo no banco
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTituloBanco(par_cEmpDopNums, par_nNopers)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_TitBan")
                USE IN cursor_4c_TitBan
            ENDIF
            loc_cSQL = "SELECT titulos, titbans "
            loc_cSQL = loc_cSQL + "FROM SigMvCcr "
            loc_cSQL = loc_cSQL + "WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)
            loc_cSQL = loc_cSQL + " AND nopers = " + FormatarNumeroSQL(par_nNopers)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitBan") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTituloBanco - Grava nosso numero do titulo no banco (titbans)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTituloBanco(par_cEmpDopNums, par_nNopers, par_cTitBan)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigMvCcr SET titbans = " + EscaparSQL(par_cTitBan)
            loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)
            loc_cSQL = loc_cSQL + " AND nopers = " + FormatarNumeroSQL(par_nNopers)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirRegistroCNAB - Insere registro de processamento CNAB em SigPcOoL
    *--------------------------------------------------------------------------
    PROCEDURE InserirRegistroCNAB
        LPARAMETERS par_cEmpDopNums, par_cEmps, par_cDopes, par_nNumes, ;
                    par_cUsuars, par_cCidChaves, par_cDopeDs, par_nNumeDs, ;
                    par_cProcessos, par_cProdutos
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO SigPcOoL "
            loc_cSQL = loc_cSQL + "(empdopnums, emps, dopes, numes, usuars, tipos, "
            loc_cSQL = loc_cSQL + "processos, produtos, datas, cidchaves, dopeds, numeds) "
            loc_cSQL = loc_cSQL + "VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(par_cEmpDopNums)         + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cEmps)               + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cDopes)              + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(par_nNumes)       + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cUsuars)             + ", "
            loc_cSQL = loc_cSQL + "'SIGPRCNB', "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cProcessos)          + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cProdutos)           + ", "
            loc_cSQL = loc_cSQL + "GETDATE(), "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cCidChaves)          + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cDopeDs)             + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(par_nNumeDs)      + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CommitAlteracoes - Confirma transacao no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CommitAlteracoes()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF SQLCOMMIT(gnConnHandle) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RollbackAlteracoes - Desfaz transacao no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE RollbackAlteracoes()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF SQLROLLBACK(gnConnHandle) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

