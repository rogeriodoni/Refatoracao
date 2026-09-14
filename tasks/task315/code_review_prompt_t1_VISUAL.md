# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'optProcessados' (parent: SIGPRNSE): Top original=100 vs migrado 'obj_4c_OptProcessados' Top=-1 (diff=101px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optProcessados' (parent: SIGPRNSE): Left original=127 vs migrado 'obj_4c_OptProcessados' Left=5 (diff=122px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRNSE.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1417 linhas total):

*-- Linhas 48 a 56:
48:         LOCAL loc_lSucesso, loc_oErro
49:         loc_lSucesso = .F.
50: 
51:         THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o de NF-e Municipal"
52: 
53:         TRY
54:             THIS.ConfigurarPageFrame()
55:             THIS.ConfigurarCabecalho()
56:             THIS.ConfigurarBotoesForm()

*-- Linhas 101 a 149:
101:         THIS.AddObject("cnt_4c_Sombra", "Container")
102:         loc_oCnt = THIS.cnt_4c_Sombra
103:         WITH loc_oCnt
104:             .Top         = 0
105:             .Left        = 0
106:             .Width       = 1068
107:             .Height      = 80
108:             .BorderWidth = 0
109:             .BackStyle   = 1
110:             .BackColor   = RGB(100, 100, 100)
111:         ENDWITH
112: 
113:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
114:         WITH loc_oCnt.lbl_4c_LblSombra
115:             .AutoSize    = .F.
116:             .Width       = THIS.Width
117:             .FontBold    = .T.
118:             .FontName    = "Tahoma"
119:             .FontSize    = 18
120:             .FontUnderline = .F.
121:             .WordWrap    = .T.
122:             .Alignment   = 0
123:             .BackStyle   = 0
124:             .Caption     = loc_cTitulo
125:             .Height      = 40
126:             .Left        = 10
127:             .Top         = 18
128:             .ForeColor   = RGB(0, 0, 0)
129:         ENDWITH
130: 
131:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
132:         WITH loc_oCnt.lbl_4c_LblTitulo
133:             .AutoSize    = .F.
134:             .Width       = THIS.Width
135:             .FontBold    = .T.
136:             .FontName    = "Tahoma"
137:             .FontSize    = 18
138:             .WordWrap    = .T.
139:             .Alignment   = 0
140:             .BackStyle   = 0
141:             .Caption     = loc_cTitulo
142:             .Height      = 46
143:             .Left        = 10
144:             .Top         = 17
145:             .ForeColor   = RGB(255, 255, 255)
146:             .ToolTipText = "T" + CHR(237) + "tulo"
147:         ENDWITH
148:     ENDPROC
149: 

*-- Linhas 158 a 218:
158:             .BorderStyle = 0
159:             .Value       = 1
160:             .Height      = 110
161:             .Left        = 742
162:             .Top         = -2
163:             .Width       = 251
164:             .Themes      = .F.
165:             WITH .Buttons(1)
166:                 .Top             = 5
167:                 .Left            = 11
168:                 .Height          = 75
169:                 .Width           = 75
170:                 .FontBold        = .T.
171:                 .FontItalic      = .T.
172:                 .FontName        = "Comic Sans MS"
173:                 .FontSize        = 8
174:                 .WordWrap        = .T.
175:                 .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
176:                 .Caption         = "Limpar Sele" + CHR(231) + CHR(227) + "o"
177:                 .ToolTipText     = "Limpar a Sele" + CHR(231) + CHR(227) + "o da Grade Abaixo"
178:                 .PicturePosition = 7
179:                 .ForeColor       = RGB(90, 90, 90)
180:                 .BackColor       = RGB(255, 255, 255)
181:                 .Themes          = .F.
182:             ENDWITH
183:             WITH .Buttons(2)
184:                 .Top             = 5
185:                 .Left            = 86
186:                 .Height          = 75
187:                 .Width           = 75
188:                 .FontBold        = .T.
189:                 .FontItalic      = .T.
190:                 .FontName        = "Comic Sans MS"
191:                 .FontSize        = 8
192:                 .WordWrap        = .T.
193:                 .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
194:                 .Caption         = "Gerar Arquivo"
195:                 .ToolTipText     = "Gerar o Arquivo de Integra" + CHR(231) + CHR(227) + "o"
196:                 .PicturePosition = 7
197:                 .ForeColor       = RGB(90, 90, 90)
198:                 .BackColor       = RGB(255, 255, 255)
199:                 .Themes          = .F.
200:             ENDWITH
201:             WITH .Buttons(3)
202:                 .Top             = 5
203:                 .Left            = 161
204:                 .Height          = 75
205:                 .Width           = 75
206:                 .FontBold        = .T.
207:                 .FontItalic      = .T.
208:                 .FontName        = "Comic Sans MS"
209:                 .FontSize        = 8
210:                 .WordWrap        = .T.
211:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
212:                 .Cancel          = .T.
213:                 .Caption         = "Sair do Processo"
214:                 .ToolTipText     = "[ESC] Sair"
215:                 .PicturePosition = 7
216:                 .ForeColor       = RGB(90, 90, 90)
217:                 .BackColor       = RGB(255, 255, 255)
218:                 .Themes          = .F.

