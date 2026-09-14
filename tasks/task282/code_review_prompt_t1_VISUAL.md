# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 199: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 358: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 380: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2023 linhas total):

*-- Linhas 47 a 55:
47:         TRY
48:             IF VARTYPE(par_cChave) = "C" AND !EMPTY(ALLTRIM(par_cChave))
49:                 THIS.this_cDopes = ALLTRIM(par_cChave)
50:                 THIS.Caption     = ALLTRIM(par_cChave)
51:             ENDIF
52:             IF VARTYPE(par_oParentForm) = "O"
53:                 THIS.this_oParentForm = par_oParentForm
54:             ENDIF
55:             loc_lResultado = DODEFAULT()

*-- Linhas 103 a 117:
103:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
104:         WITH THIS.pgf_4c_Paginas
105:             .PageCount = 2
106:             .Top       = -29
107:             .Left      = 0
108:             .Width     = THIS.Width
109:             .Height    = THIS.Height + 29
110:             .Tabs      = .F.
111:             .Page1.Caption   = "Lista"
112:             .Page2.Caption   = "Dados"
113:             .Page1.BackColor = RGB(255, 255, 255)
114:             .Page2.BackColor = RGB(255, 255, 255)
115:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
116:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
117:             .Visible = .T.

*-- Linhas 131 a 167:
131:         *-- Cabecalho escuro (cntSombra no legado): Top=1+29=30
132:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH loc_oPagina.cnt_4c_Cabecalho
134:             .Top         = 30
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BackColor   = RGB(100, 100, 100)
139:             .BorderWidth = 0
140:             .Visible     = .T.
141: 
142:             .AddObject("lbl_4c_Sombra", "Label")
143:             WITH .lbl_4c_Sombra
144:                 .Caption   = THIS.Caption
145:                 .Top       = 15
146:                 .Left      = 10
147:                 .Width     = THIS.Width
148:                 .Height    = 40
149:                 .AutoSize  = .F.
150:                 .FontName  = "Tahoma"
151:                 .FontSize  = 16
152:                 .FontBold  = .T.
153:                 .ForeColor = RGB(0, 0, 0)
154:                 .BackStyle = 0
155:                 .Visible   = .T.
156:             ENDWITH
157: 
158:             .AddObject("lbl_4c_Titulo", "Label")
159:             WITH .lbl_4c_Titulo
160:                 .Caption   = THIS.Caption
161:                 .Top       = 18
162:                 .Left      = 10
163:                 .Width     = THIS.Width
164:                 .Height    = 46
165:                 .AutoSize  = .F.
166:                 .FontName  = "Tahoma"
167:                 .FontSize  = 16

*-- Linhas 176 a 205:
176:         *-- Top=-1+29=28
177:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
178:         WITH loc_oPagina.cnt_4c_Botoes
179:             .Top         = 28
180:             .Left        = 542
181:             .Width       = 90
182:             .Height      = 85
183:             .BackStyle   = 1
184:             .BackColor   = RGB(53, 53, 53)
185:             .BorderWidth = 0
186:             .Visible     = .T.
187: 
188:             .AddObject("cmd_4c_Consultar", "CommandButton")
189:             WITH .cmd_4c_Consultar
190:                 .Caption         = "Consultar"
191:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
192:                 .PicturePosition = 13
193:                 .Top             = 5
194:                 .Left            =  542
195:                 .Width           = 75
196:                 .Height          = 75
197:                 .BackColor       = RGB(255, 255, 255)
198:                 .ForeColor       = RGB(90, 90, 90)
199:                 .FontName        = "Comic Sans MS"
200:                 .FontBold        = .T.
201:                 .FontItalic      = .T.
202:                 .FontSize        = 8
203:                 .SpecialEffect   = 0
204:                 .MousePointer    = 15
205:                 .WordWrap        = .T.

*-- Linhas 211 a 239:
211:         *-- Container saida - padrao canonico (Left=917, Width=90)
212:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
213:         WITH loc_oPagina.cnt_4c_Saida
214:             .Top         = 28
215:             .Left        = 917
216:             .Width       = 90
217:             .Height      = 85
218:             .BackStyle   = 0
219:             .BorderWidth = 0
220:             .Visible     = .T.
221: 
222:             .AddObject("cmd_4c_Encerrar", "CommandButton")
223:             WITH .cmd_4c_Encerrar
224:                 .Caption         = "Encerrar"
225:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
226:                 .PicturePosition = 13
227:                 .Top             = 5
228:                 .Left            = 917
229:                 .Width           = 90
230:                 .Height          = 75
231:                 .BackColor       = RGB(255, 255, 255)
232:                 .ForeColor       = RGB(90, 90, 90)
233:                 .FontName        = "Comic Sans MS"
234:                 .FontBold        = .T.
235:                 .FontItalic      = .T.
236:                 .FontSize        = 8
237:                 .SpecialEffect   = 0
238:                 .MousePointer    = 15
239:                 .WordWrap        = .T.

*-- Linhas 251 a 260:
251:             loc_oGrid.RecordSource = "csTemporario"
252:         ENDIF
253:         WITH loc_oGrid
254:             .Top                = 117
255:             .Left               = 26
256:             .Width              = 960
257:             .Height             = 468
258:             .FontName           = "Verdana"
259:             .FontSize           = 8
260:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 272 a 324:
272: 
273:             .Column1.ControlSource    = "csTemporario.Numes"
274:             .Column1.Width            = 60
275:             .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
276: 
277:             .Column2.ControlSource    = "csTemporario.Datas"
278:             .Column2.Width            = 80
279:             .Column2.Header1.Caption  = "Data"
280: 
281:             .Column3.ControlSource    = "csTemporario.GrupoOs"
282:             .Column3.Width            = 60
283:             .Column3.Header1.Caption  = "Grupo"
284: 
285:             .Column4.ControlSource    = "csTemporario.ContaOs"
286:             .Column4.Width            = 100
287:             .Column4.Header1.Caption  = "Origem"
288: 
289:             .Column5.ControlSource    = "csTemporario.GrupoDs"
290:             .Column5.Width            = 60
291:             .Column5.Header1.Caption  = "Grupo"
292: 
293:             .Column6.ControlSource    = "csTemporario.ContaDs"
294:             .Column6.Width            = 100
295:             .Column6.Header1.Caption  = "Destino"
296: 
297:             .Column7.ControlSource    = "csTemporario.Nops"
298:             .Column7.Width            = 80
299:             .Column7.Header1.Caption  = "Doc.Op"
300: 
301:             .Column8.ControlSource    = "csTemporario.Usuars"
302:             .Column8.Width            = 100
303:             .Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
304: 
305:             .Column9.ControlSource    = "csTemporario.PStatus"
306:             .Column9.Width            = 60
307:             .Column9.Header1.Caption  = "Status"
308: 
309:             .Column10.ControlSource   = "csTemporario.Emps"
310:             .Column10.Width           = 50
311:             .Column10.Header1.Caption = "EmpO"
312: 
313:             .Column11.ControlSource   = "csTemporario.Empds"
314:             .Column11.Width           = 50
315:             .Column11.Header1.Caption = "EmpD"
316:         ENDWITH
317: 
318:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", THIS, "BtnConsultarClick")
319:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
320: 
321:         THIS.FormatarGridLista(loc_oGrid)
322:         THIS.TornarControlesVisiveis(loc_oPagina)
323:     ENDPROC
324: 

