# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_CabRel' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPGCNB.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3804 linhas total):

*-- Linhas 61 a 70:
61:                 ELSE
62:                     THIS.ConfigurarPageFrame()
63:                     THIS.ConfigurarPaginaLista()
64:                     THIS.pgf_4c_Principal.pgfiltro.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
65:                     THIS.pgf_4c_Principal.pgfiltro.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
66:                     THIS.ConfigurarPaginaDados()
67:                     THIS.TornarControlesVisiveis()
68:                     THIS.ConfigurarBINDEVENTs()
69:                     THIS.InicializarValores()
70:                     loc_lSucesso = .T.

*-- Linhas 88 a 106:
88: 
89:         loc_oPgf.PageCount = 2
90:         loc_oPgf.ErasePage = .T.
91:         loc_oPgf.Top       = -24
92:         loc_oPgf.Left      = 0
93:         loc_oPgf.Width     = 1003
94:         loc_oPgf.Height    = 635
95:         loc_oPgf.TabIndex  = 1
96:         loc_oPgf.Tabs      = .F.
97: 
98:         loc_oPgf.Page1.Caption = "Filtro"
99:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100: 
101:         loc_oPgf.Page2.Caption = "Dados"
102:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:         loc_oPgf.Page2.Enabled = .F.
104: 
105:         loc_oPgf.Visible    = .T.
106:         loc_oPgf.ActivePage = 1

*-- Linhas 120 a 161:
120:         loc_oP1.AddObject("cnt_4c_Sombra", "Container")
121:         loc_oCnt = loc_oP1.cnt_4c_Sombra
122:         WITH loc_oCnt
123:             .Top         = 0
124:             .Left        = 0
125:             .Width       = 1100
126:             .Height      = 80
127:             .BorderWidth = 0
128:             .BackColor   = RGB(100,100,100)
129:             .AddObject("lbl_4c_Sombra", "Label")
130:             WITH .lbl_4c_Sombra
131:                 .FontBold      = .T.
132:                 .FontName      = "Tahoma"
133:                 .FontSize      = 18
134:                 .FontUnderline = .F.
135:                 .WordWrap      = .T.
136:                 .Alignment     = 0
137:                 .BackStyle     = 0
138:                 .Caption       = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Pagamentos"
139:                 .Height        = 40
140:                 .Left          = 10
141:                 .Top           = 18
142:                 .Width         = THIS.Width
143:                 .ForeColor     = RGB(0,0,0)
144:             ENDWITH
145:             .AddObject("lbl_4c_Titulo", "Label")
146:             WITH .lbl_4c_Titulo
147:                 .FontBold   = .T.
148:                 .FontName   = "Tahoma"
149:                 .FontSize   = 18
150:                 .WordWrap   = .T.
151:                 .Alignment  = 0
152:                 .BackStyle  = 0
153:                 .Caption    = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Pagamentos"
154:                 .Height     = 46
155:                 .Left       = 10
156:                 .Top        = 17
157:                 .Width      = THIS.Width
158:                 .ForeColor  = RGB(255,255,255)
159:             ENDWITH
160:         ENDWITH
161: 

*-- Linhas 169 a 300:
169:             .BorderStyle   = 0
170:             .Value         = 1
171:             .Height        = 85
172:             .Left          = 844
173:             .SpecialEffect = 1
174:             .Top           = -2
175:             .Width         = 160
176:             .TabIndex      = 12
177:             .BackColor     = RGB(240,240,240)
178:             .Themes        = .F.
179:             WITH .Command1
180:                 .Top           = 5
181:                 .Left          = 5
182:                 .Height        = 75
183:                 .Width         = 75
184:                 .FontBold      = .T.
185:                 .FontItalic    = .T.
186:                 .FontName      = "Tahoma"
187:                 .FontSize      = 8
188:                 .WordWrap      = .T.
189:                 .Picture       = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
190:                 .Caption       = "Processar"
191:                 .MousePointer  = 15
192:                 .SpecialEffect = 0
193:                 .ForeColor     = RGB(90,90,90)
194:                 .BackColor     = RGB(255,255,255)
195:                 .Themes        = .F.
196:                 .Name          = "btnProcessar"
197:             ENDWITH
198:             WITH .Command2
199:                 .Top           = 5
200:                 .Left          = 80
201:                 .Height        = 75
202:                 .Width         = 75
203:                 .FontBold      = .T.
204:                 .FontItalic    = .T.
205:                 .FontName      = "Tahoma"
206:                 .FontSize      = 8
207:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
208:                 .Cancel        = .T.
209:                 .Caption       = "Encerrar"
210:                 .ToolTipText   = "[ESC] Encerrar"
211:                 .ForeColor     = RGB(90,90,90)
212:                 .BackColor     = RGB(255,255,255)
213:                 .Themes        = .F.
214:                 .Name          = "btnsair"
215:             ENDWITH
216:         ENDWITH
217: 
218:         *-- Label "Operacoes:"
219:         loc_oP1.AddObject("lbl_4c_LblOper", "Label")
220:         WITH loc_oP1.lbl_4c_LblOper
221:             .AutoSize   = .T.
222:             .FontBold   = .T.
223:             .FontName   = "Tahoma"
224:             .FontSize   = 8
225:             .BackStyle  = 0
226:             .Caption    = "Opera" + CHR(231) + CHR(245) + "es :"
227:             .Height     = 15
228:             .Left       = 301
229:             .Top        = 91
230:             .Width      = 68
231:             .TabIndex   = 13
232:             .ForeColor  = RGB(90,90,90)
233:         ENDWITH
234: 
235:         *-- OptionGroup processados
236:         loc_oP1.AddObject("opt_4c_Processados", "OptionGroup")
237:         WITH loc_oP1.opt_4c_Processados
238:             .BackStyle   = 0
239:             .BorderStyle = 0
240:             .ButtonCount = 2
241:             .Height      = 19
242:             .Left        = 366
243:             .Top         = 90
244:             .Width       = 235
245:             .Value       = 1
246:             .TabIndex    = 1
247:             WITH .Option1
248:                 .BackStyle = 0
249:                 .Caption   = "N" + CHR(227) + "o Processadas"
250:                 .Left      = 5
251:                 .Top       = 2
252:                 .AutoSize  = .T.
253:                 .ForeColor = RGB(90,90,90)
254:                 .Value     = 1
255:             ENDWITH
256:             WITH .Option2
257:                 .FontName  = "Tahoma"
258:                 .FontSize  = 8
259:                 .BackStyle = 0
260:                 .Caption   = "J" + CHR(225) + " Processadas"
261:                 .Left      = 126
262:                 .Top       = 2
263:                 .AutoSize  = .T.
264:                 .ForeColor = RGB(90,90,90)
265:                 .Value     = 0
266:             ENDWITH
267:         ENDWITH
268: 
269:         *-- Label "Empresa :"
270:         loc_oP1.AddObject("lbl_4c_LblEmpresa", "Label")
271:         WITH loc_oP1.lbl_4c_LblEmpresa
272:             .AutoSize   = .T.
273:             .FontName   = "Tahoma"
274:             .FontSize   = 8
275:             .BackStyle  = 0
276:             .Caption    = "Empresa :"
277:             .Left       = 319
278:             .Top        = 118
279:             .Width      = 50
280:             .TabIndex   = 14
281:             .ForeColor  = RGB(90,90,90)
282:         ENDWITH
283: 
284:         *-- TextBox Codigo Empresa
285:         loc_oP1.AddObject("txt_4c_CdEmpresa", "TextBox")
286:         WITH loc_oP1.txt_4c_CdEmpresa
287:             .FontName      = "Tahoma"
288:             .FontSize      = 8
289:             .Format        = "K"
290:             .Height        = 23
291:             .Left          = 371
292:             .MaxLength     = 3
293:             .SpecialEffect = 1
294:             .TabIndex      = 2
295:             .Top           = 115
296:             .Width         = 31
297:             .Value         = ""
298:             .ForeColor     = RGB(0,0,0)
299:             .BorderColor   = RGB(100,100,100)
300:         ENDWITH

