# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 297: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 320: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 343: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 362: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1821 linhas total):

*-- Linhas 55 a 64:
55: 
56:                 THIS.ConfigurarPageFrame()
57: 
58:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                 THIS.TornarControlesVisiveis(THIS)
62: 
63:                 THIS.cnt_4c_Resultado.Visible                 = .F.
64:                 THIS.cnt_4c_Resultado.cnt_4c_Detalhe.Visible  = .F.

*-- Linhas 74 a 85:
74: 
75:                 BINDEVENT(THIS.txt_4c_Demonstrativo, "KeyPress", THIS, "DemonstrativoKeyPress")
76:                 BINDEVENT(THIS.txt_4c_Demonstrativo, "DblClick", THIS, "AbrirLookupDemonstrativo")
77:                 BINDEVENT(THIS.cmd_4c_Processar,     "Click",    THIS, "CmdProcessarClick")
78:                 BINDEVENT(THIS.cmd_4c_Visualizar,    "Click",    THIS, "CmdVisualizarClick")
79:                 BINDEVENT(THIS.cmd_4c_Imprimir,      "Click",    THIS, "CmdImprimirClick")
80:                 BINDEVENT(THIS.cmd_4c_Encerrar,      "Click",    THIS, "CmdEncerrarClick")
81: 
82:                 loc_lSucesso = .T.
83:             ELSE
84:                 MsgErro("Erro ao criar SigPrFemBO.", ;
85:                     "Erro de Inicializa" + CHR(231) + CHR(227) + "o")

*-- Linhas 117 a 164:
117: 
118:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH THIS.cnt_4c_Cabecalho
120:             .Top         = 0
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackStyle   = 1
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127: 
128:             .AddObject("lbl_4c_Sombra", "Label")
129:             WITH .lbl_4c_Sombra
130:                 .AutoSize  = .F.
131:                 .Top       = 18
132:                 .Left      = 10
133:                 .Width     = THIS.Width
134:                 .Height    = 40
135:                 .BackStyle = 0
136:                 .FontBold  = .T.
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 18
139:                 .ForeColor = RGB(0, 0, 0)
140:                 .WordWrap  = .T.
141:                 .Alignment = 0
142:                 .Caption   = loc_cCaption
143:             ENDWITH
144: 
145:             .AddObject("lbl_4c_Titulo", "Label")
146:             WITH .lbl_4c_Titulo
147:                 .AutoSize  = .F.
148:                 .Top       = 17
149:                 .Left      = 10
150:                 .Width     = THIS.Width
151:                 .Height    = 46
152:                 .BackStyle = 0
153:                 .FontBold  = .T.
154:                 .FontName  = "Tahoma"
155:                 .FontSize  = 18
156:                 .ForeColor = RGB(255, 255, 255)
157:                 .WordWrap  = .T.
158:                 .Alignment = 0
159:                 .Caption   = loc_cCaption
160:             ENDWITH
161:         ENDWITH
162:     ENDPROC
163: 
164:     *==========================================================================