*-- Linhas 336 a 386:
336:         *-- Top=4+29=33, Left=829, Width=160, Height=85
337:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
338:         WITH loc_oPagina.cnt_4c_Salva
339:             .Top         = 33
340:             .Left        = 829
341:             .Width       = 160
342:             .Height      = 85
343:             .BackStyle   = 0
344:             .BorderWidth = 0
345:             .Visible     = .T.
346: 
347:             .AddObject("cmd_4c_Confirmar", "CommandButton")
348:             WITH .cmd_4c_Confirmar
349:                 .Caption         = "Confirmar"
350:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
351:                 .PicturePosition = 13
352:                 .Top             = 5
353:                 .Left            = 5
354:                 .Width           = 75
355:                 .Height          = 75
356:                 .BackColor       = RGB(255, 255, 255)
357:                 .ForeColor       = RGB(90, 90, 90)
358:                 .FontName        = "Comic Sans MS"
359:                 .FontBold        = .T.
360:                 .FontItalic      = .T.
361:                 .FontSize        = 8
362:                 .SpecialEffect   = 0
363:                 .MousePointer    = 15
364:                 .WordWrap        = .T.
365:                 .AutoSize        = .F.
366:                 .Visible         = .T.
367:             ENDWITH
368: 
369:             .AddObject("cmd_4c_Cancelar", "CommandButton")
370:             WITH .cmd_4c_Cancelar
371:                 .Caption         = "Encerrar"
372:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
373:                 .PicturePosition = 13
374:                 .Top             = 5
375:                 .Left            = 80
376:                 .Width           = 75
377:                 .Height          = 75
378:                 .BackColor       = RGB(255, 255, 255)
379:                 .ForeColor       = RGB(90, 90, 90)
380:                 .FontName        = "Comic Sans MS"
381:                 .FontBold        = .T.
382:                 .FontItalic      = .T.
383:                 .FontSize        = 8
384:                 .Themes          = .F.
385:                 .SpecialEffect   = 0
386:                 .MousePointer    = 15

*-- Linhas 396 a 405:
396:         loc_oGrid = loc_oPagina.grd_4c_Operacao
397:         loc_oGrid.ColumnCount = 1
398:         WITH loc_oGrid
399:             .Top                = 39
400:             .Left               = 679
401:             .Width              = 112
402:             .Height             = 148
403:             .FontName           = "Verdana"
404:             .FontSize           = 8
405:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 413 a 431:
413:             .RowHeight          = 16
414:             .ScrollBars         = 2
415:             .GridLines          = 1
416:             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
417:             .Visible = .T.
418:         ENDWITH
419: 
420:         *-- cmd_4c_Entrega: botao de consulta/agendamento de entrega
421:         *-- Legado: cmdEntrega CommandGroup Top=7+29=36, Left=23, Width=90, Height=110
422:         loc_oPagina.AddObject("cmd_4c_Entrega", "CommandButton")
423:         WITH loc_oPagina.cmd_4c_Entrega
424:             .Caption       = "Entrega"
425:             .Top           = 36
426:             .Left          = 23
427:             .Width         = 90
428:             .Height        = 40
429:             .BackColor     = RGB(255, 255, 255)
430:             .ForeColor     = RGB(90, 90, 90)
431:             .FontName      = "Tahoma"

*-- Linhas 440 a 452:
440: 
441:         *-- Say3 "Codigo" + txt_4c_Codigo (read-only)
442:         *-- Say3 Top=14+29=43, Left=131
443:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
444:         WITH loc_oPagina.lbl_4c_Codigo
445:             .Caption   = "C" + CHR(243) + "digo"
446:             .Top       = 43
447:             .Left      = 131
448:             .Width     = 65
449:             .Height    = 15
450:             .AutoSize  = .F.
451:             .FontName  = "Tahoma"
452:             .FontSize  = 8

*-- Linhas 459 a 468:
459:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
460:         WITH loc_oPagina.txt_4c_Codigo
461:             .Value         = ""
462:             .Top           = 60
463:             .Left          = 131
464:             .Width         = 61
465:             .Height        = 23
466:             .ReadOnly      = .T.
467:             .FontName      = "Tahoma"
468:             .FontSize      = 8

*-- Linhas 475 a 487:
475: 
476:         *-- Say4 "Data" + txt_4c_Data (read-only; When=INLIST(pcEscolha,'INSERIR','ALTERAR'))
477:         *-- Say4 Top=14+29=43, Left=201
478:         loc_oPagina.AddObject("lbl_4c_Data", "Label")
479:         WITH loc_oPagina.lbl_4c_Data
480:             .Caption   = "Data"
481:             .Top       = 43
482:             .Left      = 201
483:             .Width     = 40
484:             .Height    = 15
485:             .AutoSize  = .F.
486:             .FontName  = "Tahoma"
487:             .FontSize  = 8

*-- Linhas 494 a 503:
494:         loc_oPagina.AddObject("txt_4c_Data", "TextBox")
495:         WITH loc_oPagina.txt_4c_Data
496:             .Value         = {}
497:             .Top           = 60
498:             .Left          = 201
499:             .Width         = 80
500:             .Height        = 23
501:             .ReadOnly      = .T.
502:             .FontName      = "Tahoma"
503:             .FontSize      = 8

*-- Linhas 510 a 522:
510: 
511:         *-- Say1 "Prz Entrega" + txt_4c_PrvEnts (read-only)
512:         *-- Say1 Top=14+29=43, Left=289
513:         loc_oPagina.AddObject("lbl_4c_PrvEnts", "Label")
514:         WITH loc_oPagina.lbl_4c_PrvEnts
515:             .Caption   = "Prz Entrega"
516:             .Top       = 43
517:             .Left      = 289
518:             .Width     = 70
519:             .Height    = 15
520:             .AutoSize  = .F.
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8

*-- Linhas 529 a 538:
529:         loc_oPagina.AddObject("txt_4c_PrvEnts", "TextBox")
530:         WITH loc_oPagina.txt_4c_PrvEnts
531:             .Value         = {}
532:             .Top           = 60
533:             .Left          = 289
534:             .Width         = 80
535:             .Height        = 23
536:             .ReadOnly      = .T.
537:             .FontName      = "Tahoma"
538:             .FontSize      = 8

*-- Linhas 545 a 557:
545: 
546:         *-- Say_Nota "Docto" + txt_4c_Nota (visivel)
547:         *-- Say_Nota Top=62+29=91, Left=193, Width=30, Height=15
548:         loc_oPagina.AddObject("lbl_4c_Nota", "Label")
549:         WITH loc_oPagina.lbl_4c_Nota
550:             .Caption   = "Docto"
551:             .Top       = 91
552:             .Left      = 193
553:             .Width     = 30
554:             .Height    = 15
555:             .AutoSize  = .F.
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8