*-- Linhas 306 a 333:
306:             .FontSize      = 8
307:             .Format        = "K"
308:             .Height        = 23
309:             .Left          = 405
310:             .MaxLength     = 40
311:             .SpecialEffect = 1
312:             .TabIndex      = 3
313:             .Top           = 115
314:             .Width         = 290
315:             .Value         = ""
316:             .ForeColor     = RGB(0,0,0)
317:             .BorderColor   = RGB(100,100,100)
318:         ENDWITH
319: 
320:         *-- Label "Periodo :"
321:         loc_oP1.AddObject("lbl_4c_LblPeriodo", "Label")
322:         WITH loc_oP1.lbl_4c_LblPeriodo
323:             .AutoSize   = .T.
324:             .FontName   = "Tahoma"
325:             .FontSize   = 8
326:             .Caption    = "Per" + CHR(237) + "odo :"
327:             .Left       = 324
328:             .Top        = 146
329:             .Width      = 45
330:             .TabIndex   = 16
331:             .BackStyle  = 0
332:             .ForeColor  = RGB(90,90,90)
333:         ENDWITH

*-- Linhas 341 a 365:
341:             .Format        = "KD"
342:             .BorderStyle   = 1
343:             .Value         = {}
344:             .Left          = 371
345:             .SpecialEffect = 1
346:             .TabIndex      = 4
347:             .Top           = 143
348:             .Width         = 80
349:             .ForeColor     = RGB(0,0,0)
350:             .BorderColor   = RGB(100,100,100)
351:         ENDWITH
352: 
353:         *-- Label "ate"
354:         loc_oP1.AddObject("lbl_4c_LblAte", "Label")
355:         WITH loc_oP1.lbl_4c_LblAte
356:             .AutoSize  = .T.
357:             .FontName  = "Tahoma"
358:             .Caption   = "at" + CHR(233)
359:             .Left      = 456
360:             .Top       = 146
361:             .TabIndex  = 17
362:             .BackStyle = 0
363:             .ForeColor = RGB(90,90,90)
364:         ENDWITH
365: 

*-- Linhas 372 a 383:
372:             .Format        = "KD"
373:             .BorderStyle   = 1
374:             .Value         = {}
375:             .Left          = 479
376:             .SpecialEffect = 1
377:             .TabIndex      = 5
378:             .Top           = 143
379:             .Width         = 80
380:             .ForeColor     = RGB(0,0,0)
381:             .BorderColor   = RGB(100,100,100)
382:         ENDWITH
383: 

*-- Linhas 389 a 434:
389:             .BackStyle   = 0
390:             .BorderStyle = 0
391:             .Height      = 25
392:             .Left        = 566
393:             .Top         = 141
394:             .Width       = 168
395:             .Value       = 1
396:             .TabIndex    = 6
397:             WITH .Option1
398:                 .BackStyle = 0
399:                 .Caption   = "Vencimento"
400:                 .Value     = 1
401:                 .Height    = 15
402:                 .Left      = 5
403:                 .Top       = 5
404:                 .Width     = 73
405:                 .AutoSize  = .T.
406:                 .ForeColor = RGB(90,90,90)
407:             ENDWITH
408:             WITH .Option2
409:                 .FontName  = "Tahoma"
410:                 .FontSize  = 8
411:                 .BackStyle = 0
412:                 .Caption   = "Emiss" + CHR(227) + "o"
413:                 .Value     = 0
414:                 .Left      = 96
415:                 .Top       = 5
416:                 .AutoSize  = .T.
417:                 .ForeColor = RGB(90,90,90)
418:             ENDWITH
419:         ENDWITH
420: 
421:         *-- Label "Banco :"
422:         loc_oP1.AddObject("lbl_4c_LblBanco", "Label")
423:         WITH loc_oP1.lbl_4c_LblBanco
424:             .AutoSize   = .T.
425:             .FontName   = "Tahoma"
426:             .FontSize   = 8
427:             .Caption    = "Banco :"
428:             .Left       = 331
429:             .Top        = 175
430:             .Width      = 38
431:             .TabIndex   = 18
432:             .BackStyle  = 0
433:             .ForeColor  = RGB(90,90,90)
434:         ENDWITH

*-- Linhas 440 a 452:
440:             .FontSize      = 8
441:             .Format        = "K"
442:             .Height        = 23
443:             .Left          = 371
444:             .MaxLength     = 10
445:             .SpecialEffect = 1
446:             .TabIndex      = 7
447:             .Top           = 171
448:             .Width         = 79
449:             .Value         = ""
450:             .ForeColor     = RGB(0,0,0)
451:             .BorderColor   = RGB(100,100,100)
452:         ENDWITH

*-- Linhas 458 a 485:
458:             .FontSize      = 8
459:             .Format        = "K"
460:             .Height        = 23
461:             .Left          = 452
462:             .MaxLength     = 40
463:             .SpecialEffect = 1
464:             .TabIndex      = 8
465:             .Top           = 171
466:             .Width         = 290
467:             .Value         = ""
468:             .ForeColor     = RGB(0,0,0)
469:             .BorderColor   = RGB(100,100,100)
470:         ENDWITH
471: 
472:         *-- Label "Empresa do convenio :"
473:         loc_oP1.AddObject("lbl_4c_LblEmpConv", "Label")
474:         WITH loc_oP1.lbl_4c_LblEmpConv
475:             .AutoSize   = .T.
476:             .FontName   = "Tahoma"
477:             .FontSize   = 8
478:             .Caption    = "Empresa do conv" + CHR(234) + "nio :"
479:             .Left       = 258
480:             .Top        = 201
481:             .Width      = 111
482:             .TabIndex   = 15
483:             .BackStyle  = 0
484:             .ForeColor  = RGB(90,90,90)
485:         ENDWITH

*-- Linhas 491 a 503:
491:             .FontSize      = 8
492:             .Format        = "K"
493:             .Height        = 23
494:             .Left          = 371
495:             .MaxLength     = 3
496:             .SpecialEffect = 1
497:             .TabIndex      = 9
498:             .Top           = 198
499:             .Width         = 31
500:             .Value         = ""
501:             .ForeColor     = RGB(0,0,0)
502:             .BorderColor   = RGB(100,100,100)
503:         ENDWITH

*-- Linhas 509 a 534:
509:             .FontSize      = 8
510:             .Format        = "K"
511:             .Height        = 23
512:             .Left          = 405
513:             .MaxLength     = 40
514:             .SpecialEffect = 1
515:             .TabIndex      = 10
516:             .Top           = 198
517:             .Width         = 290
518:             .Value         = ""
519:             .ForeColor     = RGB(0,0,0)
520:             .BorderColor   = RGB(100,100,100)
521:         ENDWITH
522: 
523:         *-- Label "Grupos Fornecedores :"
524:         loc_oP1.AddObject("lbl_4c_LblGrupos", "Label")
525:         WITH loc_oP1.lbl_4c_LblGrupos
526:             .FontName  = "Tahoma"
527:             .Caption   = "Grupos Fornecedores :"
528:             .Left      = 257
529:             .Top       = 238
530:             .TabIndex  = 19
531:             .BackStyle = 0
532:             .ForeColor = RGB(90,90,90)
533:             .AutoSize  = .T.
534:         ENDWITH