*-- Linhas 171 a 369:
171:         *-- Shape2: delimitador visual da area de video/impressao
172:         THIS.AddObject("shp_4c_Shape2", "Shape")
173:         WITH THIS.shp_4c_Shape2
174:             .Top           = 7
175:             .Left          = 667
176:             .Height        = 75
177:             .Width         = 146
178:             .BackStyle     = 0
179:             .BorderStyle   = 0
180:             .SpecialEffect = 1
181:             .BorderColor   = RGB(136, 189, 188)
182:         ENDWITH
183: 
184:         *-- Shape1: delimitador visual da area de processar/encerrar
185:         THIS.AddObject("shp_4c_Shape1", "Shape")
186:         WITH THIS.shp_4c_Shape1
187:             .Top         = 8
188:             .Left        = 816
189:             .Height      = 110
190:             .Width       = 173
191:             .BackStyle   = 0
192:             .BorderStyle = 0
193:             .BorderColor = RGB(136, 189, 188)
194:         ENDWITH
195: 
196:         *-- Label "Periodo :"
197:         THIS.AddObject("lbl_4c_Periodo", "Label")
198:         WITH THIS.lbl_4c_Periodo
199:             .AutoSize  = .T.
200:             .FontName  = "Tahoma"
201:             .FontSize  = 8
202:             .BackStyle = 0
203:             .Caption   = "Per" + CHR(237) + "odo :"
204:             .Left      = 398
205:             .Top       = 90
206:             .Height    = 15
207:             .ForeColor = RGB(90, 90, 90)
208:         ENDWITH
209: 
210:         *-- Data Inicial
211:         THIS.AddObject("txt_4c_DataI", "TextBox")
212:         WITH THIS.txt_4c_DataI
213:             .FontName      = "Tahoma"
214:             .FontSize      = 8
215:             .Height        = 25
216:             .Left          = 445
217:             .Top           = 86
218:             .Width         = 80
219:             .Format        = "K"
220:             .MaxLength     = 10
221:             .SpecialEffect = 1
222:             .BorderColor   = RGB(100, 100, 100)
223:             .Value         = {}
224:             .TabIndex      = 2
225:         ENDWITH
226: 
227:         *-- Separador entre as datas
228:         THIS.AddObject("lbl_4c_Separador", "Label")
229:         WITH THIS.lbl_4c_Separador
230:             .AutoSize  = .T.
231:             .FontName  = "Tahoma"
232:             .FontSize  = 8
233:             .BackStyle = 0
234:             .Caption   = CHR(224)
235:             .Left      = 530
236:             .Top       = 90
237:             .Height    = 15
238:             .ForeColor = RGB(90, 90, 90)
239:         ENDWITH
240: 
241:         *-- Data Final
242:         THIS.AddObject("txt_4c_DataF", "TextBox")
243:         WITH THIS.txt_4c_DataF
244:             .FontName      = "Tahoma"
245:             .FontSize      = 8
246:             .Height        = 25
247:             .Left          = 542
248:             .Top           = 86
249:             .Width         = 80
250:             .Format        = "K"
251:             .MaxLength     = 10
252:             .SpecialEffect = 1
253:             .BorderColor   = RGB(100, 100, 100)
254:             .Value         = {}
255:             .TabIndex      = 3
256:         ENDWITH
257: 
258:         *-- Label "Tipo Analise :"
259:         THIS.AddObject("lbl_4c_TipoAnalise", "Label")
260:         WITH THIS.lbl_4c_TipoAnalise
261:             .AutoSize  = .T.
262:             .FontName  = "Tahoma"
263:             .FontSize  = 8
264:             .BackStyle = 0
265:             .Caption   = "Tipo An" + CHR(225) + "lise :"
266:             .Left      = 377
267:             .Top       = 118
268:             .ForeColor = RGB(90, 90, 90)
269:         ENDWITH
270: 
271:         *-- Demonstrativo (tipo de analise)
272:         THIS.AddObject("txt_4c_Demonstrativo", "TextBox")
273:         WITH THIS.txt_4c_Demonstrativo
274:             .FontName      = "Tahoma"
275:             .FontSize      = 8
276:             .Format        = "K"
277:             .Height        = 25
278:             .Left          = 445
279:             .Top           = 113
280:             .Width         = 154
281:             .MaxLength     = 20
282:             .SpecialEffect = 1
283:             .BorderColor   = RGB(100, 100, 100)
284:             .TabIndex      = 5
285:             .ToolTipText   = "F4 ou duplo-clique para buscar"
286:         ENDWITH
287: 
288:         *-- Botao Visualizar (Video)
289:         THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
290:         WITH THIS.cmd_4c_Visualizar
291:             .Top             = 3
292:             .Left            = 700
293:             .Height          = 75
294:             .Width           = 75
295:             .FontBold        = .T.
296:             .FontItalic      = .T.
297:             .FontName        = "Comic Sans MS"
298:             .FontSize        = 8
299:             .Caption         = "   V" + CHR(237) + "deo            "
300:             .ToolTipText     = "Visualizar"
301:             .PicturePosition = 13
302:             .ForeColor       = RGB(90, 90, 90)
303:             .BackColor       = RGB(255, 255, 255)
304:             .DisabledBackColor = RGB(255, 255, 255)
305:             .Themes           = .T.
306:             .WordWrap        = .F.
307:             .TabIndex        = 29
308:             .Picture         = loc_cIcones + "relatorio_video_26.jpg"
309:         ENDWITH
310: 
311:         *-- Botao Imprimir
312:         THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
313:         WITH THIS.cmd_4c_Imprimir
314:             .Top             = 3
315:             .Left            = 775
316:             .Height          = 75
317:             .Width           = 75
318:             .FontBold        = .T.
319:             .FontItalic      = .T.
320:             .FontName        = "Comic Sans MS"
321:             .FontSize        = 8
322:             .Caption         = " Impressora    "
323:             .ToolTipText     = "Imprimir"
324:             .PicturePosition = 13
325:             .ForeColor       = RGB(90, 90, 90)
326:             .BackColor       = RGB(255, 255, 255)
327:             .DisabledBackColor = RGB(255, 255, 255)
328:             .Themes           = .T.
329:             .WordWrap        = .F.
330:             .TabIndex        = 30
331:             .Picture         = loc_cIcones + "relatorio_impressora_26.jpg"
332:         ENDWITH
333: 
334:         *-- Botao Processar
335:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
336:         WITH THIS.cmd_4c_Processar
337:             .Top        = 3
338:             .Left       = 850
339:             .Height     = 75
340:             .Width      = 75
341:             .FontBold   = .T.
342:             .FontItalic = .T.
343:             .FontName   = "Comic Sans MS"
344:             .FontSize   = 8
345:             .Caption    = "Processar"
346:             .ForeColor  = RGB(90, 90, 90)
347:             .BackColor  = RGB(255, 255, 255)
348:             .Themes           = .T.
349:             .TabIndex   = 7
350:             .Picture    = loc_cIcones + "geral_processar_60.jpg"
351:         ENDWITH
352: 
353:         *-- Botao Encerrar
354:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
355:         WITH THIS.cmd_4c_Encerrar
356:             .Top        = 3
357:             .Left       = 925
358:             .Height     = 75
359:             .Width      = 75
360:             .FontBold   = .T.
361:             .FontItalic = .T.
362:             .FontName   = "Comic Sans MS"
363:             .FontSize   = 8
364:             .Caption    = "Encerrar"
365:             .Cancel     = .T.
366:             .WordWrap   = .T.
367:             .ForeColor  = RGB(90, 90, 90)
368:             .BackColor  = RGB(255, 255, 255)
369:             .Themes           = .T.