*-- Linhas 228 a 332:
228:             .BackStyle   = 0
229:             .BorderStyle = 0
230:             .Height      = 15
231:             .Left        = 127
232:             .Top         = 100
233:             .Width       = 235
234:             .Value       = 1
235:             WITH .Buttons(1)
236:                 .BackStyle = 0
237:                 .Caption   = "N" + CHR(227) + "o Processadas"
238:                 .FontName        = "Comic Sans MS"
239:                 .FontSize        = 8
240:                 .Left      = 5
241:                 .Top       = -1
242:                 .AutoSize  = .T.
243:                 .ForeColor = RGB(90, 90, 90)
244:             ENDWITH
245:             WITH .Buttons(2)
246:                 .FontName  = "Comic Sans MS"
247:                 .FontSize  = 8
248:                 .BackStyle = 0
249:                 .Caption   = "J" + CHR(225) + " Processadas"
250:                 .Left      = 126
251:                 .Top       = -1
252:                 .AutoSize  = .T.
253:                 .ForeColor = RGB(90, 90, 90)
254:             ENDWITH
255:         ENDWITH
256: 
257:         *-- Label: Periodo
258:         THIS.AddObject("lbl_4c_Label1", "Label")
259:         WITH THIS.lbl_4c_Label1
260:             .Caption    = "Per" + CHR(237) + "odo :"
261:             .FontName   = "Verdana"
262:             .FontSize   = 8
263:             .FontItalic = .F.
264:             .BackStyle  = 0
265:             .ForeColor  = RGB(90, 90, 90)
266:             .Left       = 79
267:             .Top        = 123
268:         ENDWITH
269: 
270:         *-- TextBox: Data Inicial
271:         THIS.AddObject("txt_4c_DtIni", "TextBox")
272:         WITH THIS.txt_4c_DtIni
273:             .Left              = 134
274:             .Top               = 119
275:             .Height            = 23
276:             .Width             = 75
277:             .SpecialEffect     = 1
278:             .ToolTipText       = "Data Inicial Para Sele" + CHR(231) + CHR(227) + "o das Notas"
279:             .BorderColor       = RGB(90, 90, 90)
280:             .DisabledBackColor = RGB(255, 255, 255)
281:             .DisabledForeColor = RGB(36, 84, 155)
282:         ENDWITH
283: 
284:         *-- Label: ate
285:         THIS.AddObject("lbl_4c_Label2", "Label")
286:         WITH THIS.lbl_4c_Label2
287:             .Caption    = "at" + CHR(233)
288:             .FontName   = "Tahoma"
289:             .FontSize   = 8
290:             .FontItalic = .F.
291:             .BackStyle  = 0
292:             .ForeColor  = RGB(90, 90, 90)
293:             .Left       = 217
294:             .Top        = 123
295:         ENDWITH
296: 
297:         *-- TextBox: Data Final
298:         THIS.AddObject("txt_4c_DtFin", "TextBox")
299:         WITH THIS.txt_4c_DtFin
300:             .Left              = 240
301:             .Top               = 119
302:             .Height            = 23
303:             .Width             = 75
304:             .SpecialEffect     = 1
305:             .ToolTipText       = "Data Final Para Sele" + CHR(231) + CHR(227) + "o das Notas"
306:             .BorderColor       = RGB(90, 90, 90)
307:             .DisabledBackColor = RGB(255, 255, 255)
308:             .DisabledForeColor = RGB(36, 84, 155)
309:         ENDWITH
310: 
311:         *-- Label: Empresa
312:         THIS.AddObject("lbl_4c_Label4", "Label")
313:         WITH THIS.lbl_4c_Label4
314:             .Caption    = "Empresa :"
315:             .FontName   = "Verdana"
316:             .FontSize   = 8
317:             .FontItalic = .F.
318:             .ForeColor  = RGB(90, 90, 90)
319:             .Left       = 72
320:             .Top        = 149
321:         ENDWITH
322: 
323:         *-- TextBox: Codigo da Empresa
324:         THIS.AddObject("txt_4c_CEmps", "TextBox")
325:         WITH THIS.txt_4c_CEmps
326:             .Left              = 134
327:             .Top               = 145
328:             .Width             = 31
329:             .Height            = 23
330:             .MaxLength         = 3
331:             .SpecialEffect     = 1
332:             .ToolTipText       = "Empresa Para Filtro das Notas"