*-- Linhas 543 a 565:
543:             .DeleteMark       = .F.
544:             .GridLines        = 3
545:             .Height           = 344
546:             .Left             = 372
547:             .Panel            = 1
548:             .ScrollBars       = 2
549:             .SplitBar         = .F.
550:             .TabIndex         = 11
551:             .Top              = 236
552:             .Width            = 202
553:             .GridLineColor    = RGB(238,238,238)
554:             .Themes           = .F.
555:             .Column1.Width    = 18
556:             .Column1.Movable  = .F.
557:             .Column1.Resizable = .F.
558:             .Column1.Sparse   = .F.
559:             .Column1.AddObject("Check1", "CheckBox")
560:             .Column1.Check1.Caption = ""
561:             .Column1.Check1.Value   = 0
562:             .Column1.CurrentControl = "Check1"
563:             .Column2.Width    = 150
564:             .Column2.Movable  = .F.
565:             .Column2.Resizable = .F.

*-- Linhas 576 a 612:
576:             .BorderStyle   = 0
577:             .Value         = 0
578:             .Height        = 91
579:             .Left          = 585
580:             .SpecialEffect = 1
581:             .Top           = 319
582:             .Width         = 50
583:             .TabIndex      = 20
584:             .BackColor     = RGB(240,240,240)
585:             .Themes        = .F.
586:             WITH .Command1
587:                 .Top         = 5
588:                 .Left        = 5
589:                 .Height      = 40
590:                 .Width       = 40
591:                 .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
592:                 .Caption     = ""
593:                 .ToolTipText = "Marcar tudo"
594:                 .ForeColor   = RGB(36,84,155)
595:                 .BackColor   = RGB(255,255,255)
596:                 .Themes      = .F.
597:                 .Name        = "btnmarca"
598:             ENDWITH
599:             WITH .Command2
600:                 .Top         = 46
601:                 .Left        = 5
602:                 .Height      = 40
603:                 .Width       = 40
604:                 .FontName    = "Verdana"
605:                 .FontSize    = 8
606:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
607:                 .Caption     = ""
608:                 .ToolTipText = "Desmarcar tudo"
609:                 .ForeColor   = RGB(36,84,155)
610:                 .BackColor   = RGB(255,255,255)
611:                 .Themes      = .F.
612:                 .Name        = "btndesmarca"

*-- Linhas 631 a 655:
631:             .AllowRowSizing    = .F.
632:             .DeleteMark        = .F.
633:             .Height            = 382
634:             .Left              = 9
635:             .Panel             = 1
636:             .RecordMark        = .F.
637:             .ScrollBars        = 2
638:             .SplitBar          = .F.
639:             .TabIndex          = 1
640:             .Top               = 152
641:             .Width             = 981
642:             .GridLineColor     = RGB(238,238,238)
643:             .Themes            = .F.
644:             .Column1.Width     = 16
645:             .Column1.Movable   = .F.
646:             .Column1.Resizable = .F.
647:             .Column1.Sparse    = .F.
648:             .Column1.ColumnOrder = 1
649:             .Column1.AddObject("Check1", "CheckBox")
650:             .Column1.Check1.Caption = ""
651:             .Column1.Check1.Value   = 0
652:             .Column1.CurrentControl = "Check1"
653:             .Column2.Width     = 70
654:             .Column2.Movable   = .F.
655:             .Column2.Resizable = .F.

*-- Linhas 697 a 723:
697:             .BorderStyle   = 0
698:             .Value         = 0
699:             .Height        = 85
700:             .Left          = 917
701:             .SpecialEffect = 1
702:             .Top           = -2
703:             .Width         = 85
704:             .TabIndex      = 2
705:             .BackColor     = RGB(240,240,240)
706:             .Themes        = .F.
707:             WITH .Command1
708:                 .Top           = 5
709:                 .Left          = 5
710:                 .Height        = 75
711:                 .Width         = 75
712:                 .FontBold      = .T.
713:                 .FontItalic    = .T.
714:                 .FontName      = "Tahoma"
715:                 .FontSize      = 8
716:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
717:                 .Cancel        = .T.
718:                 .Caption       = "Encerrar"
719:                 .ToolTipText   = "[ESC] Encerrar"
720:                 .ForeColor     = RGB(90,90,90)
721:                 .BackColor     = RGB(255,255,255)
722:                 .Themes        = .F.
723:                 .Name          = "btnsair"

*-- Linhas 734 a 807:
734:             .BorderStyle   = 0
735:             .Value         = 0
736:             .Height        = 85
737:             .Left          = 692
738:             .SpecialEffect = 1
739:             .Top           = -2
740:             .Width         = 235
741:             .TabIndex      = 3
742:             .BackColor     = RGB(240,240,240)
743:             .Themes        = .F.
744:             WITH .Command1
745:                 .Top     = 5
746:                 .Left    = 5
747:                 .Height  = 75
748:                 .Width   = 75
749:                 .FontBold = .T.
750:                 .FontItalic = .T.
751:                 .FontName = "Tahoma"
752:                 .FontSize = 8
753:                 .Picture  = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
754:                 .Caption  = "Gerar CNAB"
755:                 .ForeColor = RGB(90,90,90)
756:                 .BackColor = RGB(255,255,255)
757:                 .Themes   = .F.
758:                 .Name     = "btncnab"
759:             ENDWITH
760:             WITH .Command2
761:                 .Top     = 5
762:                 .Left    = 80
763:                 .Height  = 75
764:                 .Width   = 75
765:                 .FontBold = .T.
766:                 .FontItalic = .T.
767:                 .FontName = "Tahoma"
768:                 .FontSize = 8
769:                 .Picture  = gc_4c_CaminhoIcones + "geral_video_60.jpg"
770:                 .Caption  = "Relat" + CHR(243) + "rio"
771:                 .Enabled  = .F.
772:                 .ForeColor = RGB(90,90,90)
773:                 .BackColor = RGB(255,255,255)
774:                 .Themes   = .F.
775:                 .Name     = "btnrelatorio"
776:             ENDWITH
777:             WITH .Command3
778:                 .Top     = 5
779:                 .Left    = 155
780:                 .Height  = 75
781:                 .Width   = 75
782:                 .FontBold = .T.
783:                 .FontItalic = .T.
784:                 .FontName = "Tahoma"
785:                 .FontSize = 8
786:                 .Picture  = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
787:                 .Caption  = "Boleto"
788:                 .Enabled  = .F.
789:                 .ForeColor = RGB(90,90,90)
790:                 .BackColor = RGB(255,255,255)
791:                 .Name     = "btnBoleto"
792:             ENDWITH
793:         ENDWITH
794: 
795:         *-- Label "Protestar apos :"
796:         loc_oP2.AddObject("lbl_4c_Protestar", "Label")
797:         WITH loc_oP2.lbl_4c_Protestar
798:             .Caption  = "Protestar ap" + CHR(243) + "s :"
799:             .Enabled  = .F.
800:             .Height   = 15
801:             .Left     = 423
802:             .Top      = 117
803:             .Width    = 80
804:             .TabIndex = 5
805:             .BackStyle = 0
806:             .ForeColor = RGB(90,90,90)
807:         ENDWITH