*-- Linhas 564 a 573:
564:         loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
565:         WITH loc_oPagina.txt_4c_Nota
566:             .Value         = ""
567:             .Top           = 107
568:             .Left          = 193
569:             .Width         = 66
570:             .Height        = 23
571:             .ReadOnly      = .T.
572:             .FontName      = "Tahoma"
573:             .FontSize      = 8

*-- Linhas 580 a 592:
580: 
581:         *-- Say_nop "OP" + txt_4c_Nop (read-only: When=.F. no legado)
582:         *-- Say_nop Top=62+29=91, Left=131
583:         loc_oPagina.AddObject("lbl_4c_Nop", "Label")
584:         WITH loc_oPagina.lbl_4c_Nop
585:             .Caption   = "OP"
586:             .Top       = 91
587:             .Left      = 131
588:             .Width     = 55
589:             .Height    = 15
590:             .AutoSize  = .F.
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8

*-- Linhas 599 a 608:
599:         loc_oPagina.AddObject("txt_4c_Nop", "TextBox")
600:         WITH loc_oPagina.txt_4c_Nop
601:             .Value         = ""
602:             .Top           = 108
603:             .Left          = 131
604:             .Width         = 55
605:             .Height        = 23
606:             .ReadOnly      = .T.
607:             .FontName      = "Tahoma"
608:             .FontSize      = 8

*-- Linhas 615 a 627:
615: 
616:         *-- Say13 "Tb. Desconto" + txt_4c_Tabd (read-only: When=.F. no legado)
617:         *-- Say13 Top=62+29=91, Left=269
618:         loc_oPagina.AddObject("lbl_4c_Tabd", "Label")
619:         WITH loc_oPagina.lbl_4c_Tabd
620:             .Caption   = "Tb. Desconto"
621:             .Top       = 91
622:             .Left      = 269
623:             .Width     = 70
624:             .Height    = 15
625:             .AutoSize  = .F.
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8

*-- Linhas 634 a 643:
634:         loc_oPagina.AddObject("txt_4c_Tabd", "TextBox")
635:         WITH loc_oPagina.txt_4c_Tabd
636:             .Value         = ""
637:             .Top           = 108
638:             .Left          = 269
639:             .Width         = 80
640:             .Height        = 23
641:             .ReadOnly      = .T.
642:             .FontName      = "Tahoma"
643:             .FontSize      = 8

*-- Linhas 650 a 662:
650: 
651:         *-- Say5 "Status" + txt_4c_PStatus (read-only: When=.F. no legado)
652:         *-- Say5 Top=62+29=91, Left=358
653:         loc_oPagina.AddObject("lbl_4c_PStatus", "Label")
654:         WITH loc_oPagina.lbl_4c_PStatus
655:             .Caption   = "Status"
656:             .Top       = 91
657:             .Left      = 358
658:             .Width     = 36
659:             .Height    = 15
660:             .AutoSize  = .F.
661:             .FontName  = "Tahoma"
662:             .FontSize  = 8

*-- Linhas 669 a 697:
669:         loc_oPagina.AddObject("txt_4c_PStatus", "TextBox")
670:         WITH loc_oPagina.txt_4c_PStatus
671:             .Value         = ""
672:             .Top           = 108
673:             .Left          = 358
674:             .Width         = 36
675:             .Height        = 23
676:             .ReadOnly      = .T.
677:             .FontName      = "Tahoma"
678:             .FontSize      = 8
679:             .ForeColor     = RGB(90, 90, 90)
680:             .BackColor     = RGB(240, 240, 240)
681:             .BorderStyle   = 1
682:             .SpecialEffect = 0
683:             .Visible       = .T.
684:         ENDWITH
685: 
686:         *-- cmd_4c_SubNiveis: abre form SigMvSbn para sub-niveis do pedido
687:         *-- Top=125+29=154, Left=833, Width=137, Height=40
688:         loc_oPagina.AddObject("cmd_4c_SubNiveis", "CommandButton")
689:         WITH loc_oPagina.cmd_4c_SubNiveis
690:             .Caption       = "   Sub" + CHR(237) + "veis    "
691:             .Top           = 154
692:             .Left          = 833
693:             .Width         = 137
694:             .Height        = 40
695:             .BackColor     = RGB(255, 255, 255)
696:             .ForeColor     = RGB(90, 90, 90)
697:             .FontName      = "Tahoma"

*-- Linhas 708 a 730:
708:         *-- Top=173+29=202, Left=27, Width=582, Height=164
709:         loc_oPagina.AddObject("cnt_4c_Origem", "Container")
710:         WITH loc_oPagina.cnt_4c_Origem
711:             .Top         = 202
712:             .Left        = 27
713:             .Width       = 582
714:             .Height      = 164
715:             .BackStyle   = 1
716:             .BackColor   = RGB(240, 240, 240)
717:             .BorderWidth = 0
718:             .Visible     = .T.
719: 
720:             *-- Say8 "Origem"
721:             .AddObject("lbl_4c_LblOrigem", "Label")
722:             WITH .lbl_4c_LblOrigem
723:                 .Caption   = "Origem"
724:                 .Top       = 5
725:                 .Left      = 5
726:                 .Width     = 80
727:                 .Height    = 15
728:                 .AutoSize  = .F.
729:                 .FontName  = "Tahoma"
730:                 .FontSize  = 8

*-- Linhas 736 a 802:
736: 
737:             .AddObject("lin_4c_Line1", "Line")
738:             WITH .lin_4c_Line1
739:                 .Top         = 20
740:                 .Left        = 5
741:                 .Width       = 560
742:                 .Height      = 0
743:                 .BorderColor = RGB(150, 150, 150)
744:                 .Visible     = .T.
745:             ENDWITH
746: 
747:             *-- Say2 "Grupo :" + txt_4c_GrupoO
748:             .AddObject("lbl_4c_GrupoOLbl", "Label")
749:             WITH .lbl_4c_GrupoOLbl
750:                 .Caption   = "Grupo :"
751:                 .Top       = 30
752:                 .Left      = 19
753:                 .Width     = 40
754:                 .Height    = 15
755:                 .AutoSize  = .F.
756:                 .FontName  = "Tahoma"
757:                 .FontSize  = 8
758:                 .ForeColor = RGB(90, 90, 90)
759:                 .BackStyle = 0
760:                 .Visible   = .T.
761:             ENDWITH
762:             .AddObject("txt_4c_GrupoO", "TextBox")
763:             WITH .txt_4c_GrupoO
764:                 .Value         = ""
765:                 .Top           = 27
766:                 .Left          = 61
767:                 .Width         = 80
768:                 .Height        = 21
769:                 .ReadOnly      = .T.
770:                 .FontName      = "Tahoma"
771:                 .FontSize      = 8
772:                 .ForeColor     = RGB(90, 90, 90)
773:                 .BackColor     = RGB(240, 240, 240)
774:                 .SpecialEffect = 0
775:                 .Visible       = .T.
776:             ENDWITH
777: 
778:             *-- Say5 "Conta :" + txt_4c_ContaO + txt_4c_DcontaO
779:             .AddObject("lbl_4c_ContaOLbl", "Label")
780:             WITH .lbl_4c_ContaOLbl
781:                 .Caption   = "Conta :"
782:                 .Top       = 30
783:                 .Left      = 154
784:                 .Width     = 40
785:                 .Height    = 15
786:                 .AutoSize  = .F.
787:                 .FontName  = "Tahoma"
788:                 .FontSize  = 8
789:                 .ForeColor = RGB(90, 90, 90)
790:                 .BackStyle = 0
791:                 .Visible   = .T.
792:             ENDWITH
793:             .AddObject("txt_4c_ContaO", "TextBox")
794:             WITH .txt_4c_ContaO
795:                 .Value         = ""
796:                 .Top           = 27
797:                 .Left          = 197
798:                 .Width         = 80
799:                 .Height        = 21
800:                 .ReadOnly      = .T.
801:                 .FontName      = "Tahoma"
802:                 .FontSize      = 8