*-- Linhas 380 a 389:
380: 
381:         THIS.AddObject("cnt_4c_Resultado", "Container")
382:         WITH THIS.cnt_4c_Resultado
383:             .Top         = 144
384:             .Left        = 9
385:             .Width       = 981
386:             .Height      = 453
387:             .BackStyle   = 0
388:             .BorderColor = RGB(90, 90, 90)
389:             .Visible     = .F.

*-- Linhas 396 a 430:
396:         *----------------------------------------------------------------------
397:         loc_oRes.AddObject("cnt_4c_Detalhe", "Container")
398:         WITH loc_oRes.cnt_4c_Detalhe
399:             .Top         = 5
400:             .Left        = 336
401:             .Width       = 294
402:             .Height      = 172
403:             .BackStyle   = 0
404:             .BorderColor = RGB(90, 90, 90)
405:             .Visible     = .F.
406: 
407:             .AddObject("lbl_4c_Titulo", "Label")
408:             WITH .lbl_4c_Titulo
409:                 .AutoSize  = .F.
410:                 .FontBold  = .T.
411:                 .FontName  = "Tahoma"
412:                 .FontSize  = 8
413:                 .BackStyle = 0
414:                 .Caption   = "Saldo com funcion" + CHR(225) + "rios antes do per" + CHR(237) + "odo"
415:                 .Left      = 9
416:                 .Top       = 4
417:                 .Height    = 15
418:                 .Width     = 275
419:                 .ForeColor = RGB(90, 90, 90)
420:             ENDWITH
421: 
422:             .AddObject("grd_4c_Dados", "Grid")
423:             WITH .grd_4c_Dados
424:                 .Top               = 24
425:                 .Left              = 3
426:                 .Width             = 288
427:                 .Height            = 139
428:                 .ColumnCount       = 3
429:                 .FontName          = "Tahoma"
430:                 .FontSize          = 8

*-- Linhas 455 a 498:
455:                 .Column3.ReadOnly  = .T.
456:                 .Column3.FontName  = "Tahoma"
457:                 .Column3.FontSize  = 8
458:                 .Column3.Header1.Caption = "Emp"
459:             ENDWITH
460:         ENDWITH
461: 
462:         *----------------------------------------------------------------------
463:         * cnt_4c_Detalhe2 - Entradas no periodo (left top)
464:         *----------------------------------------------------------------------
465:         loc_oRes.AddObject("cnt_4c_Detalhe2", "Container")
466:         WITH loc_oRes.cnt_4c_Detalhe2
467:             .Top         = 4
468:             .Left        = 15
469:             .Width       = 294
470:             .Height      = 172
471:             .BackStyle   = 0
472:             .BorderColor = RGB(90, 90, 90)
473:             .Visible     = .F.
474: 
475:             .AddObject("lbl_4c_Titulo", "Label")
476:             WITH .lbl_4c_Titulo
477:                 .AutoSize  = .F.
478:                 .FontBold  = .T.
479:                 .FontName  = "Tahoma"
480:                 .FontSize  = 8
481:                 .BackStyle = 0
482:                 .Caption   = "Entradas no per" + CHR(237) + "odo"
483:                 .Left      = 9
484:                 .Top       = 4
485:                 .Height    = 15
486:                 .Width     = 200
487:                 .ForeColor = RGB(90, 90, 90)
488:             ENDWITH
489: 
490:             .AddObject("grd_4c_Dados", "Grid")
491:             WITH .grd_4c_Dados
492:                 .Top               = 24
493:                 .Left              = 3
494:                 .Width             = 288
495:                 .Height            = 139
496:                 .ColumnCount       = 3
497:                 .FontName          = "Tahoma"
498:                 .FontSize          = 8