*-- Linhas 815 a 840:
815:             .Height            = 24
816:             .KeyboardHighValue = 99
817:             .KeyboardLowValue  = 0
818:             .Left              = 505
819:             .SpecialEffect     = 1
820:             .SpinnerHighValue  = 99
821:             .SpinnerLowValue   = 0
822:             .TabIndex          = 7
823:             .Top               = 113
824:             .Width             = 45
825:             .Value             = 5
826:         ENDWITH
827: 
828:         *-- Label "dias"
829:         loc_oP2.AddObject("lbl_4c_Dias", "Label")
830:         WITH loc_oP2.lbl_4c_Dias
831:             .Caption  = "dias"
832:             .Enabled  = .F.
833:             .Height   = 15
834:             .Left     = 555
835:             .Top      = 118
836:             .Width    = 21
837:             .TabIndex = 6
838:             .BackStyle = 0
839:             .ForeColor = RGB(90,90,90)
840:         ENDWITH

*-- Linhas 848 a 884:
848:             .BorderStyle   = 0
849:             .Value         = 0
850:             .Height        = 50
851:             .Left          = 9
852:             .SpecialEffect = 1
853:             .Top           = 540
854:             .Width         = 92
855:             .TabIndex      = 4
856:             .BackColor     = RGB(240,240,240)
857:             .Themes        = .F.
858:             WITH .Command1
859:                 .Top     = 5
860:                 .Left    = 7
861:                 .Height  = 40
862:                 .Width   = 40
863:                 .Picture  = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
864:                 .Caption  = ""
865:                 .ToolTipText = "Marcar tudo"
866:                 .ForeColor = RGB(36,84,155)
867:                 .BackColor = RGB(255,255,255)
868:                 .Themes   = .F.
869:                 .Name     = "btnmarca"
870:             ENDWITH
871:             WITH .Command2
872:                 .Top     = 5
873:                 .Left    = 47
874:                 .Height  = 40
875:                 .Width   = 40
876:                 .FontName = "Verdana"
877:                 .FontSize = 8
878:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
879:                 .Caption  = ""
880:                 .ToolTipText = "Desmarcar tudo"
881:                 .ForeColor = RGB(36,84,155)
882:                 .BackColor = RGB(255,255,255)
883:                 .Themes   = .F.
884:                 .Name     = "btndesmarca"

*-- Linhas 897 a 934:
897: 
898:         loc_oP1 = loc_oPgf.pgfiltro
899:         loc_oP1.cnt_4c_Sombra.Visible            = .T.
900:         loc_oP1.cnt_4c_Sombra.lbl_4c_Sombra.Visible = .T.
901:         loc_oP1.cnt_4c_Sombra.lbl_4c_Titulo.Visible = .T.
902:         loc_oP1.cgp_4c_Filtro.Visible            = .T.
903:         loc_oP1.lbl_4c_LblOper.Visible           = .T.
904:         loc_oP1.opt_4c_Processados.Visible        = .T.
905:         loc_oP1.lbl_4c_LblEmpresa.Visible         = .T.
906:         loc_oP1.txt_4c_CdEmpresa.Visible          = .T.
907:         loc_oP1.txt_4c_DsEmpresa.Visible          = .T.
908:         loc_oP1.lbl_4c_LblPeriodo.Visible         = .T.
909:         loc_oP1.txt_4c_Datai.Visible              = .T.
910:         loc_oP1.lbl_4c_LblAte.Visible             = .T.
911:         loc_oP1.txt_4c_Dataf.Visible              = .T.
912:         loc_oP1.opt_4c_Periodo.Visible            = .T.
913:         loc_oP1.lbl_4c_LblBanco.Visible           = .T.
914:         loc_oP1.txt_4c_CdConta.Visible            = .T.
915:         loc_oP1.txt_4c_DsConta.Visible            = .T.
916:         loc_oP1.lbl_4c_LblEmpConv.Visible         = .T.
917:         loc_oP1.txt_4c_CdEmpConv.Visible          = .T.
918:         loc_oP1.txt_4c_DsEmpConv.Visible          = .T.
919:         loc_oP1.lbl_4c_LblGrupos.Visible          = .T.
920:         loc_oP1.grd_4c_Grupos.Visible             = .T.
921:         loc_oP1.cgp_4c_MarcaFiltro.Visible        = .T.
922: 
923:         loc_oP2 = loc_oPgf.pgdados
924:         loc_oP2.grd_4c_Dados.Visible              = .T.
925:         loc_oP2.cgp_4c_Encerrar.Visible           = .T.
926:         loc_oP2.cgp_4c_Acoes.Visible              = .T.
927:         loc_oP2.lbl_4c_Protestar.Visible          = .T.
928:         loc_oP2.spn_4c_Dias.Visible               = .T.
929:         loc_oP2.lbl_4c_Dias.Visible               = .T.
930:         loc_oP2.cgp_4c_MarcaDados.Visible         = .T.
931:     ENDPROC
932: 
933:     *==========================================================================
934:     * ConfigurarBINDEVENTs - Liga eventos aos handlers do form

*-- Linhas 989 a 998:
989:             loc_oGrd.RecordSource      = "cursor_4c_Grupos"
990:             loc_oGrd.Column1.ControlSource = "cursor_4c_Grupos.marca"
991:             loc_oGrd.Column2.ControlSource = "cursor_4c_Grupos.descrs"
992:             loc_oGrd.Column1.Header1.Caption = ""
993:             loc_oGrd.Column2.Header1.Caption = "Grupos"
994:             loc_oGrd.Column2.Header1.Alignment = 2
995:             loc_oGrd.Refresh()
996:         ENDIF
997: 
998:         THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.SetFocus()

*-- Linhas 1383 a 1403:
1383:     ENDPROC
1384: 
1385:     *==========================================================================
1386:     * ImpBoleto - Imprime/exibe boletos dos registros marcados em cursor_4c_Filtro2Rel
1387:     * par_lImprimir: .T. = preview + impressora, .F. = apenas preview
1388:     * Chamado apos GerarCNAB("I") que prepara cursor_4c_Filtro2Rel e cursor_4c_CabRel
1389:     *==========================================================================
1390:     PROCEDURE ImpBoleto(par_lImprimir)
1391:         LOCAL loc_lSucesso, loc_oErro
1392:         loc_lSucesso = .F.
1393: 
1394:         TRY
1395:             IF !USED("cursor_4c_Filtro2Rel") OR RECCOUNT("cursor_4c_Filtro2Rel") = 0
1396:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para impress" + CHR(227) + "o de boleto")
1397:                 RETURN
1398:             ENDIF
1399: 
1400:             SELECT cursor_4c_Filtro2Rel
1401:             GO TOP
1402: 
1403:             IF par_lImprimir

*-- Linhas 1601 a 1616:
1601:         loc_oGrd.Column6.ControlSource = "cursor_4c_Filtro.histo"
1602:         loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.rclis"
1603:         loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.emps"
1604:         loc_oGrd.Column1.Header1.Caption = ""
1605:         loc_oGrd.Column2.Header1.Caption = "Data"
1606:         loc_oGrd.Column3.Header1.Caption = "Vencimento"
1607:         loc_oGrd.Column4.Header1.Caption = "Valor"
1608:         loc_oGrd.Column5.Header1.Caption = "Moeda"
1609:         loc_oGrd.Column6.Header1.Caption = "Historico"
1610:         loc_oGrd.Column7.Header1.Caption = "Fornecedor"
1611:         loc_oGrd.Column8.Header1.Caption = "Empresa"
1612:         loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
1613:         loc_oGrd.Refresh()
1614:     ENDPROC
1615: 
1616:     *==========================================================================