*-- Linhas 808 a 834:
808:             .AddObject("txt_4c_DcontaO", "TextBox")
809:             WITH .txt_4c_DcontaO
810:                 .Value         = ""
811:                 .Top           = 27
812:                 .Left          = 277
813:                 .Width         = 267
814:                 .Height        = 21
815:                 .ReadOnly      = .T.
816:                 .FontName      = "Tahoma"
817:                 .FontSize      = 8
818:                 .ForeColor     = RGB(90, 90, 90)
819:                 .BackColor     = RGB(240, 240, 240)
820:                 .SpecialEffect = 0
821:                 .Visible       = .T.
822:             ENDWITH
823: 
824:             *-- Say_Origem1 "Destino"
825:             .AddObject("lbl_4c_LblDestino", "Label")
826:             WITH .lbl_4c_LblDestino
827:                 .Caption   = "Destino"
828:                 .Top       = 59
829:                 .Left      = 5
830:                 .Width     = 80
831:                 .Height    = 15
832:                 .AutoSize  = .F.
833:                 .FontName  = "Tahoma"
834:                 .FontSize  = 8

*-- Linhas 840 a 906:
840: 
841:             .AddObject("lin_4c_Line2", "Line")
842:             WITH .lin_4c_Line2
843:                 .Top         = 74
844:                 .Left        = 5
845:                 .Width       = 560
846:                 .Height      = 0
847:                 .BorderColor = RGB(150, 150, 150)
848:                 .Visible     = .T.
849:             ENDWITH
850: 
851:             *-- Say4 "Grupo :" + txt_4c_GrupoD
852:             .AddObject("lbl_4c_GrupoDLbl", "Label")
853:             WITH .lbl_4c_GrupoDLbl
854:                 .Caption   = "Grupo :"
855:                 .Top       = 85
856:                 .Left      = 19
857:                 .Width     = 40
858:                 .Height    = 15
859:                 .AutoSize  = .F.
860:                 .FontName  = "Tahoma"
861:                 .FontSize  = 8
862:                 .ForeColor = RGB(90, 90, 90)
863:                 .BackStyle = 0
864:                 .Visible   = .T.
865:             ENDWITH
866:             .AddObject("txt_4c_GrupoD", "TextBox")
867:             WITH .txt_4c_GrupoD
868:                 .Value         = ""
869:                 .Top           = 82
870:                 .Left          = 61
871:                 .Width         = 80
872:                 .Height        = 21
873:                 .ReadOnly      = .T.
874:                 .FontName      = "Tahoma"
875:                 .FontSize      = 8
876:                 .ForeColor     = RGB(90, 90, 90)
877:                 .BackColor     = RGB(240, 240, 240)
878:                 .SpecialEffect = 0
879:                 .Visible       = .T.
880:             ENDWITH
881: 
882:             *-- Say6 "Conta :" + txt_4c_ContaD + txt_4c_DcontaD
883:             .AddObject("lbl_4c_ContaDLbl", "Label")
884:             WITH .lbl_4c_ContaDLbl
885:                 .Caption   = "Conta :"
886:                 .Top       = 85
887:                 .Left      = 154
888:                 .Width     = 40
889:                 .Height    = 15
890:                 .AutoSize  = .F.
891:                 .FontName  = "Tahoma"
892:                 .FontSize  = 8
893:                 .ForeColor = RGB(90, 90, 90)
894:                 .BackStyle = 0
895:                 .Visible   = .T.
896:             ENDWITH
897:             .AddObject("txt_4c_ContaD", "TextBox")
898:             WITH .txt_4c_ContaD
899:                 .Value         = ""
900:                 .Top           = 82
901:                 .Left          = 196
902:                 .Width         = 80
903:                 .Height        = 21
904:                 .ReadOnly      = .T.
905:                 .FontName      = "Tahoma"
906:                 .FontSize      = 8

*-- Linhas 912 a 938:
912:             .AddObject("txt_4c_DcontaD", "TextBox")
913:             WITH .txt_4c_DcontaD
914:                 .Value         = ""
915:                 .Top           = 82
916:                 .Left          = 277
917:                 .Width         = 267
918:                 .Height        = 21
919:                 .ReadOnly      = .T.
920:                 .FontName      = "Tahoma"
921:                 .FontSize      = 8
922:                 .ForeColor     = RGB(90, 90, 90)
923:                 .BackColor     = RGB(240, 240, 240)
924:                 .SpecialEffect = 0
925:                 .Visible       = .T.
926:             ENDWITH
927: 
928:             *-- btnCadastros: abre SIGCDCTA com ContaD
929:             .AddObject("cmd_4c_BtnCadastros", "CommandButton")
930:             WITH .cmd_4c_BtnCadastros
931:                 .Caption       = ""
932:                 .Top           = 79
933:                 .Left          = 549
934:                 .Width         = 27
935:                 .Height        = 31
936:                 .FontName      = "Tahoma"
937:                 .FontSize      = 8
938:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 944 a 956:
944:             ENDWITH
945: 
946:             *-- Say3 "Representante"
947:             .AddObject("lbl_4c_LblResp", "Label")
948:             WITH .lbl_4c_LblResp
949:                 .Caption   = "Representante"
950:                 .Top       = 113
951:                 .Left      = 5
952:                 .Width     = 90
953:                 .Height    = 15
954:                 .AutoSize  = .F.
955:                 .FontName  = "Tahoma"
956:                 .FontSize  = 8