*-- Linhas 338 a 403:
338:         *-- TextBox: Descricao da Empresa (somente leitura - populada por ValidarEmpresa)
339:         THIS.AddObject("txt_4c_DEmps", "TextBox")
340:         WITH THIS.txt_4c_DEmps
341:             .Left              = 168
342:             .Top               = 145
343:             .Width             = 305
344:             .Height            = 23
345:             .SpecialEffect     = 1
346:             .ReadOnly          = .T.
347:             .DisabledBackColor = RGB(255, 255, 255)
348:             .DisabledForeColor = RGB(36, 84, 155)
349:             .BorderColor       = RGB(90, 90, 90)
350:         ENDWITH
351: 
352:         *-- Label: Municipio
353:         THIS.AddObject("lbl_4c_Label3", "Label")
354:         WITH THIS.lbl_4c_Label3
355:             .Caption    = "Munic" + CHR(237) + "pio :"
356:             .FontName   = "Verdana"
357:             .FontSize   = 8
358:             .FontItalic = .F.
359:             .ForeColor  = RGB(90, 90, 90)
360:             .Left       = 70
361:             .Top        = 175
362:         ENDWITH
363: 
364:         *-- ComboBox: Cidades (RJ / SP)
365:         THIS.AddObject("cbo_4c_CmbCidades", "ComboBox")
366:         WITH THIS.cbo_4c_CmbCidades
367:             .FontName          = "Courier New"
368:             .RowSourceType     = 1
369:             .RowSource         = "RJ - Rio de Janeiro,SP - S" + CHR(227) + "o Paulo"
370:             .BoundTo           = .T.
371:             .Style             = 2
372:             .SpecialEffect     = 1
373:             .Left              = 134
374:             .Top               = 171
375:             .Width             = 339
376:             .Height            = 22
377:             .DisabledBackColor = RGB(255, 255, 255)
378:             .DisabledForeColor = RGB(36, 84, 155)
379:             .BorderColor       = RGB(90, 90, 90)
380:         ENDWITH
381: 
382:         *-- Label: Pasta do Arquivo
383:         THIS.AddObject("lbl_4c_Label5", "Label")
384:         WITH THIS.lbl_4c_Label5
385:             .Caption    = "Pasta do Arquivo :"
386:             .FontName   = "Verdana"
387:             .FontSize   = 8
388:             .FontItalic = .F.
389:             .ForeColor  = RGB(90, 90, 90)
390:             .Left       = 25
391:             .Top        = 200
392:         ENDWITH
393: 
394:         *-- TextBox: Diretorio de gravacao (somente via btn_4c_BtnDirs)
395:         THIS.AddObject("txt_4c_Dirs", "TextBox")
396:         WITH THIS.txt_4c_Dirs
397:             .Left              = 134
398:             .Top               = 196
399:             .Width             = 421
400:             .Height            = 23
401:             .SpecialEffect     = 1
402:             .ReadOnly          = .T.
403:             .ToolTipText       = "Diret" + CHR(243) + "rio / Pasta de grava" + CHR(231) + CHR(227) + "o do Arquivo"