*-- Linhas 523 a 566:
523:                 .Column3.ReadOnly  = .T.
524:                 .Column3.FontName  = "Tahoma"
525:                 .Column3.FontSize  = 8
526:                 .Column3.Header1.Caption = "Emp"
527:             ENDWITH
528:         ENDWITH
529: 
530:         *----------------------------------------------------------------------
531:         * cnt_4c_Detalhe3 - Saidas no periodo (left bottom)
532:         *----------------------------------------------------------------------
533:         loc_oRes.AddObject("cnt_4c_Detalhe3", "Container")
534:         WITH loc_oRes.cnt_4c_Detalhe3
535:             .Top         = 184
536:             .Left        = 15
537:             .Width       = 294
538:             .Height      = 172
539:             .BackStyle   = 0
540:             .BorderColor = RGB(90, 90, 90)
541:             .Visible     = .F.
542: 
543:             .AddObject("lbl_4c_Titulo", "Label")
544:             WITH .lbl_4c_Titulo
545:                 .AutoSize  = .F.
546:                 .FontBold  = .T.
547:                 .FontName  = "Tahoma"
548:                 .FontSize  = 8
549:                 .BackStyle = 0
550:                 .Caption   = "Sa" + CHR(237) + "das no per" + CHR(237) + "odo"
551:                 .Left      = 9
552:                 .Top       = 4
553:                 .Height    = 15
554:                 .Width     = 180
555:                 .ForeColor = RGB(90, 90, 90)
556:             ENDWITH
557: 
558:             .AddObject("grd_4c_Dados", "Grid")
559:             WITH .grd_4c_Dados
560:                 .Top               = 24
561:                 .Left              = 3
562:                 .Width             = 288
563:                 .Height            = 139
564:                 .ColumnCount       = 3
565:                 .FontName          = "Tahoma"
566:                 .FontSize          = 8

*-- Linhas 591 a 634:
591:                 .Column3.ReadOnly  = .T.
592:                 .Column3.FontName  = "Tahoma"
593:                 .Column3.FontSize  = 8
594:                 .Column3.Header1.Caption = "Emp"
595:             ENDWITH
596:         ENDWITH
597: 
598:         *----------------------------------------------------------------------
599:         * cnt_4c_Detalhe4 - Saldo final com funcionarios (center bottom)
600:         *----------------------------------------------------------------------
601:         loc_oRes.AddObject("cnt_4c_Detalhe4", "Container")
602:         WITH loc_oRes.cnt_4c_Detalhe4
603:             .Top         = 184
604:             .Left        = 336
605:             .Width       = 294
606:             .Height      = 172
607:             .BackStyle   = 0
608:             .BorderColor = RGB(90, 90, 90)
609:             .Visible     = .F.
610: 
611:             .AddObject("lbl_4c_Titulo", "Label")
612:             WITH .lbl_4c_Titulo
613:                 .AutoSize  = .F.
614:                 .FontBold  = .T.
615:                 .FontName  = "Tahoma"
616:                 .FontSize  = 8
617:                 .BackStyle = 0
618:                 .Caption   = "Saldo final com funcion" + CHR(225) + "rios"
619:                 .Left      = 9
620:                 .Top       = 4
621:                 .Height    = 15
622:                 .Width     = 220
623:                 .ForeColor = RGB(90, 90, 90)
624:             ENDWITH
625: 
626:             .AddObject("grd_4c_Dados", "Grid")
627:             WITH .grd_4c_Dados
628:                 .Top               = 24
629:                 .Left              = 3
630:                 .Width             = 288
631:                 .Height            = 139
632:                 .ColumnCount       = 3
633:                 .FontName          = "Tahoma"
634:                 .FontSize          = 8

*-- Linhas 659 a 702:
659:                 .Column3.ReadOnly  = .T.
660:                 .Column3.FontName  = "Tahoma"
661:                 .Column3.FontSize  = 8
662:                 .Column3.Header1.Caption = "Emp"
663:             ENDWITH
664:         ENDWITH
665: 
666:         *----------------------------------------------------------------------
667:         * cnt_4c_Detalhe5 - Falhas dos funcionarios (right top)
668:         *----------------------------------------------------------------------
669:         loc_oRes.AddObject("cnt_4c_Detalhe5", "Container")
670:         WITH loc_oRes.cnt_4c_Detalhe5
671:             .Top         = 5
672:             .Left        = 659
673:             .Width       = 294
674:             .Height      = 172
675:             .BackStyle   = 0
676:             .BorderColor = RGB(90, 90, 90)
677:             .Visible     = .F.
678: 
679:             .AddObject("lbl_4c_Titulo", "Label")
680:             WITH .lbl_4c_Titulo
681:                 .AutoSize  = .F.
682:                 .FontBold  = .T.
683:                 .FontName  = "Tahoma"
684:                 .FontSize  = 8
685:                 .BackStyle = 0
686:                 .Caption   = "Falhas dos funcion" + CHR(225) + "rios no per" + CHR(237) + "odo"
687:                 .Left      = 9
688:                 .Top       = 4
689:                 .Height    = 15
690:                 .Width     = 270
691:                 .ForeColor = RGB(90, 90, 90)
692:             ENDWITH
693: 
694:             .AddObject("grd_4c_Dados", "Grid")
695:             WITH .grd_4c_Dados
696:                 .Top               = 24
697:                 .Left              = 3
698:                 .Width             = 288
699:                 .Height            = 139
700:                 .ColumnCount       = 3
701:                 .FontName          = "Tahoma"
702:                 .FontSize          = 8

*-- Linhas 727 a 930:
727:                 .Column3.ReadOnly  = .T.
728:                 .Column3.FontName  = "Tahoma"
729:                 .Column3.FontSize  = 8
730:                 .Column3.Header1.Caption = "Emp"
731:             ENDWITH
732:         ENDWITH
733: 
734:         *----------------------------------------------------------------------
735:         * cnt_4c_Resumo - Totalizadores (right bottom)
736:         *----------------------------------------------------------------------
737:         loc_oRes.AddObject("cnt_4c_Resumo", "Container")
738:         WITH loc_oRes.cnt_4c_Resumo
739:             .Top         = 184
740:             .Left        = 659
741:             .Width       = 294
742:             .Height      = 264
743:             .BackStyle   = 0
744:             .BorderColor = RGB(90, 90, 90)
745: 
746:             .AddObject("lbl_4c_Totalizadores", "Label")
747:             WITH .lbl_4c_Totalizadores
748:                 .AutoSize  = .F.
749:                 .FontBold  = .T.
750:                 .FontName  = "Tahoma"
751:                 .FontSize  = 8
752:                 .BackStyle = 0
753:                 .Caption   = "Totalizadores"
754:                 .Left      = 7
755:                 .Top       = 4
756:                 .Height    = 15
757:                 .Width     = 120
758:                 .ForeColor = RGB(90, 90, 90)
759:             ENDWITH
760: 
761:             .AddObject("lbl_4c_SaldoIni", "Label")
762:             WITH .lbl_4c_SaldoIni
763:                 .AutoSize  = .T.
764:                 .FontName  = "Tahoma"
765:                 .FontSize  = 8
766:                 .BackStyle = 0
767:                 .Caption   = "Saldo Inicial :"
768:                 .Left      = 136
769:                 .Top       = 27
770:                 .Height    = 15
771:                 .ForeColor = RGB(90, 90, 90)
772:             ENDWITH
773: 
774:             .AddObject("txt_4c_SaldoIni", "TextBox")
775:             WITH .txt_4c_SaldoIni
776:                 .FontName          = "Tahoma"
777:                 .FontSize          = 8
778:                 .Alignment         = 3
779:                 .Value             = 0
780:                 .Height            = 21
781:                 .InputMask         = "999,999.999"
782:                 .Left              = 203
783:                 .Margin            = 1
784:                 .ReadOnly          = .T.
785:                 .SpecialEffect     = 1
786:                 .Top               = 25
787:                 .Width             = 86
788:                 .DisabledBackColor = RGB(255, 255, 255)
789:                 .BorderColor       = RGB(100, 100, 100)
790:             ENDWITH
791: 
792:             .AddObject("lbl_4c_SaldoAntP", "Label")
793:             WITH .lbl_4c_SaldoAntP
794:                 .AutoSize  = .T.
795:                 .FontName  = "Tahoma"
796:                 .FontSize  = 8
797:                 .BackStyle = 0
798:                 .Caption   = "Saldo funcion" + CHR(225) + "rios ant./ per" + CHR(237) + "odo :"
799:                 .Left      = 39
800:                 .Top       = 50
801:                 .Height    = 15
802:                 .ForeColor = RGB(90, 90, 90)
803:             ENDWITH
804: 
805:             .AddObject("txt_4c_SaldoAntP", "TextBox")
806:             WITH .txt_4c_SaldoAntP
807:                 .FontName          = "Tahoma"
808:                 .FontSize          = 8
809:                 .Alignment         = 3
810:                 .Value             = 0
811:                 .Height            = 21
812:                 .InputMask         = "999,999.999"
813:                 .Left              = 203
814:                 .Margin            = 1
815:                 .ReadOnly          = .T.
816:                 .SpecialEffect     = 1
817:                 .Top               = 48
818:                 .Width             = 86
819:                 .DisabledBackColor = RGB(255, 255, 255)
820:                 .BorderColor       = RGB(100, 100, 100)
821:             ENDWITH
822: 
823:             .AddObject("lbl_4c_Entradas", "Label")
824:             WITH .lbl_4c_Entradas
825:                 .AutoSize  = .T.
826:                 .FontName  = "Tahoma"
827:                 .FontSize  = 8
828:                 .BackStyle = 0
829:                 .Caption   = "Entradas no per" + CHR(237) + "odo :"
830:                 .Left      = 95
831:                 .Top       = 73
832:                 .Height    = 15
833:                 .ForeColor = RGB(90, 90, 90)
834:             ENDWITH
835: 
836:             .AddObject("txt_4c_Entradas", "TextBox")
837:             WITH .txt_4c_Entradas
838:                 .FontName          = "Tahoma"
839:                 .FontSize          = 8
840:                 .Alignment         = 3
841:                 .Value             = 0
842:                 .Height            = 21
843:                 .InputMask         = "999,999.999"
844:                 .Left              = 203
845:                 .Margin            = 1
846:                 .ReadOnly          = .T.
847:                 .SpecialEffect     = 1
848:                 .Top               = 71
849:                 .Width             = 86
850:                 .DisabledBackColor = RGB(255, 255, 255)
851:                 .BorderColor       = RGB(100, 100, 100)
852:             ENDWITH
853: 
854:             .AddObject("lbl_4c_TotalEntradas", "Label")
855:             WITH .lbl_4c_TotalEntradas
856:                 .AutoSize  = .T.
857:                 .FontName  = "Tahoma"
858:                 .FontSize  = 8
859:                 .BackStyle = 0
860:                 .Caption   = "Sub-Total entradas :"
861:                 .Left      = 100
862:                 .Top       = 96
863:                 .Height    = 15
864:                 .ForeColor = RGB(90, 90, 90)
865:             ENDWITH
866: 
867:             .AddObject("txt_4c_TotalEntradas", "TextBox")
868:             WITH .txt_4c_TotalEntradas
869:                 .FontName          = "Tahoma"
870:                 .FontSize          = 8
871:                 .Alignment         = 3
872:                 .Value             = 0
873:                 .Height            = 21
874:                 .InputMask         = "999,999.999"
875:                 .Left              = 203
876:                 .Margin            = 1
877:                 .ReadOnly          = .T.
878:                 .SpecialEffect     = 1
879:                 .Top               = 94
880:                 .Width             = 86
881:                 .DisabledBackColor = RGB(255, 255, 255)
882:                 .BorderColor       = RGB(100, 100, 100)
883:             ENDWITH
884: 
885:             .AddObject("lbl_4c_Saidas", "Label")
886:             WITH .lbl_4c_Saidas
887:                 .AutoSize  = .T.
888:                 .FontName  = "Tahoma"
889:                 .FontSize  = 8
890:                 .BackStyle = 0
891:                 .Caption   = "Sa" + CHR(237) + "das no per" + CHR(237) + "odo :"
892:                 .Left      = 107
893:                 .Top       = 119
894:                 .Height    = 15
895:                 .ForeColor = RGB(90, 90, 90)
896:             ENDWITH
897: 
898:             .AddObject("txt_4c_Saidas", "TextBox")
899:             WITH .txt_4c_Saidas
900:                 .FontName          = "Tahoma"
901:                 .FontSize          = 8
902:                 .Alignment         = 3
903:                 .Value             = 0
904:                 .Height            = 21
905:                 .InputMask         = "999,999.999"
906:                 .Left              = 203
907:                 .Margin            = 1
908:                 .ReadOnly          = .T.
909:                 .SpecialEffect     = 1
910:                 .Top               = 117
911:                 .Width             = 86
912:                 .DisabledBackColor = RGB(255, 255, 255)
913:                 .BorderColor       = RGB(100, 100, 100)
914:             ENDWITH
915: 
916:             .AddObject("lbl_4c_Saldo", "Label")
917:             WITH .lbl_4c_Saldo
918:                 .AutoSize  = .T.
919:                 .FontBold  = .T.
920:                 .FontName  = "Tahoma"
921:                 .FontSize  = 8
922:                 .BackStyle = 0
923:                 .Caption   = "Saldo :"
924:                 .Left      = 162
925:                 .Top       = 142
926:                 .Height    = 15
927:                 .ForeColor = RGB(90, 90, 90)
928:             ENDWITH
929: 
930:             .AddObject("txt_4c_Saldo", "TextBox")

*-- Linhas 936 a 1025:
936:                 .Value             = 0
937:                 .Height            = 21
938:                 .InputMask         = "999,999.999"
939:                 .Left              = 203
940:                 .Margin            = 1
941:                 .ReadOnly          = .T.
942:                 .SpecialEffect     = 1
943:                 .Top               = 140
944:                 .Width             = 86
945:                 .DisabledBackColor = RGB(255, 255, 255)
946:                 .BorderColor       = RGB(100, 100, 100)
947:             ENDWITH
948: 
949:             .AddObject("lbl_4c_SaldoFunc", "Label")
950:             WITH .lbl_4c_SaldoFunc
951:                 .AutoSize  = .T.
952:                 .FontName  = "Tahoma"
953:                 .FontSize  = 8
954:                 .BackStyle = 0
955:                 .Caption   = "Saldo final com funcion" + CHR(225) + "rios :"
956:                 .Left      = 60
957:                 .Top       = 165
958:                 .Height    = 15
959:                 .ForeColor = RGB(90, 90, 90)
960:             ENDWITH
961: 
962:             .AddObject("txt_4c_SaldoFunc", "TextBox")
963:             WITH .txt_4c_SaldoFunc
964:                 .FontName          = "Tahoma"
965:                 .FontSize          = 8
966:                 .Alignment         = 3
967:                 .Value             = 0
968:                 .Height            = 21
969:                 .InputMask         = "999,999.999"
970:                 .Left              = 203
971:                 .Margin            = 1
972:                 .ReadOnly          = .T.
973:                 .SpecialEffect     = 1
974:                 .Top               = 163
975:                 .Width             = 86
976:                 .DisabledBackColor = RGB(255, 255, 255)
977:                 .BorderColor       = RGB(100, 100, 100)
978:             ENDWITH
979: 
980:             .AddObject("lbl_4c_Pesagem", "Label")
981:             WITH .lbl_4c_Pesagem
982:                 .AutoSize  = .T.
983:                 .FontName  = "Tahoma"
984:                 .FontSize  = 8
985:                 .BackStyle = 0
986:                 .Caption   = "Pesagem f" + CHR(237) + "sica :"
987:                 .Left      = 122
988:                 .Top       = 188
989:                 .Height    = 15
990:                 .ForeColor = RGB(90, 90, 90)
991:             ENDWITH
992: 
993:             .AddObject("txt_4c_Pesagem", "TextBox")
994:             WITH .txt_4c_Pesagem
995:                 .FontName          = "Tahoma"
996:                 .FontSize          = 8
997:                 .Alignment         = 3
998:                 .Value             = 0
999:                 .Height            = 21
1000:                 .InputMask         = "999,999.999"
1001:                 .Left              = 203
1002:                 .Margin            = 1
1003:                 .ReadOnly          = .T.
1004:                 .SpecialEffect     = 1
1005:                 .Top               = 186
1006:                 .Width             = 86
1007:                 .DisabledBackColor = RGB(255, 255, 255)
1008:                 .BorderColor       = RGB(100, 100, 100)
1009:             ENDWITH
1010: 
1011:             .AddObject("lbl_4c_Total", "Label")
1012:             WITH .lbl_4c_Total
1013:                 .AutoSize  = .T.
1014:                 .FontBold  = .T.
1015:                 .FontName  = "Tahoma"
1016:                 .FontSize  = 8
1017:                 .BackStyle = 0
1018:                 .Caption   = "Total :"
1019:                 .Left      = 164
1020:                 .Top       = 211
1021:                 .Height    = 15
1022:                 .ForeColor = RGB(90, 90, 90)
1023:             ENDWITH
1024: 
1025:             .AddObject("txt_4c_Total", "TextBox")

*-- Linhas 1031 a 1074:
1031:                 .Value             = 0
1032:                 .Height            = 21
1033:                 .InputMask         = "999,999.999"
1034:                 .Left              = 203
1035:                 .Margin            = 1
1036:                 .ReadOnly          = .T.
1037:                 .SpecialEffect     = 1
1038:                 .Top               = 209
1039:                 .Width             = 86
1040:                 .DisabledBackColor = RGB(255, 255, 255)
1041:                 .BorderColor       = RGB(100, 100, 100)
1042:             ENDWITH
1043: 
1044:             .AddObject("lbl_4c_FalhaFunc", "Label")
1045:             WITH .lbl_4c_FalhaFunc
1046:                 .AutoSize  = .T.
1047:                 .FontName  = "Tahoma"
1048:                 .FontSize  = 8
1049:                 .BackStyle = 0
1050:                 .Caption   = "Falha funcion" + CHR(225) + "rios no per" + CHR(237) + "odo :"
1051:                 .Left      = 51
1052:                 .Top       = 234
1053:                 .Height    = 15
1054:                 .ForeColor = RGB(90, 90, 90)
1055:             ENDWITH
1056: 
1057:             .AddObject("txt_4c_FalhaFunc", "TextBox")
1058:             WITH .txt_4c_FalhaFunc
1059:                 .FontName          = "Tahoma"
1060:                 .FontSize          = 8
1061:                 .Alignment         = 3
1062:                 .Value             = 0
1063:                 .Height            = 21
1064:                 .InputMask         = "999,999.999"
1065:                 .Left              = 203
1066:                 .Margin            = 1
1067:                 .ReadOnly          = .T.
1068:                 .SpecialEffect     = 1
1069:                 .Top               = 232
1070:                 .Width             = 86
1071:                 .DisabledBackColor = RGB(255, 255, 255)
1072:                 .BorderColor       = RGB(100, 100, 100)
1073:             ENDWITH
1074:         ENDWITH

*-- Linhas 1152 a 1164:
1152:             .grd_4c_Dados.RecordSource = "SaldoAnt"
1153:             WITH .grd_4c_Dados
1154:                 .Column1.ControlSource   = "SaldoAnt.Grupos"
1155:                 .Column1.Header1.Caption = "Header1"
1156:                 .Column2.ControlSource   = "SaldoAnt.Qtde"
1157:                 .Column2.Header1.Caption = "Header1"
1158:                 .Column3.ControlSource   = "SaldoAnt.Emps"
1159:                 .Column3.Header1.Caption = "Emp"
1160:                 .Refresh
1161:             ENDWITH
1162:         ENDWITH
1163: 
1164:         IF USED("Entradas")

*-- Linhas 1171 a 1183:
1171:             .grd_4c_Dados.RecordSource = "Entradas"
1172:             WITH .grd_4c_Dados
1173:                 .Column1.ControlSource   = "Entradas.TpOps"
1174:                 .Column1.Header1.Caption = "Header1"
1175:                 .Column2.ControlSource   = "Entradas.Qtde"
1176:                 .Column2.Header1.Caption = "Header1"
1177:                 .Column3.ControlSource   = "Entradas.Emps"
1178:                 .Column3.Header1.Caption = "Emp"
1179:                 .Refresh
1180:             ENDWITH
1181:         ENDWITH
1182: 
1183:         IF USED("Saidas")

*-- Linhas 1190 a 1202:
1190:             .grd_4c_Dados.RecordSource = "Saidas"
1191:             WITH .grd_4c_Dados
1192:                 .Column1.ControlSource   = "Saidas.TpOps"
1193:                 .Column1.Header1.Caption = "Header1"
1194:                 .Column2.ControlSource   = "Saidas.Qtde"
1195:                 .Column2.Header1.Caption = "Header1"
1196:                 .Column3.ControlSource   = "Saidas.Emps"
1197:                 .Column3.Header1.Caption = "Emp"
1198:                 .Refresh
1199:             ENDWITH
1200:         ENDWITH
1201: 
1202:         IF USED("Saldos")

*-- Linhas 1209 a 1221:
1209:             .grd_4c_Dados.RecordSource = "Saldos"
1210:             WITH .grd_4c_Dados
1211:                 .Column1.ControlSource   = "Saldos.Grupos"
1212:                 .Column1.Header1.Caption = "Header1"
1213:                 .Column2.ControlSource   = "Saldos.Qtde"
1214:                 .Column2.Header1.Caption = "Header1"
1215:                 .Column3.ControlSource   = "Saldos.Emps"
1216:                 .Column3.Header1.Caption = "Emp"
1217:                 .Refresh
1218:             ENDWITH
1219:         ENDWITH
1220: 
1221:         IF USED("Falhas")

*-- Linhas 1228 a 1240:
1228:             .grd_4c_Dados.RecordSource = "Falhas"
1229:             WITH .grd_4c_Dados
1230:                 .Column1.ControlSource   = "Falhas.Grupos"
1231:                 .Column1.Header1.Caption = "Header1"
1232:                 .Column2.ControlSource   = "Falhas.Qtde"
1233:                 .Column2.Header1.Caption = "Header1"
1234:                 .Column3.ControlSource   = "Falhas.Emps"
1235:                 .Column3.Header1.Caption = "Emp"
1236:                 .Refresh
1237:             ENDWITH
1238:         ENDWITH
1239:     ENDPROC
1240: 

*-- Linhas 1742 a 1753:
1742:         THIS.txt_4c_DataI.Enabled         = loc_lHab
1743:         THIS.txt_4c_DataF.Enabled         = loc_lHab
1744:         THIS.txt_4c_Demonstrativo.Enabled = loc_lHab
1745:         THIS.cmd_4c_Processar.Enabled     = loc_lHab
1746:         THIS.cmd_4c_Visualizar.Enabled    = loc_lHab AND THIS.cnt_4c_Resultado.Visible
1747:         THIS.cmd_4c_Imprimir.Enabled      = loc_lHab AND THIS.cnt_4c_Resultado.Visible
1748:         THIS.cmd_4c_Encerrar.Enabled      = .T.
1749:     ENDPROC
1750: 
1751:     *==========================================================================
1752:     * LimparCampos - Reseta filtros e propriedades do BO
1753:     *==========================================================================

*-- Linhas 1812 a 1821:
1812:         LOCAL loc_lTemResultado
1813:         loc_lTemResultado = THIS.cnt_4c_Resultado.Visible
1814: 
1815:         THIS.cmd_4c_Processar.Enabled  = .T.
1816:         THIS.cmd_4c_Visualizar.Enabled = loc_lTemResultado
1817:         THIS.cmd_4c_Imprimir.Enabled   = loc_lTemResultado
1818:         THIS.cmd_4c_Encerrar.Enabled   = .T.
1819:     ENDPROC
1820: 
1821: ENDDEFINE