*-- Linhas 962 a 1028:
962: 
963:             .AddObject("lin_4c_Line3", "Line")
964:             WITH .lin_4c_Line3
965:                 .Top         = 129
966:                 .Left        = 5
967:                 .Width       = 560
968:                 .Height      = 0
969:                 .BorderColor = RGB(150, 150, 150)
970:                 .Visible     = .T.
971:             ENDWITH
972: 
973:             *-- Say9 "Grupo :" + txt_4c_GruResp (read-only)
974:             .AddObject("lbl_4c_GruRespLbl", "Label")
975:             WITH .lbl_4c_GruRespLbl
976:                 .Caption   = "Grupo :"
977:                 .Top       = 138
978:                 .Left      = 19
979:                 .Width     = 40
980:                 .Height    = 15
981:                 .AutoSize  = .F.
982:                 .FontName  = "Tahoma"
983:                 .FontSize  = 8
984:                 .ForeColor = RGB(90, 90, 90)
985:                 .BackStyle = 0
986:                 .Visible   = .T.
987:             ENDWITH
988:             .AddObject("txt_4c_GruResp", "TextBox")
989:             WITH .txt_4c_GruResp
990:                 .Value         = ""
991:                 .Top           = 135
992:                 .Left          = 61
993:                 .Width         = 80
994:                 .Height        = 21
995:                 .ReadOnly      = .T.
996:                 .FontName      = "Tahoma"
997:                 .FontSize      = 8
998:                 .ForeColor     = RGB(90, 90, 90)
999:                 .BackColor     = RGB(240, 240, 240)
1000:                 .SpecialEffect = 0
1001:                 .Visible       = .T.
1002:             ENDWITH
1003: 
1004:             *-- Say7 "Conta :" + txt_4c_Resps + txt_4c_Dresps (ambos When=.F. no legado)
1005:             .AddObject("lbl_4c_RespLbl", "Label")
1006:             WITH .lbl_4c_RespLbl
1007:                 .Caption   = "Conta :"
1008:                 .Top       = 138
1009:                 .Left      = 154
1010:                 .Width     = 40
1011:                 .Height    = 15
1012:                 .AutoSize  = .F.
1013:                 .FontName  = "Tahoma"
1014:                 .FontSize  = 8
1015:                 .ForeColor = RGB(90, 90, 90)
1016:                 .BackStyle = 0
1017:                 .Visible   = .T.
1018:             ENDWITH
1019:             .AddObject("txt_4c_Resps", "TextBox")
1020:             WITH .txt_4c_Resps
1021:                 .Value         = ""
1022:                 .Top           = 135
1023:                 .Left          = 195
1024:                 .Width         = 80
1025:                 .Height        = 21
1026:                 .ReadOnly      = .T.
1027:                 .Enabled       = .F.
1028:                 .FontName      = "Tahoma"

*-- Linhas 1035 a 1044:
1035:             .AddObject("txt_4c_Dresps", "TextBox")
1036:             WITH .txt_4c_Dresps
1037:                 .Value         = ""
1038:                 .Top           = 135
1039:                 .Left          = 277
1040:                 .Width         = 267
1041:                 .Height        = 21
1042:                 .ReadOnly      = .T.
1043:                 .Enabled       = .F.
1044:                 .FontName      = "Tahoma"

*-- Linhas 1057 a 1066:
1057:         loc_oGridItens = loc_oPagina.grd_4c_Itens
1058:         loc_oGridItens.ColumnCount = 10
1059:         WITH loc_oGridItens
1060:             .Top                = 379
1061:             .Left               = 23
1062:             .Width              = 732
1063:             .Height             = 191
1064:             .FontName           = "Verdana"
1065:             .FontSize           = 8
1066:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 1074 a 1122:
1074:             .RowHeight          = 16
1075:             .ScrollBars         = 2
1076:             .GridLines          = 3
1077:             .Column1.Header1.Caption  = "Produto"
1078:             .Column1.Width            = 90
1079:             .Column2.Header1.Caption  = "Produzido"
1080:             .Column2.Width            = 65
1081:             .Column3.Header1.Caption  = "Qtd."
1082:             .Column3.Width            = 65
1083:             .Column4.Header1.Caption  = "Saldo"
1084:             .Column4.Width            = 65
1085:             .Column5.Header1.Caption  = "Qtd.Baixa"
1086:             .Column5.Width            = 65
1087:             .Column6.Header1.Caption  = "Produzir"
1088:             .Column6.Width            = 65
1089:             .Column7.Header1.Caption  = ""
1090:             .Column7.Width            = 50
1091:             .Column8.Header1.Caption  = "Peso"
1092:             .Column8.Width            = 65
1093:             .Column9.Header1.Caption  = CHR(37) + "Ent."
1094:             .Column9.Width            = 55
1095:             .Column10.Header1.Caption = "Tam."
1096:             .Column10.Width           = 50
1097:             .Visible = .T.
1098:         ENDWITH
1099: 
1100:         *-- Container de observacoes do pedido (Container1 no legado)
1101:         *-- Top=173+29=202, Left=614, Width=373, Height=164
1102:         loc_oPagina.AddObject("cnt_4c_ObsItem", "Container")
1103:         WITH loc_oPagina.cnt_4c_ObsItem
1104:             .Top         = 202
1105:             .Left        = 614
1106:             .Width       = 373
1107:             .Height      = 164
1108:             .BackStyle   = 1
1109:             .BackColor   = RGB(240, 240, 240)
1110:             .BorderWidth = 0
1111:             .Visible     = .T.
1112: 
1113:             .AddObject("lbl_4c_ObsLbl", "Label")
1114:             WITH .lbl_4c_ObsLbl
1115:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1116:                 .Top       = 3
1117:                 .Left      = 7
1118:                 .Width     = 69
1119:                 .Height    = 15
1120:                 .AutoSize  = .F.
1121:                 .FontName  = "Tahoma"
1122:                 .FontSize  = 8

*-- Linhas 1128 a 1137:
1128:             .AddObject("txt_4c_ObsMemo", "EditBox")
1129:             WITH .txt_4c_ObsMemo
1130:                 .Value         = ""
1131:                 .Top           = 20
1132:                 .Left          = 7
1133:                 .Width         = 359
1134:                 .Height        = 138
1135:                 .ReadOnly      = .T.
1136:                 .FontName      = "Tahoma"
1137:                 .FontSize      = 8

*-- Linhas 1143 a 1155:
1143: 
1144:         *-- Say2 "Descricao" + txt_4c_Descr (produto selecionado no grid)
1145:         *-- Say2 Top=546+29=575, Left=23
1146:         loc_oPagina.AddObject("lbl_4c_DescrLbl", "Label")
1147:         WITH loc_oPagina.lbl_4c_DescrLbl
1148:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1149:             .Top       = 575
1150:             .Left      = 23
1151:             .Width     = 60
1152:             .Height    = 15
1153:             .AutoSize  = .F.
1154:             .FontName  = "Tahoma"
1155:             .FontSize  = 8

*-- Linhas 1161 a 1170:
1161:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
1162:         WITH loc_oPagina.txt_4c_Descr
1163:             .Value         = ""
1164:             .Top           = 591
1165:             .Left          = 23
1166:             .Width         = 454
1167:             .Height        = 23
1168:             .ReadOnly      = .T.
1169:             .FontName      = "Tahoma"
1170:             .FontSize      = 8

*-- Linhas 1179 a 1201:
1179:         *-- Top=365+29=394, Left=762, Width=225, Height=163
1180:         loc_oPagina.AddObject("img_4c_FigJpg", "Image")
1181:         WITH loc_oPagina.img_4c_FigJpg
1182:             .Top     = 394
1183:             .Left    = 762
1184:             .Width   = 225
1185:             .Height  = 163
1186:             .Visible = .F.
1187:             .Stretch = 2
1188:         ENDWITH
1189: 
1190:         *-- Say_Obs "Observacao do item" + txt_4c_ObsItem (editbox, read-only)
1191:         *-- Say_Obs Top=544+29=573, Left=496
1192:         loc_oPagina.AddObject("lbl_4c_ObsItemLbl", "Label")
1193:         WITH loc_oPagina.lbl_4c_ObsItemLbl
1194:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do item"
1195:             .Top       = 573
1196:             .Left      = 496
1197:             .Width     = 100
1198:             .Height    = 15
1199:             .AutoSize  = .F.
1200:             .FontName  = "Tahoma"
1201:             .FontSize  = 8

*-- Linhas 1207 a 1237:
1207:         loc_oPagina.AddObject("txt_4c_ObsItem", "EditBox")
1208:         WITH loc_oPagina.txt_4c_ObsItem
1209:             .Value         = ""
1210:             .Top           = 590
1211:             .Left          = 496
1212:             .Width         = 454
1213:             .Height        = 24
1214:             .ReadOnly      = .T.
1215:             .FontName      = "Tahoma"
1216:             .FontSize      = 8
1217:             .ForeColor     = RGB(90, 90, 90)
1218:             .BackColor     = RGB(240, 240, 240)
1219:             .BorderStyle   = 1
1220:             .Visible       = .T.
1221:         ENDWITH
1222: 
1223:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar,         "Click",             THIS, "BtnConfirmarClick")
1224:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,          "Click",             THIS, "BtnCancelarClick")
1225:         BINDEVENT(loc_oPagina.cmd_4c_Entrega,                         "Click",             THIS, "BtnEntregaClick")
1226:         BINDEVENT(loc_oPagina.cmd_4c_SubNiveis,                       "Click",             THIS, "BtnSubNiveisClick")
1227:         BINDEVENT(loc_oPagina.grd_4c_Itens,                           "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
1228:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaO,            "KeyPress",          THIS, "ContaOKeyPress")
1229:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaO,            "DblClick",          THIS, "ContaODblClick")
1230:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaD,            "KeyPress",          THIS, "ContaDKeyPress")
1231:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaD,            "DblClick",          THIS, "ContaDDblClick")
1232:         BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros,      "Click",             THIS, "BtnCadastrosClick")
1233:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_DcontaD,           "KeyPress",         THIS, "DcontaDLostFocus")
1234:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_Dresps,            "KeyPress",         THIS, "DrespsDLostFocus")
1235: 
1236:         THIS.TornarControlesVisiveis(loc_oPagina)
1237:     ENDPROC

*-- Linhas 1285 a 1303:
1285:                 loc_oGrid.Column9.ControlSource    = "csTemporario.PStatus"
1286:                 loc_oGrid.Column10.ControlSource   = "csTemporario.Emps"
1287:                 loc_oGrid.Column11.ControlSource   = "csTemporario.Empds"
1288:                 loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
1289:                 loc_oGrid.Column2.Header1.Caption  = "Data"
1290:                 loc_oGrid.Column3.Header1.Caption  = "Grupo"
1291:                 loc_oGrid.Column4.Header1.Caption  = "Origem"
1292:                 loc_oGrid.Column5.Header1.Caption  = "Grupo"
1293:                 loc_oGrid.Column6.Header1.Caption  = "Destino"
1294:                 loc_oGrid.Column7.Header1.Caption  = "Doc.Op"
1295:                 loc_oGrid.Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
1296:                 loc_oGrid.Column9.Header1.Caption  = "Status"
1297:                 loc_oGrid.Column10.Header1.Caption = "EmpO"
1298:                 loc_oGrid.Column11.Header1.Caption = "EmpD"
1299:                 loc_oGrid.Refresh()
1300:                 THIS.FormatarGridLista(loc_oGrid)
1301:                 loc_lResultado = .T.
1302:                 ENDIF
1303:             ENDIF

*-- Linhas 1458 a 1475:
1458:                 loc_oGrid.Column9.ControlSource   = "cursor_4c_Itens.descvals"
1459:                 loc_oGrid.Column10.ControlSource  = "cursor_4c_Itens.codtams"
1460: 
1461:                 loc_oGrid.Column1.Header1.Caption  = "Produto"
1462:                 loc_oGrid.Column2.Header1.Caption  = "Produzido"
1463:                 loc_oGrid.Column3.Header1.Caption  = "Qtd."
1464:                 loc_oGrid.Column4.Header1.Caption  = "Saldo"
1465:                 loc_oGrid.Column5.Header1.Caption  = "Qtd.Baixa"
1466:                 loc_oGrid.Column6.Header1.Caption  = "Produzir"
1467:                 loc_oGrid.Column7.Header1.Caption  = ""
1468:                 loc_oGrid.Column8.Header1.Caption  = "Peso"
1469:                 loc_oGrid.Column9.Header1.Caption  = CHR(37) + "Ent."
1470:                 loc_oGrid.Column10.Header1.Caption = "Tam."
1471: 
1472:                 loc_oGrid.Refresh()
1473: 
1474:                 *-- Exibir descricao/foto do primeiro item se houver registros
1475:                 IF RECCOUNT("cursor_4c_Itens") > 0

*-- Linhas 1653 a 1673:
1653:     PROCEDURE DcontaDLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1654:         LOCAL loc_oErro
1655:         TRY
1656:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1657:         CATCH TO loc_oErro
1658:             MsgErro(loc_oErro.Message, "Erro")
1659:         ENDTRY
1660:     ENDPROC
1661: 
1662:     *--------------------------------------------------------------------------
1663:     * DrespsDLostFocus - Move foco para botao Confirmar
1664:     *--------------------------------------------------------------------------
1665:     PROCEDURE DrespsDLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1666:         LOCAL loc_oErro
1667:         TRY
1668:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1669:         CATCH TO loc_oErro
1670:             MsgErro(loc_oErro.Message, "Erro")
1671:         ENDTRY
1672:     ENDPROC
1673: 

*-- Linhas 1857 a 1865:
1857:                     loc_oGrid.ColumnCount  = 1
1858:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Operacao.Dopes"
1859:                     loc_oGrid.Column1.Width           = 110
1860:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1861:                     loc_oGrid.Refresh()
1862:                 ENDIF
1863:                 loc_lResultado = .T.
1864:             ENDIF
1865:         CATCH TO loc_oErro