*-- Linhas 1673 a 1688:
1673:         loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.rclis"
1674:         loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.emps"
1675: 
1676:         loc_oGrd.Column1.Header1.Caption = ""
1677:         loc_oGrd.Column2.Header1.Caption = "Data"
1678:         loc_oGrd.Column3.Header1.Caption = "Vencimento"
1679:         loc_oGrd.Column4.Header1.Caption = "Valor"
1680:         loc_oGrd.Column5.Header1.Caption = "Moeda"
1681:         loc_oGrd.Column6.Header1.Caption = "Historico"
1682:         loc_oGrd.Column7.Header1.Caption = "Fornecedor"
1683:         loc_oGrd.Column8.Header1.Caption = "Empresa"
1684: 
1685:         loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
1686:         loc_oGrd.Refresh()
1687: 
1688:         *-- Muda para pagina de dados

*-- Linhas 1796 a 1820:
1796:             LOCAL loc_cProt, loc_cDataRel
1797:             loc_cProt    = PADL(ALLTRIM(STR(IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value))), 2, "0")
1798:             loc_cDataRel = "Per" + CHR(237) + "odo: " + DTOC(loc_dDati) + " at" + CHR(233) + " " + DTOC(loc_dDatf) + ;
1799:                            " - Protesto em " + loc_cProt + " dias"
1800: 
1801:             IF USED("cursor_4c_CabRel")
1802:                 USE IN cursor_4c_CabRel
1803:             ENDIF
1804:             CREATE CURSOR cursor_4c_CabRel (titulo C(100), periodo C(100), empresa C(100))
1805:             INSERT INTO cursor_4c_CabRel (titulo, periodo, empresa) ;
1806:                 VALUES ("Dados para gera" + CHR(231) + CHR(227) + "o do CNAB", ;
1807:                         loc_cDataRel, ;
1808:                         loc_cCdEmp + " - " + ALLTRIM(NVL(cursor_4c_Empresa.RazSocs, "")))
1809: 
1810:             IF USED("cursor_4c_Filtro2Rel")
1811:                 USE IN cursor_4c_Filtro2Rel
1812:             ENDIF
1813:             SELECT *, SPACE(11) AS SeqNums FROM cursor_4c_Filtro WHERE marca INTO CURSOR cursor_4c_Filtro2Rel
1814: 
1815:             IF par_cTipo = "V"
1816:                 REPORT FORM sigrecnb PREVIEW
1817:             ENDIF
1818:         ENDIF
1819:     ENDPROC
1820: 

*-- Linhas 3787 a 3804:
3787:         loc_aCursores(10) = "crFiltro5"
3788:         loc_aCursores(11) = "crFiltro6"
3789:         loc_aCursores(12) = "crFiltroTr"
3790:         loc_aCursores(13) = "crFiltro20"
3791:         loc_aCursores(14) = "crErro"
3792:         loc_aCursores(15) = "cursor_4c_CabRel"
3793:         loc_aCursores(16) = "cursor_4c_Filtro2Rel"
3794:         FOR loc_i = 1 TO ALEN(loc_aCursores)
3795:             IF USED(loc_aCursores[loc_i])
3796:                 USE IN (loc_aCursores[loc_i])
3797:             ENDIF
3798:         ENDFOR
3799: 
3800:         THIS.this_oBusinessObject = .NULL.
3801:         DODEFAULT()
3802:     ENDPROC
3803: 
3804: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPGCNBBO.prg):
*==============================================================================
* SIGPGCNBBO.prg - Business Object para Geracao de Arquivos CNAB - Pagamentos
* Data: 2026-06-19
* Tabela principal: SigPcOol | PK: cidchaves
* Tabela de operacoes: SigMvCcr (leitura) | SigCdCeb (convenios)
*==============================================================================