*-- Linhas 409 a 448:
409: 
410:     *--------------------------------------------------------------------------
411:     PROTECTED PROCEDURE ConfigurarBotaoDirs()
412:         THIS.AddObject("cmd_4c_BtnDirs", "CommandButton")
413:         WITH THIS.cmd_4c_BtnDirs
414:             .Top             = 192
415:             .Left            = 558
416:             .Height          = 30
417:             .Width           = 32
418:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
419:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
420:             .Caption         = ""
421:             .ToolTipText     = "Carregar o Diret" + CHR(243) + "rio / Pasta de Grava" + ;
422:                                CHR(231) + CHR(227) + "o do Arquivo"
423:             .PicturePosition = 13
424:             .Themes          = .T.
425:         ENDWITH
426:     ENDPROC
427: 
428:     *--------------------------------------------------------------------------
429:     PROTECTED PROCEDURE ConfigurarBotaoSelecionar()
430:         THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
431:         WITH THIS.cmd_4c_Selecionar
432:             .Top             = 106
433:             .Left            = 484
434:             .Height          = 75
435:             .Width           = 75
436:             .FontBold        = .T.
437:             .FontItalic      = .T.
438:             .FontName        = "Tahoma"
439:             .FontSize        = 8
440:             .WordWrap        = .T.
441:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
442:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
443:             .Caption         = "\<Selecionar Notas"
444:             .ToolTipText     = "Seleciona as Notas Conforme os Filtros Digitados"
445:             .PicturePosition = 7
446:             .ForeColor       = RGB(90, 90, 90)
447:             .BackColor       = RGB(255, 255, 255)
448:             .Themes          = .T.

*-- Linhas 455 a 488:
455:         THIS.AddObject("grd_4c_Dados", "Grid")
456:         loc_oGrd = THIS.grd_4c_Dados
457:         WITH loc_oGrd
458:             .Left              = 21
459:             .Top               = 230
460:             .Width             = 929
461:             .Height            = 346
462:             .ColumnCount       = 11
463:             .RecordSource      = "csOperacoes"
464:             .HeaderHeight      = 19
465:             .DeleteMark        = .F.
466:             .RecordMark        = .F.
467:             .ReadOnly          = .F.
468:             .ScrollBars        = 2
469:             .AllowHeaderSizing = .F.
470:             .AllowRowSizing    = .F.
471: 
472:             *-- Coluna 1: checkbox SelImp (ControlSource definido APOS CurrentControl)
473:             WITH .Column1
474:                 .Width         = 15
475:                 .Movable       = .F.
476:                 .Resizable     = .F.
477:                 .ReadOnly      = .F.
478:                 .Sparse        = .F.
479:                 WITH .Header1
480:                     .FontName  = "Verdana"
481:                     .FontSize  = 8
482:                     .Alignment = 2
483:                     .Caption   = ""
484:                 ENDWITH
485:             ENDWITH
486: 
487:             *-- Coluna 2: Codigo (Numes)
488:             WITH .Column2

*-- Linhas 496 a 504:
496:                     .FontName  = "Verdana"
497:                     .FontSize  = 8
498:                     .Alignment = 2
499:                     .Caption   = "C" + CHR(243) + "digo"
500:                 ENDWITH
501:             ENDWITH
502: 
503:             *-- Coluna 3: Data
504:             WITH .Column3

*-- Linhas 512 a 520:
512:                     .FontName  = "Verdana"
513:                     .FontSize  = 8
514:                     .Alignment = 2
515:                     .Caption   = "Data"
516:                 ENDWITH
517:             ENDWITH
518: 
519:             *-- Coluna 4: Valor
520:             WITH .Column4

*-- Linhas 528 a 536:
528:                     .FontName  = "Verdana"
529:                     .FontSize  = 8
530:                     .Alignment = 2
531:                     .Caption   = "Valor"
532:                 ENDWITH
533:             ENDWITH
534: 
535:             *-- Coluna 5: Documento (NFis)
536:             WITH .Column5

*-- Linhas 544 a 552:
544:                     .FontName  = "Verdana"
545:                     .FontSize  = 8
546:                     .Alignment = 2
547:                     .Caption   = "Documento"
548:                 ENDWITH
549:             ENDWITH
550: 
551:             *-- Coluna 6: Usuario
552:             WITH .Column6

*-- Linhas 560 a 568:
560:                     .FontName  = "Verdana"
561:                     .FontSize  = 8
562:                     .Alignment = 2
563:                     .Caption   = "Usu" + CHR(225) + "rio"
564:                 ENDWITH
565:             ENDWITH
566: 
567:             *-- Coluna 7: Origem (ContaOs)
568:             WITH .Column7

*-- Linhas 576 a 584:
576:                     .FontName  = "Verdana"
577:                     .FontSize  = 8
578:                     .Alignment = 2
579:                     .Caption   = "Origem"
580:                 ENDWITH
581:             ENDWITH
582: 
583:             *-- Coluna 8: Destino (ContaDs)
584:             WITH .Column8

*-- Linhas 592 a 600:
592:                     .FontName  = "Verdana"
593:                     .FontSize  = 8
594:                     .Alignment = 2
595:                     .Caption   = "Destino"
596:                 ENDWITH
597:             ENDWITH
598: 
599:             *-- Coluna 9: Empresa (Emps)
600:             WITH .Column9

*-- Linhas 608 a 616:
608:                     .FontName  = "Verdana"
609:                     .FontSize  = 8
610:                     .Alignment = 2
611:                     .Caption   = "Emp"
612:                 ENDWITH
613:             ENDWITH
614: 
615:             *-- Coluna 10: E/S (Operas)
616:             WITH .Column10

*-- Linhas 624 a 632:
624:                     .FontName  = "Verdana"
625:                     .FontSize  = 8
626:                     .Alignment = 2
627:                     .Caption   = "E / S"
628:                 ENDWITH
629:             ENDWITH
630: 
631:             *-- Coluna 11: Movimentacao (Dopes)
632:             WITH .Column11

*-- Linhas 640 a 666:
640:                     .FontName  = "Verdana"
641:                     .FontSize  = 8
642:                     .Alignment = 2
643:                     .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
644:                 ENDWITH
645:             ENDWITH
646: 
647:             *-- Cor vermelha quando ha erros na linha
648:             .SetAll("DynamicForeColor", ;
649:                     "IIF(EMPTY(ALLTRIM(csOperacoes.Erros)), RGB(0,0,0), RGB(255,0,0))", ;
650:                     "Column")
651:         ENDWITH
652: 
653:         *-- Adiciona CheckBox na coluna 1 (fora do WITH para evitar problema de AddObject aninhado)
654:         loc_oGrd.Column1.AddObject("chk_4c_SelImp", "CheckBox")
655:         WITH loc_oGrd.Column1.chk_4c_SelImp
656:             .Caption    = ""
657:             .AutoSize   = .T.
658:             .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
659:         ENDWITH
660:         loc_oGrd.Column1.CurrentControl = "chk_4c_SelImp"
661:         *-- ControlSource DEVE ser definido APOS CurrentControl (regra CheckBox em Grid)
662:         loc_oGrd.Column1.ControlSource  = "csOperacoes.SelImp"
663:     ENDPROC
664: 
665:     *--------------------------------------------------------------------------
666:     PROTECTED PROCEDURE ConfigurarBotoesGrade()

*-- Linhas 673 a 788:
673:             .BorderStyle = 0
674:             .Value       = 1
675:             .Height      = 135
676:             .Left        = 957
677:             .Top         = 339
678:             .Width       = 43
679:             .Themes      = .F.
680:             WITH .Buttons(1)
681:                 .Top           = -1
682:                 .Left          = -1
683:                 .Height        = 45
684:                 .Width         = 45
685:                 .FontName      = "Verdana"
686:                 .FontSize      = 8
687:                 .Picture       = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
688:                 .Caption       = ""
689:                 .ToolTipText   = "Selecionar"
690:                 .ForeColor     = RGB(36, 84, 155)
691:                 .BackColor     = RGB(255, 255, 255)
692:                 .Themes        = .F.
693:             ENDWITH
694:             WITH .Buttons(2)
695:                 .Top           = 45
696:                 .Left          = -1
697:                 .Height        = 45
698:                 .Width         = 45
699:                 .FontName      = "Verdana"
700:                 .FontSize      = 8
701:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
702:                 .Caption       = ""
703:                 .ToolTipText   = "Desmarcar"
704:                 .ForeColor     = RGB(36, 84, 155)
705:                 .BackColor     = RGB(255, 255, 255)
706:                 .Themes        = .F.
707:             ENDWITH
708:             WITH .Buttons(3)
709:                 .Top           = 91
710:                 .Left          = -1
711:                 .Height        = 45
712:                 .Width         = 45
713:                 .FontName      = "Verdana"
714:                 .FontSize      = 8
715:                 .Picture       = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
716:                 .Caption       = ""
717:                 .WordWrap        = .T.
718:                 .ToolTipText   = "Documento"
719:                 .ForeColor     = RGB(36, 84, 155)
720:                 .BackColor     = RGB(255, 255, 255)
721:                 .Themes        = .F.
722:             ENDWITH
723:         ENDWITH
724:     ENDPROC
725: 
726:     *--------------------------------------------------------------------------
727:     PROTECTED PROCEDURE ConfigurarErros()
728:         THIS.AddObject("lbl_4c_Label6", "Label")
729:         WITH THIS.lbl_4c_Label6
730:             .Caption    = "Erros dos Dados"
731:             .FontName   = "Verdana"
732:             .FontSize   = 8
733:             .FontItalic = .F.
734:             .ForeColor  = RGB(255, 255, 255)
735:             .Left       = 21
736:             .Top        = 580
737:         ENDWITH
738: 
739:         THIS.AddObject("edt_4c_Erros", "EditBox")
740:         WITH THIS.edt_4c_Erros
741:             .Left          = 21
742:             .Top           = 595
743:             .Width         = 929
744:             .Height        = 77
745:             .SpecialEffect = 1
746:             .ReadOnly      = .T.
747:             .ControlSource = "csOperacoes.Erros"
748:             .BorderColor   = RGB(90, 90, 90)
749:         ENDWITH
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     PROTECTED PROCEDURE TornarControlesVisiveis()
754:         THIS.cnt_4c_Sombra.Visible                      = .T.
755:         THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Visible    = .T.
756:         THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Visible    = .T.
757:         THIS.cmg_4c_Botoes.Visible                      = .T.
758:         THIS.obj_4c_OptProcessados.Visible              = .T.
759:         THIS.lbl_4c_Label1.Visible                      = .T.
760:         THIS.txt_4c_DtIni.Visible                       = .T.
761:         THIS.lbl_4c_Label2.Visible                      = .T.
762:         THIS.txt_4c_DtFin.Visible                       = .T.
763:         THIS.lbl_4c_Label4.Visible                      = .T.
764:         THIS.txt_4c_CEmps.Visible                       = .T.
765:         THIS.txt_4c_DEmps.Visible                       = .T.
766:         THIS.lbl_4c_Label3.Visible                      = .T.
767:         THIS.cbo_4c_CmbCidades.Visible                  = .T.
768:         THIS.lbl_4c_Label5.Visible                      = .T.
769:         THIS.txt_4c_Dirs.Visible                        = .T.
770:         THIS.cmd_4c_BtnDirs.Visible                     = .T.
771:         THIS.cmd_4c_Selecionar.Visible                  = .T.
772:         THIS.grd_4c_Dados.Visible                       = .T.
773:         THIS.cmg_4c_Grade.Visible                       = .T.
774:         THIS.lbl_4c_Label6.Visible                      = .T.
775:         THIS.edt_4c_Erros.Visible                       = .T.
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
780:         BINDEVENT(THIS.cmd_4c_Selecionar, "Click",             THIS, "BtnSelecionarClick")
781:         BINDEVENT(THIS.cmg_4c_Botoes,     "Click",             THIS, "CmgBotoesClick")
782:         BINDEVENT(THIS.cmg_4c_Grade,      "Click",             THIS, "CmgGradeClick")
783:         BINDEVENT(THIS.cmd_4c_BtnDirs,    "Click",             THIS, "BtnDirsClick")
784:         BINDEVENT(THIS.txt_4c_CEmps,      "KeyPress",          THIS, "TxtCEmpsKeyPress")
785:         BINDEVENT(THIS.grd_4c_Dados,      "AfterRowColChange",  THIS, "GradeAfterRowColChange")
786:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_SelImp, "MouseDown", THIS, "CheckMouseDown")
787:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_SelImp, "KeyPress",  THIS, "CheckKeyPress")
788:     ENDPROC

*-- Linhas 815 a 825:
815:             .txt_4c_CEmps.Enabled                     = loc_lEntrada
816:             .txt_4c_DEmps.Enabled                     = loc_lEntrada
817:             .cbo_4c_CmbCidades.Enabled                = loc_lEntrada
818:             .cmd_4c_Selecionar.Enabled                = loc_lEntrada
819:             .txt_4c_Dirs.Enabled                      = loc_lEntrada
820:             .cmd_4c_BtnDirs.Enabled                   = loc_lEntrada
821: 
822:             .cmg_4c_Botoes.Buttons(1).Enabled         = !loc_lEntrada
823:             .cmg_4c_Botoes.Buttons(2).Enabled         = !loc_lEntrada
824:             .cmg_4c_Grade.Buttons(1).Enabled          = !loc_lEntrada
825:             .cmg_4c_Grade.Buttons(2).Enabled          = !loc_lEntrada

*-- Linhas 1040 a 1048:
1040:     ENDPROC
1041: 
1042:     *==========================================================================
1043:     * CheckMouseDown - toggle do checkbox de selecao via clique do mouse
1044:     *==========================================================================
1045:     PROCEDURE CheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1046:         IF USED("csOperacoes") AND !EOF("csOperacoes")
1047:             IF EMPTY(ALLTRIM(csOperacoes.Erros))
1048:                 SELECT csOperacoes

*-- Linhas 1054 a 1062:
1054:     ENDPROC
1055: 
1056:     *==========================================================================
1057:     * CheckKeyPress - toggle do checkbox via Enter ou Espaco
1058:     *==========================================================================
1059:     PROCEDURE CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1060:         IF INLIST(par_nKeyCode, 13, 32)
1061:             IF USED("csOperacoes") AND !EOF("csOperacoes")
1062:                 IF EMPTY(ALLTRIM(csOperacoes.Erros))

*-- Linhas 1317 a 1326:
1317:         WITH THIS.this_oBusinessObject
1318:             THIS.txt_4c_CEmps.Value            = ALLTRIM(.this_cEmps)
1319:             THIS.txt_4c_DEmps.Value            = ALLTRIM(.this_cDEmps)
1320:             THIS.txt_4c_DtIni.Value            = .this_dDtIni
1321:             THIS.txt_4c_DtFin.Value            = .this_dDtFin
1322:             THIS.cbo_4c_CmbCidades.Value       = ALLTRIM(.this_cCidade)
1323:             THIS.txt_4c_Dirs.Value             = ALLTRIM(.this_cDirs)
1324:             THIS.obj_4c_OptProcessados.Value   = IIF(.this_nProcessados = 2, 2, 1)
1325:         ENDWITH
1326:     ENDPROC