*-- Linhas 2012 a 2021:
2012:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2013:         LOCAL loc_oErro
2014:         TRY
2015:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Consultar", 5)
2016:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Consultar.Enabled = .T.
2017:             ENDIF
2018:         CATCH TO loc_oErro
2019:             MsgErro(loc_oErro.Message, "Erro")
2020:         ENDTRY
2021:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* sigpres2BO.prg - Business Object para Pedido de Estoque (SIGPRES2)
* Herda de: BusinessBase
* Tabela principal: SigMvPec (PK: cidchaves, chave negocio: empdopnums)
* Itens: SigMvItn (join SigMvIts para cor/tamanho)
*==============================================================================
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Identificacao da tabela principal
    this_cTabela      = "SigMvPec"
    this_cCampoChave  = "cidchaves"

    *-- Chave de negocio composta (emps+dopes+numes)
    this_cEmpdopnums  = ""

    *-- Campos de SigMvPec (schema exato)
    this_cEmps        = ""
    this_cDopes       = ""
    this_nNumes       = 0
    this_nCodigos     = 0
    this_dDatatrans   = {}
    this_nNtrans      = 0
    this_cLocals      = ""
    this_nValobxs     = 0
    this_cCidchaves   = ""
    this_cEmpsubs     = ""
    this_dDatas       = {}
    this_lChksubn     = .F.
    this_dDtagends    = {}
    this_lChkpagos    = .F.
    this_nNparcs      = 0
    this_nValps       = 0
    this_nValvars     = 0
    this_dVencps      = {}
    this_cPStatus     = ""

    *-- Campos adicionais do csTemporario (origem/destino contabil)
    this_cGrupoOs     = ""
    this_cContaOs     = ""
    this_cGrupoDs     = ""
    this_cContaDs     = ""
    this_cEmpds       = ""
    this_cUsuars      = ""
    this_nNops        = 0
    this_cVends       = ""
    this_cGrvends     = ""
    this_cTabds       = ""
    this_cObses       = ""
    this_dPrazoents   = {}
    this_cMascnum     = ""
    this_cNotas       = ""
    this_lChkBxParcs  = .F.

    *-- Descricoes (preenchidas por lookup em tempo de execucao)
    this_cDconta      = ""
    this_cDcontad     = ""
    this_cDresps      = ""

    *-- Referencia ao form pai (para navegacao/callbacks)
    this_oParentForm  = .NULL.

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvPec"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps        = TratarNulo(emps,       "C")
                THIS.this_cDopes       = TratarNulo(dopes,      "C")
                THIS.this_nNumes       = TratarNulo(numes,      "N")
                THIS.this_nCodigos     = TratarNulo(codigos,    "N")
                THIS.this_dDatatrans   = TratarNulo(datatrans,  "D")
                THIS.this_nNtrans      = TratarNulo(ntrans,     "N")
                THIS.this_cLocals      = TratarNulo(locals,     "C")
                THIS.this_nValobxs     = TratarNulo(valobxs,    "N")
                THIS.this_cCidchaves   = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpdopnums  = TratarNulo(empdopnums, "C")
                THIS.this_cEmpsubs     = TratarNulo(empsubns,   "C")
                THIS.this_dDatas       = TratarNulo(datas,      "D")
                THIS.this_lChksubn     = ConverterParaLogico(chksubn)
                THIS.this_dDtagends    = TratarNulo(dtagends,   "D")
                THIS.this_lChkpagos    = ConverterParaLogico(chkpagos)
                THIS.this_nNparcs      = TratarNulo(nparcs,     "N")
                THIS.this_nValps       = TratarNulo(valps,      "N")
                THIS.this_nValvars     = TratarNulo(valvars,    "N")
                THIS.this_dVencps      = TratarNulo(vencps,     "D")
                THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursorTemporario - Carrega campos do csTemporario (form)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursorTemporario(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps        = TratarNulo(emps,       "C")
                THIS.this_cEmpds       = TratarNulo(empds,      "C")
                THIS.this_cDopes       = TratarNulo(dopes,      "C")
                THIS.this_nNumes       = TratarNulo(numes,      "N")
                THIS.this_dDatas       = TratarNulo(datas,      "D")
                THIS.this_cGrupoOs     = TratarNulo(grupoos,    "C")
                THIS.this_cContaOs     = TratarNulo(contaos,    "C")
                THIS.this_cGrupoDs     = TratarNulo(grupods,    "C")
                THIS.this_cContaDs     = TratarNulo(contads,    "C")
                THIS.this_nNops        = TratarNulo(nops,       "N")
                THIS.this_cUsuars      = TratarNulo(usuars,     "C")
                THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
                THIS.this_cVends       = TratarNulo(vends,      "C")
                THIS.this_cGrvends     = TratarNulo(grvends,    "C")
                THIS.this_cTabds       = TratarNulo(tabds,      "C")
                THIS.this_cObses       = TratarNulo(obses,      "C")
                THIS.this_dPrazoents   = TratarNulo(prazoents,  "D")
                THIS.this_cMascnum     = TratarNulo(mascnum,    "C")
                THIS.this_cNotas       = TratarNulo(notas,      "C")
                THIS.this_lChksubn     = ConverterParaLogico(chksubn)
                THIS.this_lChkBxParcs  = ConverterParaLogico(chkbxparcs)
                THIS.this_cEmpdopnums  = ALLTRIM(THIS.this_cEmps) + ;
                                         ALLTRIM(THIS.this_cDopes) + ;
                                         STR(THIS.this_nNumes, 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro do SigMvPec pela chave de negocio
    * par_cEmpdopnums: emps+dopes+numes(6) concatenados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigMvPec WHERE empdopnums = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpdopnums))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigMvPec conforme filtro
    * par_cFiltro: clausula WHERE adicional (sem o WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere
        loc_lResultado = .F.
        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = "SELECT emps, dopes, numes, datas, pstatus, cidchaves," + ;
                       " empdopnums, valobxs, nparcs, valps, valvars, vencps" + ;
                       " FROM SigMvPec" + loc_cWhere + ;
                       " ORDER BY empdopnums"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItens - Carrega cursor xEestI com itens do pedido
    * par_cEmpdopnums: chave composta do pedido
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItens(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT ISNULL(b.codtams,'') AS codtams," + ;
                       " ISNULL(b.codcors,'') AS codcors, b.qtds AS QtdsS, a.*" + ;
                       " FROM SigMvItn a" + ;
                       " LEFT JOIN SigMvIts b ON a.empdopnums = b.empdopnums" + ;
                       " AND a.cpros = b.cpros AND a.citens = b.citens" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(ALLTRIM(par_cEmpdopnums))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvItn") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCursorItens - Agrega itens por cpros+codcors+codtams para o grid
    * Precisa que crSigMvItn ja esteja carregado (via BuscarItens)
    *--------------------------------------------------------------------------
    PROCEDURE MontarCursorItens(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF !USED("crSigMvItn")
                IF !THIS.BuscarItens(par_cEmpdopnums)
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_cSQL = "SELECT empdopnums, cpros, codcors, codtams," + ;
                       " SUM(qtds) AS qtds, SUM(qtdss) AS qtdss," + ;
                       " MAX(qtbaixas) AS qtbaixas, MAX(qtprods) AS qtprods," + ;
                       " MAX(qtbxprods) AS qtbxprods, 0 AS citens," + ;
                       " SUM(tpesos) AS tpesos, SUM(descvals) AS descvals" + ;
                       " FROM crSigMvItn" + ;
                       " GROUP BY empdopnums, cpros, codcors, codtams"
            SELECT &loc_cSQL INTO CURSOR crSigMvItn READWRITE

            IF !USED("xEestI")
                CREATE CURSOR xEestI (empdopnums C(29), cpros C(14), codcors C(4), ;
                    codtams C(4), qtds N(11,3), qtdss N(11,3), qtbaixas N(11,3), ;
                    qtprods N(11,3), qtbxprods N(11,3), citens N(4,0), ;
                    tpesos N(11,2), descvals N(11,2), DPros C(50), OBS M)
            ELSE
                ZAP IN xEestI
            ENDIF

            SELECT crSigMvItn
            INDEX ON EmpDopNums TAG EmpDopNums

            LOCAL loc_nI, loc_nQtds, loc_nQtdss
            FOR loc_nI = 1 TO RECCOUNT("crSigMvItn")
                GO loc_nI IN crSigMvItn
                SELECT crSigMvItn
                SCATTER MEMVAR MEMO

                IF !EMPTY(ALLTRIM(m.codtams)) OR !EMPTY(ALLTRIM(m.codcors))
                    m.qtds = m.qtdss
                ENDIF

                LOCAL loc_cSQLPro
                loc_cSQLPro = "SELECT cpros, DPros, PesoMs FROM SigCdPro" + ;
                              " WHERE cpros = " + EscaparSQL(ALLTRIM(m.cpros))
                IF SQLEXEC(gnConnHandle, loc_cSQLPro, "crSigCdPro") > 0 AND ;
                   RECCOUNT("crSigCdPro") > 0
                    m.tpesos   = crSigCdPro.PesoMs * m.qtds
                    m.descvals = (m.qtbaixas / IIF(m.qtds <> 0, m.qtds, 1)) * 100
                    m.DPros    = ALLTRIM(crSigCdPro.DPros)
                    IF USED("crSigCdPro")
                        USE IN crSigCdPro
                    ENDIF
                ENDIF

                INSERT INTO xEestI FROM MEMVAR
            ENDFOR

            *-- Linha de TOTAL
            LOCAL loc_nTqtd, loc_nTqtdb, loc_nTpeso, loc_nTQtPrd, loc_nTQtBxprd
            SELECT xEestI
            SUM qtds, qtbaixas, tpesos, qtprods, qtbxprods ;
                TO loc_nTqtd, loc_nTqtdb, loc_nTpeso, loc_nTQtPrd, loc_nTQtBxprd
            APPEND BLANK IN xEestI
            SELECT xEestI
            REPLACE cpros    WITH "TOTAL ->", ;
                    qtds     WITH loc_nTqtd, ;
                    qtbaixas WITH loc_nTqtdb, ;
                    tpesos   WITH loc_nTpeso, ;
                    qtprods  WITH loc_nTQtPrd, ;
                    qtbxprods WITH loc_nTQtBxprd, ;
                    descvals WITH ((loc_nTqtdb / IIF(loc_nTqtd <> 0, loc_nTqtd, 1)) * 100)
            GO TOP IN xEestI

            *-- Index para busca por produto+tamanho
            SELECT xEestI
            INDEX ON ALLTRIM(cpros) + ALLTRIM(codtams) TAG Tamanho

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMascaraNumeracao - Busca MascNums de SigCdPam para o tipo de OP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMascaraNumeracao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 MascNums FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam") > 0 AND ;
               RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                THIS.this_cMascnum = ALLTRIM(crSigCdPam.MascNums)
                loc_lResultado = .T.
                IF USED("crSigCdPam")
                    USE IN crSigCdPam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTipoOperacao - Busca dados de SigCdOpe para o tipo op
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTipoOperacao(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopes))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe") > 0 AND ;
               RECCOUNT("crSigCdOpe") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarSubDadosOperacao - Busca SigOpCdc para tipo de operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubDadosOperacao(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigOpCdc WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopes))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpCdc") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoCliente - Busca Rclis de SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricaoCliente(par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_cDescricao
        loc_lResultado = .F.
        loc_cDescricao = ""
        TRY
            IF !EMPTY(ALLTRIM(par_cConta))
                loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cConta))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli") > 0 AND ;
                   RECCOUNT("crSigCdCli") > 0
                    loc_cDescricao = ALLTRIM(crSigCdCli.Rclis)
                    loc_lResultado = .T.
                ENDIF
                IF USED("crSigCdCli")
                    USE IN crSigCdCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_cDconta = loc_cDescricao
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Persiste alteracoes do csTemporario de volta ao SigMvPec
    * Atualiza apenas os campos editaveis pelo usuario neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarAtualizacao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigMvPec SET" + ;
                       " grupoos = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
                       " contaos = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
                       " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
                       " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
                       " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                       " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;
                       " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                       " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ;
                       " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui pedido do SigMvPec (e itens relacionados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigMvItn WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigMvIts WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigMvPec WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigMvPec com todos os campos obrigatorios
    * cidchaves gerado como emps(3)+dopes(10)+numes(6)+segundos(1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_cCidchaves, loc_cEmpdopnums
        loc_lResultado = .F.
        TRY
            *-- Gerar cidchaves (char 20): emps 3 + dopes 10 + numes 6 + tick 1
            loc_cEmpdopnums = LEFT(ALLTRIM(THIS.this_cEmps) + SPACE(3), 3) + ;
                              LEFT(ALLTRIM(THIS.this_cDopes) + SPACE(20), 20) + ;
                              RIGHT("      " + ALLTRIM(STR(THIS.this_nNumes, 6)), 6)
            loc_cCidchaves  = LEFT(loc_cEmpdopnums, 19) + ;
                              RIGHT(ALLTRIM(STR(INT(SECONDS()), 1)), 1)

            THIS.this_cCidchaves  = LEFT(loc_cCidchaves, 20)
            THIS.this_cEmpdopnums = LEFT(loc_cEmpdopnums, 29)

            loc_cSQL = "INSERT INTO SigMvPec" + ;
                       " (emps, dopes, numes, codigos, datatrans, ntrans," + ;
                       "  locals, valobxs, cidchaves, empdopnums, empsubns," + ;
                       "  datas, chksubn, dtagends, chkpagos, nparcs," + ;
                       "  valps, valvars, vencps, pstatus)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cLocals), 10)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValobxs) + "," + ;
                       EscaparSQL(THIS.this_cCidchaves) + "," + ;
                       EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpsubs), 3)) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       IIF(THIS.this_lChksubn, "1", "0") + "," + ;
                       FormatarDataSQL(THIS.this_dDtagends) + "," + ;
                       IIF(THIS.this_lChkpagos, "1", "0") + "," + ;
                       FormatarNumeroSQL(THIS.this_nNparcs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValvars) + "," + ;
                       FormatarDataSQL(THIS.this_dVencps) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPStatus), 1)) + ;
                       ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