DEFINE CLASS SIGPGCNBBO AS BusinessBase

    *-- -----------------------------------------------------------------------
    *-- FILTROS DE TELA (pgfiltro)
    *-- -----------------------------------------------------------------------

    *-- Empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa        = ""    && Emps     CHAR(3)  - C" + CHR(243) + "digo empresa
    this_cDsEmpresa        = ""    && RazSocs  CHAR(40) - Raz" + CHR(227) + "o social

    *-- Per" + CHR(237) + "odo (Get_Datai / Get_Dataf)
    this_dDatai            = {}    && Per" + CHR(237) + "odo inicial
    this_dDataf            = {}    && Per" + CHR(237) + "odo final

    *-- Op" + CHR(231) + CHR(227) + "o processados (optProcessados: 1=N" + CHR(227) + "o Processados, 2=J" + CHR(225) + " Processados)
    this_nProcessados      = 1

    *-- Op" + CHR(231) + CHR(227) + "o per" + CHR(237) + "odo (optPeriodo: 1=Vencimento, 2=Emiss" + CHR(227) + "o)
    this_nPeriodo          = 1

    *-- Conta banc" + CHR(225) + "ria (get_cd_car_conta / get_ds_car_conta)
    this_cCdConta          = ""    && IClis / GruContas CHAR(10) - C" + CHR(243) + "digo conta
    this_cDsConta          = ""    && Descri" + CHR(231) + CHR(227) + "o da conta CHAR(40)

    *-- Empresa do conv" + CHR(234) + "nio (getCEmpc / getDEmpc)
    this_cCdEmpConvenio    = ""    && Cemps    CHAR(3)  - C" + CHR(243) + "digo empresa conv" + CHR(234) + "nio
    this_cDsEmpConvenio    = ""    && RazSocs  CHAR(40) - Descri" + CHR(231) + CHR(227) + "o empresa conv" + CHR(234) + "nio

    *-- -----------------------------------------------------------------------
    *-- ESTADO DO PROCESSAMENTO (pgdados)
    *-- -----------------------------------------------------------------------

    *-- Spinner dias protesto (spndias, default=5)
    this_nDiasProt         = 5     && DiasProts NUMERIC - Dias para protestos

    *-- Caminho do arquivo CNAB gerado
    this_cArquivoCNAB      = ""    && Drive + ArqCnabs - Caminho completo do .REM

    *-- C" + CHR(243) + "digo do banco do conv" + CHR(234) + "nio ativo (ex: "001", "341", "237", "033")
    this_cBancoNr          = ""    && nbancos CHAR(3) - C" + CHR(243) + "digo banco FEBRABAN

    *-- -----------------------------------------------------------------------
    *-- REGISTRO DE PROCESSAMENTO (SigPcOol)
    *-- -----------------------------------------------------------------------

    *-- Campos da tabela SigPcOol (usados em INSERT)
    this_cDopes            = ""    && dopes     CHAR    - Tipo operacao ('C' = CNAB)
    this_nNopers           = 0     && nopers    NUMERIC - N" + CHR(250) + "mero operacao de SigMvCcr
    this_cUsuars           = ""    && usuars    CHAR    - Usu" + CHR(225) + "rio que gerou
    this_cTipos            = ""    && tipos     CHAR    - Identificador ('SIGPGCNB')
    this_cProcessos        = ""    && processos CHAR    - Processo ('CNAB')
    this_cProdutos         = ""    && produtos  MEMO    - Conte" + CHR(250) + "do do arquivo gerado
    this_dDataS            = {}    && DataS     DATETIME - Data/hora de geracao
    this_cCidChaves        = ""    && cidchaves CHAR    - Chave " + CHR(250) + "nica (PK)
    this_cDopeds           = ""    && dopeds    CHAR    - Referencia doc (titulo)
    this_cEdndests         = ""    && edndests  CHAR    - Chave destino (titulo+nopers)

    *-- -----------------------------------------------------------------------
    *-- DADOS DO CONVENIO BANCARIO (SigCdCeb - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cConvenio         = ""    && Convenios  CHAR - C" + CHR(243) + "digo conv" + CHR(234) + "nio
    this_cAgencia          = ""    && NAgencias  CHAR - Ag" + CHR(234) + "ncia empresa
    this_cDigitoAgencia    = ""    && DigiAgen   CHAR - D" + CHR(237) + "gito ag" + CHR(234) + "ncia
    this_cContaConv        = ""    && contas     CHAR - Conta do conv" + CHR(234) + "nio
    this_cArqCnabs         = ""    && ArqCnabs   CHAR - Nome base do arquivo
    this_cDrive            = ""    && Drive      CHAR - Drive de destino
    this_cTpCtArq          = ""    && TpCtArqs   CHAR - Tipo conta arquivo
    this_cTpCtBol          = ""    && TpCtBols   CHAR - Tipo conta boleto
    this_cBancos           = ""    && bancos     CHAR - Raz" + CHR(227) + "o social banco

    *-- -----------------------------------------------------------------------
    *-- DADOS DA EMPRESA (SigCdEmp - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cRazSocs          = ""    && RazSocs   CHAR - Raz" + CHR(227) + "o social empresa
    this_cCgcs             = ""    && Cgcs      CHAR - CNPJ/CPF empresa
    this_cEndesEmp         = ""    && Endes     CHAR - Endere" + CHR(231) + "o empresa
    this_cNumerosEmp       = ""    && Numeros   CHAR - N" + CHR(250) + "mero endere" + CHR(231) + "o
    this_cComplsEmp        = ""    && Compls    CHAR - Complemento
    this_cBairsEmp         = ""    && Bairs     CHAR - Bairro
    this_cCidasEmp         = ""    && Cidas     CHAR - Cidade
    this_cCepsEmp          = ""    && Ceps      CHAR - CEP
    this_cEstasEmp         = ""    && Estas     CHAR - Estado (UF)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPcOol"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * Usado pelo sistema de auditoria do BusinessBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cDopes      = TratarNulo(dopes, "C")
            THIS.this_nNopers     = TratarNulo(nopers, "N")
            THIS.this_cUsuars     = TratarNulo(usuars, "C")
            THIS.this_cTipos      = TratarNulo(tipos, "C")
            THIS.this_cProcessos  = TratarNulo(processos, "C")
            THIS.this_cProdutos   = TratarNulo(produtos, "C")
            THIS.this_cDopeds     = TratarNulo(dopeds, "C")
            THIS.this_cEdndests   = TratarNulo(edndests, "C")
            IF TYPE("DataS") != "U"
                THIS.this_dDataS  = TratarNulo(DataS, "D")
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro de processamento CNAB em SigPcOol
    * Chamado para cada linha/segmento gerado durante geracao do arquivo CNAB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cProdutos
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidChaves = ALLTRIM(fUniqueIds())
            THIS.this_cUsuars    = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_cTipos     = "SIGPGCNB"
            THIS.this_cProcessos = "CNAB"

            loc_cProdutos = THIS.this_cProdutos

            loc_cSQL = "INSERT INTO SigPcOol " + ;
                       "(dopes, nopers, usuars, tipos, processos, produtos, DataS, cidchaves, dopeds, edndests)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNopers) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       EscaparSQL(THIS.this_cTipos) + ", " + ;
                       EscaparSQL(THIS.this_cProcessos) + ", " + ;
                       "?loc_cProdutos, " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopeds) + ", " + ;
                       EscaparSQL(THIS.this_cEdndests) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro em SigPcOol." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir em SigPcOol:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de processamento CNAB em SigPcOol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cProdutos
        loc_lSucesso = .F.
        TRY
            loc_cProdutos = THIS.this_cProdutos

            loc_cSQL = "UPDATE SigPcOol" + ;
                       " SET dopes     = " + EscaparSQL(THIS.this_cDopes) + ;
                       ",    nopers    = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       ",    usuars    = " + EscaparSQL(THIS.this_cUsuars) + ;
                       ",    tipos     = " + EscaparSQL(THIS.this_cTipos) + ;
                       ",    processos = " + EscaparSQL(THIS.this_cProcessos) + ;
                       ",    produtos  = ?loc_cProdutos" + ;
                       ",    dopeds    = " + EscaparSQL(THIS.this_cDopeds) + ;
                       ",    edndests  = " + EscaparSQL(THIS.this_cEdndests) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro em SigPcOol." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar em SigPcOol:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega grupos de fornecedores (SigCdGcr) para grid filtro
    * Cria cursor_4c_Grupos com campos: codigos, descrs, marca (bool=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGrupos()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_lFalso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
            loc_lFalso = .F.
            loc_cSQL = "SELECT Codigos, Descrs, ?loc_lFalso AS marca FROM SigCdGcr" + ;
                       " WHERE PadPgRecs IN (4,2) ORDER BY Codigos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp") >= 1
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Grupos (codigos C(9) NULL, descrs C(40) NULL, marca L NULL)
                SET NULL OFF
                SELECT cursor_4c_Grupos
                APPEND FROM DBF("cursor_4c_GruposTemp")
                SELECT cursor_4c_Grupos
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar grupos de fornecedores." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Consulta operacoes de pagamento em SigMvCcr
    * Parametros:
    *   par_cCodEmp        - Codigo da empresa
    *   par_cCodConta      - Codigo da conta bancaria (get_cd_car_conta)
    *   par_dDatai         - Data inicial do periodo
    *   par_dDataf         - Data final do periodo
    *   par_lNaoProc       - .T.=Nao Processados, .F.=Ja Processados
    *   par_nPeriodo       - 1=Vencimento, 2=Emissao
    *   par_cGrupos        - Lista SQL de grupos marcados: ('GR1','GR2',...)
    * Cria cursor_4c_Filtro com registros de SigMvCcr+SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes(par_cCodEmp, par_cCodConta, par_dDatai, par_dDataf, ;
                               par_lNaoProc, par_nPeriodo, par_cGrupos)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampoPeriodo, loc_cNaoProc, loc_oErro
        LOCAL loc_dDatai, loc_dDataf, loc_lFalso
        loc_lSucesso = .F.
        TRY
            loc_dDatai = par_dDatai
            loc_dDataf = par_dDataf
            loc_lFalso = .F.

            IF par_nPeriodo = 1
                loc_cCampoPeriodo = "a.Vencs"
            ELSE
                loc_cCampoPeriodo = "a.Datas"
            ENDIF

            IF par_lNaoProc
                loc_cNaoProc = "NOT "
            ELSE
                loc_cNaoProc = ""
            ENDIF

            IF USED("cursor_4c_FiltroTemp")
                USE IN cursor_4c_FiltroTemp
            ENDIF

            loc_cSQL = "SELECT ?loc_lFalso AS marca, a.emps, a.datas, a.vencs, a.Valors, " + ;
                       "a.moedas, a.Hists + a.Titulos + a.Nfs AS histo, b.rclis, b.iclis, " + ;
                       "a.Grupos, a.contas, a.Nopers, a.Tipos, " + ;
                       "a.Contapgs, a.Dopes, a.ValPags, a.GruConMoes, a.Opers, " + ;
                       "a.cotacaos, a.cotusus, a.GrupEms, " + ;
                       "a.ContEms, a.GrupAges, a.ContAges, a.EmpDopNcs, a.Pagos, a.Titulos, a.Nfs, " + ;
                       "b.razaos, b.cpfs, b.endes, b.nums, b.bairs, b.cidas, b.ceps, b.estas, " + ;
                       "b.compls, b.tipochv, b.chvpix " + ;
                       "FROM SigMvCcr a, SigCdCli b " + ;
                       "WHERE a.pagos = 1 " + ;
                       "AND a.ContaPgs != 2 " + ;
                       "AND a.opers = 'C' " + ;
                       "AND " + loc_cCampoPeriodo + " BETWEEN ?loc_dDatai AND ?loc_dDataf " + ;
                       "AND a.Nopers <> 0 " + ;
                       "AND a.emps = " + EscaparSQL(par_cCodEmp) + " " + ;
                       "AND a.cidchaves IN (" + ;
                           "SELECT cidchaves FROM SigMvCcr " + ;
                           "WHERE grupos IN " + par_cGrupos + " " + ;
                           "AND " + loc_cCampoPeriodo + " BETWEEN ?loc_dDatai AND ?loc_dDataf" + ;
                       ") " + ;
                       "AND a.grupos = b.grupos " + ;
                       "AND a.contas = b.iclis " + ;
                       "AND a.nopers " + loc_cNaoProc + ;
                       "IN (SELECT e.nopers FROM SigPcOol e WHERE e.Tipos = 'SIGPGCNB' AND e.dopes = 'C') " + ;
                       "ORDER BY a.emps, " + loc_cCampoPeriodo

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FiltroTemp") >= 1
                IF USED("cursor_4c_Filtro")
                    IF USED("cursor_4c_Filtro")
                        TABLEREVERT(.T., "cursor_4c_Filtro")
                        USE IN cursor_4c_Filtro
                    ENDIF
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Filtro (marca L NULL, emps C(3) NULL, ;
                    datas D NULL, vencs D NULL, Valors N(14,2) NULL, moedas C(6) NULL, ;
                    histo C(60) NULL, rclis C(40) NULL, iclis C(10) NULL, ;
                    Grupos C(6) NULL, contas C(10) NULL, Nopers N(10,0) NULL, ;
                    Tipos C(6) NULL, Contapgs N(1,0) NULL, Dopes C(6) NULL, ;
                    ValPags N(14,2) NULL, GruConMoes C(6) NULL, Opers C(6) NULL, ;
                    cotacaos N(14,6) NULL, cotusus C(10) NULL, GrupEms C(6) NULL, ;
                    ContEms C(10) NULL, GrupAges C(6) NULL, ContAges C(10) NULL, ;
                    EmpDopNcs C(9) NULL, Pagos N(1,0) NULL, Titulos C(10) NULL, ;
                    Nfs C(9) NULL, razaos C(40) NULL, cpfs C(20) NULL, ;
                    endes C(40) NULL, nums C(6) NULL, bairs C(20) NULL, ;
                    cidas C(20) NULL, ceps C(9) NULL, estas C(2) NULL, ;
                    compls C(15) NULL, tipochv C(2) NULL, chvpix C(50) NULL)
                SET NULL OFF
                SELECT cursor_4c_Filtro
                APPEND FROM DBF("cursor_4c_FiltroTemp")
                SELECT cursor_4c_Filtro
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_FiltroTemp")
                USE IN cursor_4c_FiltroTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEmpresa - Carrega dados da empresa para geracao CNAB (SigCdEmp)
    * Parametro: par_cCodEmpConvenio - Codigo da empresa do convenio (Cemps)
    * Cria cursor_4c_Empresa com: RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros,
    *                              Bairs, Cidas, Estas, Compls
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEmpresa(par_cCodEmpConvenio)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cCodEmp
        loc_lSucesso = .F.
        TRY
            loc_cCodEmp = ALLTRIM(par_cCodEmpConvenio)
            IF USED("cursor_4c_EmpresaTemp")
                USE IN cursor_4c_EmpresaTemp
            ENDIF
            loc_cSQL = "SELECT RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros," + ;
                       " Bairs, Cidas, Estas, Compls" + ;
                       " FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCodEmp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresaTemp") >= 1
                IF USED("cursor_4c_Empresa")
                    USE IN cursor_4c_Empresa
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Empresa (RazSocs C(40) NULL, Cgcs C(20) NULL, ;
                    Tel1s C(14) NULL, Ceps C(9) NULL, Endes C(40) NULL, ;
                    Numeros C(6) NULL, Bairs C(20) NULL, Cidas C(20) NULL, ;
                    Estas C(2) NULL, Compls C(15) NULL)
                SET NULL OFF
                SELECT cursor_4c_Empresa
                APPEND FROM DBF("cursor_4c_EmpresaTemp")
                SELECT cursor_4c_Empresa
                GO TOP
                loc_lSucesso = !EOF("cursor_4c_Empresa")
            ELSE
                MostrarErro("Erro ao carregar dados da empresa " + loc_cCodEmp + "." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_EmpresaTemp")
                USE IN cursor_4c_EmpresaTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarEmpresa:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConvenio - Carrega dados do convenio bancario (SigCdCeb)
    * Parametros:
    *   par_cGruContas - Grupos+Contas concatenado (ex: crBancos.Grupos + lcconta)
    * Cria cursor_4c_Convenio com dados do SigCdCeb
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConvenio(par_cGruContas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cGruContas
        loc_lSucesso = .F.
        TRY
            loc_cGruContas = ALLTRIM(par_cGruContas)
            IF USED("cursor_4c_ConvenioTemp")
                USE IN cursor_4c_ConvenioTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb" + ;
                       " WHERE GruContas = " + EscaparSQL(loc_cGruContas) + ;
                       " AND NAgencias != ''" + ;
                       " ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConvenioTemp") >= 1
                IF USED("cursor_4c_Convenio")
                    USE IN cursor_4c_Convenio
                ENDIF
                SELECT cursor_4c_ConvenioTemp
                SELECT *, " " AS placeHolder FROM cursor_4c_ConvenioTemp INTO CURSOR cursor_4c_Convenio READWRITE
                SELECT cursor_4c_Convenio
                GO TOP
                loc_lSucesso = !EOF("cursor_4c_Convenio")
            ELSE
                MostrarErro("Erro ao carregar conv" + CHR(234) + "nio bancario." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_ConvenioTemp")
                USE IN cursor_4c_ConvenioTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarConvenio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContaBancaria - Carrega dados da conta do favorecido (SigCdCeb)
    * Parametros:
    *   par_cGruContas - Grupos+Contas do favorecido
    * Cria cursor_4c_ContaFav com dados do SigCdCeb
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContaBancaria(par_cGruContas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cGruContas
        loc_lSucesso = .F.
        TRY
            loc_cGruContas = ALLTRIM(par_cGruContas)
            IF USED("cursor_4c_ContaFavTemp")
                USE IN cursor_4c_ContaFavTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb" + ;
                       " WHERE GruContas = " + EscaparSQL(loc_cGruContas) + ;
                       " AND NAgencias != '' AND contas != '' AND nbancos != 0" + ;
                       " ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaFavTemp") >= 1
                IF USED("cursor_4c_ContaFav")
                    USE IN cursor_4c_ContaFav
                ENDIF
                SELECT cursor_4c_ContaFavTemp
                SELECT * FROM cursor_4c_ContaFavTemp INTO CURSOR cursor_4c_ContaFav READWRITE
                SELECT cursor_4c_ContaFav
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar conta do favorecido." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_ContaFavTemp")
                USE IN cursor_4c_ContaFavTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarContaBancaria:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContasBanco - Carrega contas do banco especificado (SigCdCeb)
    * Para buscaboleto: separa contas do mesmo banco vs outros bancos
    * Parametro: par_cBco - Codigo do banco FEBRABAN (ex: '341', '237', '033')
    * Cria cursor_4c_BancoIgual e cursor_4c_BancoDif
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContasBanco(par_cBco)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_cBco
        loc_lSucesso = .F.
        TRY
            loc_cBco = ALLTRIM(par_cBco)
            IF USED("cursor_4c_BancoIgualTemp")
                USE IN cursor_4c_BancoIgualTemp
            ENDIF
            IF USED("cursor_4c_BancoDifTemp")
                USE IN cursor_4c_BancoDifTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb WHERE nbancos = " + ALLTRIM(loc_cBco)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BancoIgualTemp") < 1
                MostrarErro("Erro ao carregar contas do banco " + loc_cBco + "." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "SELECT * FROM SigCdCeb WHERE nbancos != " + ALLTRIM(loc_cBco)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BancoDifTemp") < 1
                    MostrarErro("Erro ao carregar demais contas." + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_BancoIgual")
                        USE IN cursor_4c_BancoIgual
                    ENDIF
                    IF USED("cursor_4c_BancoDif")
                        USE IN cursor_4c_BancoDif
                    ENDIF
                    SELECT cursor_4c_BancoIgualTemp
                    SELECT * FROM cursor_4c_BancoIgualTemp INTO CURSOR cursor_4c_BancoIgual READWRITE
                    SELECT cursor_4c_BancoDifTemp
                    SELECT * FROM cursor_4c_BancoDifTemp INTO CURSOR cursor_4c_BancoDif READWRITE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_BancoIgualTemp")
                USE IN cursor_4c_BancoIgualTemp
            ENDIF
            IF USED("cursor_4c_BancoDifTemp")
                USE IN cursor_4c_BancoDifTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarContasBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarBarrasCcb - Busca codigo de barras de um titulo em SigMvCcb
    * Parametro: par_cFkChaves - chave fk (emps + str(nopers,10) + opers)
    * Retorna a string de barras ou "" se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarBarrasCcb(par_cFkChaves)
        LOCAL loc_cBarras, loc_cSQL, loc_oErro
        LOCAL loc_cFkChaves
        loc_cBarras = ""
        TRY
            loc_cFkChaves = ALLTRIM(par_cFkChaves)
            IF USED("cursor_4c_BarraTemp")
                USE IN cursor_4c_BarraTemp
            ENDIF
            loc_cSQL = "SELECT ccb_bars FROM SigMvCcb WHERE fkchaves = " + ;
                       EscaparSQL(loc_cFkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BarraTemp") >= 1
                SELECT cursor_4c_BarraTemp
                GO TOP
                IF !EOF("cursor_4c_BarraTemp")
                    loc_cBarras = NVL(cursor_4c_BarraTemp.ccb_bars, "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_BarraTemp")
                USE IN cursor_4c_BarraTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarBarrasCcb:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cBarras
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGruposContaCli - Carrega grupos de uma conta (SigCdCli)
    * Parametro: par_cIClis - Codigo da conta (IClis)
    * Retorna valor do campo Grupos ou ""
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGruposContaCli(par_cIClis)
        LOCAL loc_cGrupos, loc_cSQL, loc_oErro
        LOCAL loc_cIClis
        loc_cGrupos = ""
        TRY
            loc_cIClis = ALLTRIM(par_cIClis)
            IF USED("cursor_4c_CliGrupoTemp")
                USE IN cursor_4c_CliGrupoTemp
            ENDIF
            loc_cSQL = "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cIClis)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliGrupoTemp") >= 1
                SELECT cursor_4c_CliGrupoTemp
                GO TOP
                IF !EOF("cursor_4c_CliGrupoTemp")
                    loc_cGrupos = NVL(ALLTRIM(cursor_4c_CliGrupoTemp.Grupos), "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_CliGrupoTemp")
                USE IN cursor_4c_CliGrupoTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarGruposContaCli:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cGrupos
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTituloBanco - Atualiza titbans em SigMvCcr apos geracao CNAB
    * Parametros:
    *   par_nNopers - Numero da operacao
    *   par_cTitulo - Titulo banco para gravar (ex: 'TIT ITAU')
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTituloBanco(par_nNopers, par_cTitulo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_nNopers
        loc_lSucesso = .F.
        TRY
            loc_nNopers = par_nNopers
            loc_cSQL = "UPDATE SigMvCcr SET titbans = " + EscaparSQL(par_cTitulo) + ;
                       " WHERE opers = 'C' AND nopers = ?loc_nNopers"
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar t" + CHR(237) + "tulo banco." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em AtualizarTituloBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTituloBanco - Verifica titbans existente em SigMvCcr
    * Parametro: par_nNopers - Numero da operacao
    * Retorna o titbans atual ou ""
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTituloBanco(par_nNopers)
        LOCAL loc_cTitulo, loc_cSQL, loc_oErro
        LOCAL loc_nNopers
        loc_cTitulo = ""
        TRY
            loc_nNopers = par_nNopers
            IF USED("cursor_4c_TitBanTemp")
                USE IN cursor_4c_TitBanTemp
            ENDIF
            loc_cSQL = "SELECT titulos, titbans FROM SigMvCcr WHERE opers = 'C' AND nopers = ?loc_nNopers"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitBanTemp") >= 1
                SELECT cursor_4c_TitBanTemp
                GO TOP
                IF !EOF("cursor_4c_TitBanTemp")
                    loc_cTitulo = NVL(ALLTRIM(cursor_4c_TitBanTemp.titbans), "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_TitBanTemp")
                USE IN cursor_4c_TitBanTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarTituloBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cTitulo
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave unica para cidchaves usando fUniqueIds()
    * Retorna a chave gerada como string
    *--------------------------------------------------------------------------
    PROCEDURE GerarChaveUnica()
        RETURN ALLTRIM(fUniqueIds())
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLinhaArquivo - Insere uma linha do arquivo CNAB em SigPcOol
    * Chamado pelas procedures de geracao CNAB no FormSIGPGCNB
    * Parametros:
    *   par_cDopes    - Tipo operacao ('C')
    *   par_nNopers   - Numero da operacao em SigMvCcr
    *   par_cProdutos - Conteudo da linha CNAB gerada
    *   par_cDopeds   - Referencia do documento (titulo)
    *   par_cEdndests - Chave destino (titulo+nopers)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLinhaArquivo(par_cDopes, par_nNopers, par_cProdutos, par_cDopeds, par_cEdndests)
        THIS.this_cDopes    = par_cDopes
        THIS.this_nNopers   = par_nNopers
        THIS.this_cProdutos = par_cProdutos
        THIS.this_cDopeds   = par_cDopeds
        THIS.this_cEdndests = par_cEdndests
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE

