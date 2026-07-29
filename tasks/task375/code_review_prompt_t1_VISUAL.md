# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [ALINHAMENTO] Botao 'cmd_4c_Confirmar' tem Top=5 mas grupo usa Top=17 (diferenca de 12px)
- [FONTNAME-ERRADO] Linha 243: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 266: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 289: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 324: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 438: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 461: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1941: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNF.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2770 linhas total):

*-- Linhas 51 a 59:
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             THIS.Caption = "Corre" + CHR(231) + CHR(227) + "o de Notas Fiscais"
55: 
56:             THIS.this_oBusinessObject = CREATEOBJECT("CNFBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
59:                 THIS.this_cMensagemErro = "Erro ao criar CNFBO"

*-- Linhas 108 a 117:
108:                 THIS.ConfigurarBindings()
109: 
110:                 *-- Propagar caption para label do cabecalho
111:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
112:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113: 
114:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
115:                     IF !THIS.CarregarLista()
116:                         *-- falha nao impede abertura
117:                     ENDIF

*-- Linhas 141 a 161:
141:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
142: 
143:         WITH THIS.pgf_4c_Paginas
144:             .Top       = -29
145:             .Left      = 0
146:             .Width     = 1000
147:             .Height    = 629
148:             .PageCount = 2
149:             .Tabs      = .F.
150:             .Visible   = .T.
151: 
152:             .Page1.Caption   = "Lista"
153:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
154:             .Page1.BackColor = RGB(255, 255, 255)
155: 
156:             .Page2.Caption   = "Dados"
157:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
158:             .Page2.BackColor = RGB(255, 255, 255)
159:         ENDWITH
160:     ENDPROC
161: 

*-- Linhas 175 a 213:
175:         *-- Cabecalho escuro com titulo (cntSombra do legado: Top=2 -> 31)
176:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
177:         WITH loc_oPagina.cnt_4c_Cabecalho
178:             .Top         = 31
179:             .Left        = 0
180:             .Width       = THIS.Width
181:             .Height      = 80
182:             .BackStyle   = 1
183:             .BackColor   = RGB(100, 100, 100)
184:             .BorderWidth = 0
185:             .Visible     = .T.
186:         ENDWITH
187: 
188:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
189:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
190:             .Caption   = THIS.Caption
191:             .Top       = 17
192:             .Left      = 12
193:             .Width     = THIS.Width - 20
194:             .Height    = 46
195:             .FontName  = "Tahoma"
196:             .FontSize  = 16
197:             .FontBold  = .T.
198:             .AutoSize  = .F.
199:             .BackStyle = 0
200:             .ForeColor = RGB(0, 0, 0)
201:             .Visible   = .T.
202:         ENDWITH
203: 
204:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
205:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
206:             .Caption   = THIS.Caption
207:             .Top       = 20
208:             .Left      = 10
209:             .Width     = THIS.Width - 20
210:             .Height    = 46
211:             .FontName  = "Tahoma"
212:             .FontSize  = 16
213:             .FontBold  = .T.

*-- Linhas 222 a 295:
222:         *-- Novo: posicao relativa ao canvas - lado direito sobre o cabecalho
223:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
224:         WITH loc_oPagina.cnt_4c_Botoes
225:             .Top         = 29
226:             .Left        = 542
227:             .Width       = 370
228:             .Height      = 85
229:             .BackStyle   = 0
230:             .BorderWidth = 0
231:             .Visible     = .T.
232:         ENDWITH
233: 
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_InserirCarta", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_InserirCarta
236:             .Caption         = "Incluir"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
238:             .PicturePosition = 13
239:             .Width           = 75
240:             .Height          = 75
241:             .Left            = 5
242:             .Top             = 5
243:             .FontName        = "Comic Sans MS"
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .FontSize        = 8
247:             .ForeColor       = RGB(90, 90, 90)
248:             .BackColor       = RGB(255, 255, 255)
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .MousePointer    = 15
252:             .WordWrap        = .T.
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256: 
257:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_AlteraCarta", "CommandButton")
258:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_AlteraCarta
259:             .Caption         = "Alterar"
260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
261:             .PicturePosition = 13
262:             .Width           = 75
263:             .Height          = 75
264:             .Left            = 80
265:             .Top             = 5
266:             .FontName        = "Comic Sans MS"
267:             .FontBold        = .T.
268:             .FontItalic      = .T.
269:             .FontSize        = 8
270:             .ForeColor       = RGB(90, 90, 90)
271:             .BackColor       = RGB(255, 255, 255)
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .MousePointer    = 15
275:             .WordWrap        = .T.
276:             .AutoSize        = .F.
277:             .Visible         = .T.
278:         ENDWITH
279: 
280:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_ImpCarta", "CommandButton")
281:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_ImpCarta
282:             .Caption         = "Imprimir"
283:             .Picture         = gc_4c_CaminhoIcones + "relatorio_imprimir_60.jpg"
284:             .PicturePosition = 13
285:             .Width           = 75
286:             .Height          = 75
287:             .Left            = 155
288:             .Top             = 5
289:             .FontName        = "Comic Sans MS"
290:             .FontBold        = .T.
291:             .FontItalic      = .T.
292:             .FontSize        = 8
293:             .ForeColor       = RGB(90, 90, 90)
294:             .BackColor       = RGB(255, 255, 255)
295:             .Themes          = .F.

*-- Linhas 303 a 330:
303:         *-- Container Saida/Encerrar - padrao canonico (Left=917, Width=90)
304:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
305:         WITH loc_oPagina.cnt_4c_Saida
306:             .Top         = 29
307:             .Left        = 917
308:             .Width       = 90
309:             .Height      = 85
310:             .BackStyle   = 0
311:             .BorderWidth = 0
312:             .Visible     = .T.
313:         ENDWITH
314: 
315:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
316:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
317:             .Caption         = "Encerrar"
318:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
319:             .PicturePosition = 13
320:             .Width           = 75
321:             .Height          = 75
322:             .Left            = 5
323:             .Top             = 5
324:             .FontName        = "Comic Sans MS"
325:             .FontBold        = .T.
326:             .FontItalic      = .T.
327:             .FontSize        = 8
328:             .ForeColor       = RGB(90, 90, 90)
329:             .BackColor       = RGB(255, 255, 255)
330:             .Themes          = .F.

*-- Linhas 338 a 347:
338:         *-- Container de filtros (cntFiltros do legado: top=164, height=48)
339:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
340:         WITH loc_oPagina.cnt_4c_Filtros
341:             .Top         = 116
342:             .Left        = 0
343:             .Width       = THIS.Width
344:             .Height      = 48
345:             .BackStyle   = 1
346:             .BackColor   = RGB(210, 210, 210)
347:             .BorderWidth = 0

*-- Linhas 355 a 398:
355:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
356:         loc_oGrid = loc_oPagina.grd_4c_Lista
357:         WITH loc_oGrid
358:             .Top          = 166
359:             .Left         = 0
360:             .Width        = THIS.Width
361:             .Height       = 461
362:             .ReadOnly     = .T.
363:             .ColumnCount  = 4
364:             .Visible      = .T.
365:         ENDWITH
366: 
367:         WITH loc_oGrid.Column1
368:             .ControlSource = "cursor_4c_Dados.nfis"
369:             .Width         = 70
370:             .Alignment     = 2
371:         ENDWITH
372:         loc_oGrid.Column1.Header1.Caption = "NF N" + CHR(176)
373: 
374:         WITH loc_oGrid.Column2
375:             .ControlSource = "cursor_4c_Dados.emis"
376:             .Width         = 95
377:             .Alignment     = 2
378:         ENDWITH
379:         loc_oGrid.Column2.Header1.Caption = "Emiss" + CHR(227) + "o"
380: 
381:         WITH loc_oGrid.Column3
382:             .ControlSource = "cursor_4c_Dados.totnotas"
383:             .Width         = 120
384:             .Alignment     = 2
385:         ENDWITH
386:         loc_oGrid.Column3.Header1.Caption = "Total NF"
387: 
388:         WITH loc_oGrid.Column4
389:             .ControlSource = "cursor_4c_Dados.rclis"
390:             .Width         = 715
391:             .Alignment     = 2
392:         ENDWITH
393:         loc_oGrid.Column4.Header1.Caption = "Cliente / Fornecedor"
394: 
395:         loc_oGrid.ColumnCount = 3
396:         loc_oGrid.RecordSource = "cursor_4c_Dados"
397: 
398:         *-- NFs com carta de correcao em vermelho (legado: DynamicForeColor em Grade)

*-- Linhas 419 a 467:
419:         *-- Container Salva: Confirmar + Cancelar (Grupo_Salva do legado: top=4 -> 33)
420:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
421:         WITH loc_oPagina.cnt_4c_Salva
422:             .Top         = 33
423:             .Left        = 842
424:             .Width       = 160
425:             .Height      = 85
426:             .BackStyle   = 0
427:             .BorderWidth = 0
428:             .Visible     = .T.
429:         ENDWITH
430: 
431:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
432:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
433:             .Caption         = "Confirmar"
434:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
435:             .PicturePosition = 13
436:             .Width           = 75
437:             .Height          = 75
438:             .Left            = 5
439:             .Top             = 5
440:             .FontName        = "Comic Sans MS"
441:             .FontBold        = .T.
442:             .FontItalic      = .T.
443:             .FontSize        = 8
444:             .ForeColor       = RGB(90, 90, 90)
445:             .BackColor       = RGB(255, 255, 255)
446:             .Themes          = .F.
447:             .SpecialEffect   = 0
448:             .MousePointer    = 15
449:             .WordWrap        = .T.
450:             .AutoSize        = .F.
451:             .Visible         = .T.
452:         ENDWITH
453: 
454:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
455:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
456:             .Caption         = "Encerrar"
457:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
458:             .PicturePosition = 13
459:             .Width           = 75
460:             .Height          = 75
461:             .Left            = 80
462:             .Top             = 5
463:             .FontName        = "Comic Sans MS"
464:             .FontBold        = .T.
465:             .FontItalic      = .T.
466:             .FontSize        = 8
467:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 481 a 592:
481:         loc_oPagina.AddObject("cnt_4c_DadosCab", "Container")
482:         loc_oCab = loc_oPagina.cnt_4c_DadosCab
483:         WITH loc_oCab
484:             .Top         = 33
485:             .Left        = 15
486:             .Width       = 820
487:             .Height      = 115
488:             .BackStyle   = 0
489:             .BorderWidth = 0
490:             .Visible     = .T.
491:         ENDWITH
492: 
493:         *-- Row 1 esq: Say1 "Operacao" (original top=14, left=72 -> cnt top=10, left=57)
494:         loc_oCab.AddObject("lbl_4c_SayOpe", "Label")
495:         WITH loc_oCab.lbl_4c_SayOpe
496:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
497:             .Top       = 10
498:             .Left      = 57
499:             .Height    = 15
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .BackStyle = 0
503:             .ForeColor = RGB(53, 53, 53)
504:             .AutoSize  = .T.
505:             .Visible   = .T.
506:         ENDWITH
507: 
508:         *-- Get_dope (original top=29, left=72, width=150 -> cnt top=25, left=57)
509:         loc_oCab.AddObject("txt_4c_Dope", "TextBox")
510:         WITH loc_oCab.txt_4c_Dope
511:             .Top       = 25
512:             .Left      = 57
513:             .Width     = 150
514:             .Height    = 21
515:             .MaxLength = 20
516:             .FontName  = "Tahoma"
517:             .FontSize  = 8
518:             .ReadOnly  = .T.
519:             .Value     = ""
520:             .Visible   = .T.
521:         ENDWITH
522: 
523:         *-- Row 1 dir: Say_Emissao "Data Emissao" (original top=10, left=455 -> cnt top=6, left=440)
524:         loc_oCab.AddObject("lbl_4c_SayEmissao", "Label")
525:         WITH loc_oCab.lbl_4c_SayEmissao
526:             .Caption   = "Data Emiss" + CHR(227) + "o"
527:             .Top       = 6
528:             .Left      = 440
529:             .Height    = 15
530:             .FontName  = "Tahoma"
531:             .FontSize  = 8
532:             .BackStyle = 0
533:             .ForeColor = RGB(53, 53, 53)
534:             .AutoSize  = .T.
535:             .Visible   = .T.
536:         ENDWITH
537: 
538:         *-- Get_Emissao (original top=25, left=455, width=80 -> cnt top=21, left=440)
539:         loc_oCab.AddObject("txt_4c_DtEmissao", "TextBox")
540:         WITH loc_oCab.txt_4c_DtEmissao
541:             .Top       = 21
542:             .Left      = 440
543:             .Width     = 80
544:             .Height    = 21
545:             .FontName  = "Tahoma"
546:             .FontSize  = 8
547:             .ReadOnly  = .T.
548:             .Value     = {}
549:             .Visible   = .T.
550:         ENDWITH
551: 
552:         *-- Row 2 esq: Say2 "Numero" (original top=51, left=71 -> cnt top=47, left=56)
553:         loc_oCab.AddObject("lbl_4c_SayNum", "Label")
554:         WITH loc_oCab.lbl_4c_SayNum
555:             .Caption   = "N" + CHR(250) + "mero"
556:             .Top       = 47
557:             .Left      = 56
558:             .Height    = 15
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .BackStyle = 0
562:             .ForeColor = RGB(53, 53, 53)
563:             .AutoSize  = .T.
564:             .Visible   = .T.
565:         ENDWITH
566: 
567:         *-- Get_Numero (original top=66, left=71, width=52 -> cnt top=62, left=56)
568:         loc_oCab.AddObject("txt_4c_Numes", "TextBox")
569:         WITH loc_oCab.txt_4c_Numes
570:             .Top       = 62
571:             .Left      = 56
572:             .Width     = 52
573:             .Height    = 21
574:             .MaxLength = 8
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .ReadOnly  = .T.
578:             .Value     = ""
579:             .Visible   = .T.
580:         ENDWITH
581: 
582:         *-- Say7 "Serie" (original top=51, left=143 -> cnt top=47, left=128)
583:         loc_oCab.AddObject("lbl_4c_SaySerie", "Label")
584:         WITH loc_oCab.lbl_4c_SaySerie
585:             .Caption   = "S" + CHR(233) + "rie"
586:             .Top       = 47
587:             .Left      = 128
588:             .Height    = 15
589:             .FontName  = "Tahoma"
590:             .FontSize  = 8
591:             .BackStyle = 0
592:             .ForeColor = RGB(53, 53, 53)

*-- Linhas 598 a 623:
598:         *-- Atencao: diferente de txt_4c_Serie do filtro (Page1)
599:         loc_oCab.AddObject("txt_4c_NfSerie", "TextBox")
600:         WITH loc_oCab.txt_4c_NfSerie
601:             .Top       = 62
602:             .Left      = 128
603:             .Width     = 34
604:             .Height    = 21
605:             .MaxLength = 8
606:             .FontName  = "Tahoma"
607:             .FontSize  = 8
608:             .ReadOnly  = .T.
609:             .Value     = ""
610:             .Visible   = .T.
611:         ENDWITH
612: 
613:         *-- Say4 "NF no" (original top=51, left=196 -> cnt top=47, left=181)
614:         loc_oCab.AddObject("lbl_4c_SayNfNum", "Label")
615:         WITH loc_oCab.lbl_4c_SayNfNum
616:             .Caption   = "NF n" + CHR(176)
617:             .Top       = 47
618:             .Left      = 181
619:             .Height    = 15
620:             .FontName  = "Tahoma"
621:             .FontSize  = 8
622:             .BackStyle = 0
623:             .ForeColor = RGB(53, 53, 53)

*-- Linhas 629 a 727:
629:         *-- Legado: When=InList(pcEscolha,'PROCURAR'); LostFocus=SetFocus Salva
630:         loc_oCab.AddObject("txt_4c_Nota", "TextBox")
631:         WITH loc_oCab.txt_4c_Nota
632:             .Top       = 62
633:             .Left      = 181
634:             .Width     = 52
635:             .Height    = 21
636:             .MaxLength = 6
637:             .FontName  = "Tahoma"
638:             .FontSize  = 8
639:             .ReadOnly  = .T.
640:             .Value     = ""
641:             .Visible   = .T.
642:         ENDWITH
643: 
644:         *-- Say8 "Especie" (original top=51, left=257 -> cnt top=47, left=242)
645:         loc_oCab.AddObject("lbl_4c_SayEsp", "Label")
646:         WITH loc_oCab.lbl_4c_SayEsp
647:             .Caption   = "Esp" + CHR(233) + "cie"
648:             .Top       = 47
649:             .Left      = 242
650:             .Height    = 15
651:             .FontName  = "Tahoma"
652:             .FontSize  = 8
653:             .BackStyle = 0
654:             .ForeColor = RGB(53, 53, 53)
655:             .AutoSize  = .T.
656:             .Visible   = .T.
657:         ENDWITH
658: 
659:         *-- Get_Especie (original top=66, left=257, width=53 -> cnt top=62, left=242)
660:         loc_oCab.AddObject("txt_4c_Especie", "TextBox")
661:         WITH loc_oCab.txt_4c_Especie
662:             .Top       = 62
663:             .Left      = 242
664:             .Width     = 53
665:             .Height    = 21
666:             .MaxLength = 6
667:             .FontName  = "Tahoma"
668:             .FontSize  = 8
669:             .ReadOnly  = .T.
670:             .Value     = ""
671:             .Visible   = .T.
672:         ENDWITH
673: 
674:         *-- Say6 "Data Saida" (original top=50, left=455 -> cnt top=46, left=440)
675:         loc_oCab.AddObject("lbl_4c_SaySaida", "Label")
676:         WITH loc_oCab.lbl_4c_SaySaida
677:             .Caption   = "Data Sa" + CHR(237) + "da"
678:             .Top       = 46
679:             .Left      = 440
680:             .Height    = 15
681:             .FontName  = "Tahoma"
682:             .FontSize  = 8
683:             .BackStyle = 0
684:             .ForeColor = RGB(53, 53, 53)
685:             .AutoSize  = .T.
686:             .Visible   = .T.
687:         ENDWITH
688: 
689:         *-- Get_Saidas (original top=65, left=455, width=80 -> cnt top=61, left=440)
690:         loc_oCab.AddObject("txt_4c_DtSaidas", "TextBox")
691:         WITH loc_oCab.txt_4c_DtSaidas
692:             .Top       = 61
693:             .Left      = 440
694:             .Width     = 80
695:             .Height    = 21
696:             .FontName  = "Tahoma"
697:             .FontSize  = 8
698:             .ReadOnly  = .T.
699:             .Value     = {}
700:             .Visible   = .T.
701:         ENDWITH
702: 
703:         *-- Row 3: Say5 "CFOP :" (original top=95, left=27 -> cnt top=91, left=12)
704:         loc_oCab.AddObject("lbl_4c_SayCfop", "Label")
705:         WITH loc_oCab.lbl_4c_SayCfop
706:             .Caption   = "CFOP :"
707:             .Top       = 91
708:             .Left      = 12
709:             .Height    = 15
710:             .FontName  = "Tahoma"
711:             .FontSize  = 8
712:             .BackStyle = 0
713:             .ForeColor = RGB(53, 53, 53)
714:             .AutoSize  = .T.
715:             .Visible   = .T.
716:         ENDWITH
717: 
718:         *-- Get_ClFiscal (original top=91, left=71, width=63 -> cnt top=87, left=56)
719:         loc_oCab.AddObject("txt_4c_ClFiscal", "TextBox")
720:         WITH loc_oCab.txt_4c_ClFiscal
721:             .Top       = 87
722:             .Left      = 56
723:             .Width     = 63
724:             .Height    = 21
725:             .MaxLength = 10
726:             .FontName  = "Tahoma"
727:             .FontSize  = 8

*-- Linhas 733 a 742:
733:         *-- Get_DClFiscal (original top=91, left=136, width=407 -> cnt top=87, left=121)
734:         loc_oCab.AddObject("txt_4c_DClFiscal", "TextBox")
735:         WITH loc_oCab.txt_4c_DClFiscal
736:             .Top       = 87
737:             .Left      = 121
738:             .Width     = 407
739:             .Height    = 21
740:             .MaxLength = 60
741:             .FontName  = "Tahoma"
742:             .FontSize  = 8

*-- Linhas 749 a 768:
749:         *-- Legado: top=123, left=15, width=739, height=459, PageCount=2
750:         *-- Compensacao PageFrame outer (-29 +29 = 0 neste nivel), so top=123+29=152
751:         loc_oPagina.AddObject("pgf_4c_InnerPage", "PageFrame")
752:         loc_oPagina.pgf_4c_InnerPage.Top       = 152
753:         loc_oPagina.pgf_4c_InnerPage.Left      = 15
754:         loc_oPagina.pgf_4c_InnerPage.Width     = 970
755:         loc_oPagina.pgf_4c_InnerPage.Height    = 447
756:         loc_oPagina.pgf_4c_InnerPage.PageCount = 2
757:         loc_oPagina.pgf_4c_InnerPage.Tabs      = .T.
758:         loc_oPagina.pgf_4c_InnerPage.Visible   = .T.
759: 
760:         WITH loc_oPagina.pgf_4c_InnerPage
761:             .Page1.Caption   = "Impostos"
762:             .Page1.BackColor = RGB(255, 255, 255)
763:             .Page2.Caption   = "Servi" + CHR(231) + "os"
764:             .Page2.BackColor = RGB(255, 255, 255)
765:         ENDWITH
766: 
767:         THIS.ConfigurarAbaImpostos()
768:         THIS.ConfigurarAbaServicos()

*-- Linhas 778 a 791:
778:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
779: 
780:         *-- Encerrar (Page1)
781:         BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
782: 
783:         *-- Acoes personalizadas (Page1)
784:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_InserirCarta, "Click", THIS, "BtnInserirCartaClick")
785:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_AlteraCarta,  "Click", THIS, "BtnAlteraCartaClick")
786:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta,     "Click", THIS, "BtnImpCartaClick")
787: 
788:         *-- Grade: selecao de linha atualiza estado dos botoes
789:         BINDEVENT(loc_oPg1.grd_4c_Lista, "AfterRowColChange", THIS, "GrdListaAfterRowColChange")
790: 
791:         *-- Filtros (Page1)

*-- Linhas 797 a 817:
797:         BINDEVENT(loc_oCnt.txt_4c_DtFim,  "KeyPress",         THIS, "ValidarDtFim")
798:         BINDEVENT(loc_oCnt.txt_4c_DtFim,  "When",              THIS, "DtFimWhenCheck")
799:         BINDEVENT(loc_oCnt.opt_4c_Filtro, "InteractiveChange", THIS, "FiltroChanged")
800: 
801:         *-- Salvar/Cancelar (Page2)
802:         BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
803:         BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
804: 
805:         *-- NF numero: LostFocus move foco para Confirmar (legado: Get_nota.LostFocus -> Salva.SetFocus)
806:         BINDEVENT(loc_oPg2.cnt_4c_DadosCab.txt_4c_Nota, "KeyPress", THIS, "NotaLostFocus")
807: 
808:         *-- Botao Dados na aba Impostos (abre SigMvExp)
809:         LOCAL loc_oAbaImp
810:         loc_oAbaImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
811:         BINDEVENT(loc_oAbaImp.cmd_4c_Dados, "Click", THIS, "BtnDadosClick")
812:     ENDPROC
813: 
814:     *==========================================================================
815:     * CarregarLista - Carrega lista de NFs segundo filtros atuais
816:     *==========================================================================
817:     PROCEDURE CarregarLista()

*-- Linhas 904 a 913:
904:             ENDIF
905: 
906:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
907:                 .cmd_4c_AlteraCarta.Enabled = loc_lTemCarta
908:                 .cmd_4c_ImpCarta.Enabled    = loc_lTemCarta
909:                 .Visible     = .T.
910:             ENDWITH
911: 
912:         CATCH TO loc_oErro
913:             MsgErro(loc_oErro.Message, "Erro ao atualizar bot" + CHR(245) + "es")

*-- Linhas 1079 a 1110:
1079:     *==========================================================================
1080:     PROCEDURE BtnCancelarClick()
1081:         THIS.this_cModoAtual = "LISTA"
1082:         THIS.HabilitarCampos(.F.)
1083:         *-- Re-habilitar Confirmar (pode ter sido desabilitado em modo VISUALIZAR)
1084:         THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
1085:         THIS.AlternarPagina(1)
1086:     ENDPROC
1087: 
1088:     *==========================================================================
1089:     * NotaLostFocus - Ao sair do campo NF num, move foco para Confirmar
1090:     * Legado: Get_nota.LostFocus = Grupo_Salva.Salva.SetFocus
1091:     *==========================================================================
1092:     PROCEDURE NotaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1093:         LOCAL loc_oErro
1094:         TRY
1095:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1096:         CATCH TO loc_oErro
1097:             MsgErro(loc_oErro.Message, "Erro ao mover foco")
1098:         ENDTRY
1099:     ENDPROC
1100: 
1101:     *==========================================================================
1102:     * FormParaBO - Transfere valores do form para as propriedades do BO
1103:     *==========================================================================
1104:     PROTECTED PROCEDURE FormParaBO()
1105:         LOCAL loc_lResultado, loc_oCab
1106:         loc_lResultado = .F.
1107: 
1108:         TRY
1109:             loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab
1110: 

*-- Linhas 1241 a 1252:
1241:         loc_lAtivo = !par_lHabilitar
1242: 
1243:         *-- Botoes de acao e encerrar ficam bloqueados durante edicao na Page2
1244:         loc_oPg1.cnt_4c_Botoes.cmd_4c_InserirCarta.Enabled = loc_lAtivo
1245:         loc_oPg1.cnt_4c_Botoes.cmd_4c_AlteraCarta.Enabled  = loc_lAtivo
1246:         loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta.Enabled     = loc_lAtivo
1247:         loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled      = loc_lAtivo
1248:     ENDPROC
1249: 
1250:     *==========================================================================
1251:     * LimparCampos - Limpa todos os campos do cabecalho da NF
1252:     *==========================================================================

*-- Linhas 1363 a 1475:
1363:         loc_oCnt = par_oPagina.cnt_4c_Filtros
1364: 
1365:         *-- Label: Empresa (Label2: top=19, left=16, width=57)
1366:         loc_oCnt.AddObject("lbl_4c_Empresa", "Label")
1367:         WITH loc_oCnt.lbl_4c_Empresa
1368:             .Caption   = "Empresa :"
1369:             .Top       = 14
1370:             .Left      = 16
1371:             .Width     = 57
1372:             .Height    = 15
1373:             .FontName  = "Tahoma"
1374:             .FontSize  = 8
1375:             .BackStyle = 0
1376:             .ForeColor = RGB(53, 53, 53)
1377:             .Visible   = .T.
1378:         ENDWITH
1379: 
1380:         *-- TextBox: Empresa (GetEmp: top=16, left=84, width=31, height=23)
1381:         loc_oCnt.AddObject("txt_4c_Emp", "TextBox")
1382:         WITH loc_oCnt.txt_4c_Emp
1383:             .Top       = 12
1384:             .Left      = 84
1385:             .Width     = 31
1386:             .Height    = 23
1387:             .MaxLength = 3
1388:             .FontName  = "Tahoma"
1389:             .FontSize  = 8
1390:             .Value     = ALLTRIM(THIS.this_cEmps)
1391:             .Visible   = .T.
1392:         ENDWITH
1393: 
1394:         *-- Label: No. Serie (Say1: top=19, left=138)
1395:         loc_oCnt.AddObject("lbl_4c_Serie", "Label")
1396:         WITH loc_oCnt.lbl_4c_Serie
1397:             .Caption   = "No. S" + CHR(233) + "rie : "
1398:             .Top       = 14
1399:             .Left      = 138
1400:             .Height    = 15
1401:             .FontName  = "Tahoma"
1402:             .FontSize  = 8
1403:             .BackStyle = 0
1404:             .ForeColor = RGB(53, 53, 53)
1405:             .AutoSize  = .T.
1406:             .Visible   = .T.
1407:         ENDWITH
1408: 
1409:         *-- TextBox: Serie (Get_Serie: top=16, left=208, width=36, height=23)
1410:         loc_oCnt.AddObject("txt_4c_Serie", "TextBox")
1411:         WITH loc_oCnt.txt_4c_Serie
1412:             .Top       = 12
1413:             .Left      = 208
1414:             .Width     = 36
1415:             .Height    = 23
1416:             .MaxLength = 8
1417:             .FontName  = "Tahoma"
1418:             .FontSize  = 8
1419:             .Value     = ""
1420:             .Visible   = .T.
1421:         ENDWITH
1422: 
1423:         *-- Label: Periodo (Say2: top=19, left=276)
1424:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
1425:         WITH loc_oCnt.lbl_4c_Periodo
1426:             .Caption   = "Per" + CHR(237) + "odo : "
1427:             .Top       = 14
1428:             .Left      = 276
1429:             .Height    = 15
1430:             .FontName  = "Tahoma"
1431:             .FontSize  = 8
1432:             .BackStyle = 0
1433:             .ForeColor = RGB(53, 53, 53)
1434:             .AutoSize  = .T.
1435:             .Visible   = .T.
1436:         ENDWITH
1437: 
1438:         *-- TextBox: Data Inicial (DtIni: top=16, left=338, width=80, height=23)
1439:         loc_oCnt.AddObject("txt_4c_DtIni", "TextBox")
1440:         WITH loc_oCnt.txt_4c_DtIni
1441:             .Top       = 12
1442:             .Left      = 338
1443:             .Width     = 80
1444:             .Height    = 23
1445:             .FontName  = "Tahoma"
1446:             .FontSize  = 8
1447:             .Value     = {}
1448:             .Visible   = .T.
1449:         ENDWITH
1450: 
1451:         *-- Label: separador "a" entre datas (Say3: top=19, left=424, caption="?"/CHR(224))
1452:         loc_oCnt.AddObject("lbl_4c_Sep", "Label")
1453:         WITH loc_oCnt.lbl_4c_Sep
1454:             .Caption   = CHR(224)
1455:             .Top       = 14
1456:             .Left      = 424
1457:             .Height    = 15
1458:             .FontName  = "Tahoma"
1459:             .FontSize  = 8
1460:             .BackStyle = 0
1461:             .ForeColor = RGB(53, 53, 53)
1462:             .AutoSize  = .T.
1463:             .Visible   = .T.
1464:         ENDWITH
1465: 
1466:         *-- TextBox: Data Final (DtFim: top=16, left=438, width=80, height=23)
1467:         loc_oCnt.AddObject("txt_4c_DtFim", "TextBox")
1468:         WITH loc_oCnt.txt_4c_DtFim
1469:             .Top       = 12
1470:             .Left      = 438
1471:             .Width     = 80
1472:             .Height    = 23
1473:             .FontName  = "Tahoma"
1474:             .FontSize  = 8
1475:             .Value     = {}

*-- Linhas 1481 a 1523:
1481:         loc_oCnt.AddObject("opt_4c_Filtro", "OptionGroup")
1482:         WITH loc_oCnt.opt_4c_Filtro
1483:             .ButtonCount = 3
1484:             .Top         = 10
1485:             .Left        = 538
1486:             .Width       = 206
1487:             .Height      = 26
1488:             .BackStyle   = 0
1489:             .BorderStyle = 0
1490:             .Visible     = .T.
1491:         ENDWITH
1492:         WITH loc_oCnt.opt_4c_Filtro.Buttons(1)
1493:             .Caption   = "Entrada"
1494:             .BackStyle = 0
1495:             .Left      = 5
1496:             .Top       = 4
1497:             .AutoSize  = .T.
1498:             .FontName  = "Tahoma"
1499:             .FontSize  = 8
1500:             .ForeColor = RGB(53, 53, 53)
1501:             .Themes    = .F.
1502:         ENDWITH
1503:         WITH loc_oCnt.opt_4c_Filtro.Buttons(2)
1504:             .Caption   = "Sa" + CHR(237) + "da"
1505:             .BackStyle = 0
1506:             .Left      = 74
1507:             .Top       = 4
1508:             .AutoSize  = .T.
1509:             .FontName  = "Tahoma"
1510:             .FontSize  = 8
1511:             .ForeColor = RGB(53, 53, 53)
1512:             .Themes    = .F.
1513:         ENDWITH
1514:         WITH loc_oCnt.opt_4c_Filtro.Buttons(3)
1515:             .Caption   = "Ambas"
1516:             .BackStyle = 0
1517:             .Left      = 140
1518:             .Top       = 4
1519:             .AutoSize  = .T.
1520:             .FontName  = "Tahoma"
1521:             .FontSize  = 8
1522:             .ForeColor = RGB(53, 53, 53)
1523:             .Themes    = .F.

*-- Linhas 1738 a 1948:
1738:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
1739: 
1740:         *-- Say17: titulo da secao (top=2, left=5)
1741:         loc_oAba.AddObject("lbl_4c_SecImpostos", "Label")
1742:         WITH loc_oAba.lbl_4c_SecImpostos
1743:             .Caption   = " Impostos "
1744:             .Top       = 2
1745:             .Left      = 5
1746:             .AutoSize  = .T.
1747:             .FontName  = "Tahoma"
1748:             .FontSize  = 8
1749:             .BackStyle = 0
1750:             .ForeColor = RGB(53, 53, 53)
1751:         ENDWITH
1752: 
1753:         *-- Shape1: divisor horizontal (top=20, left=5, width=494, height=2)
1754:         loc_oAba.AddObject("shp_4c_Div1", "Shape")
1755:         WITH loc_oAba.shp_4c_Div1
1756:             .Top         = 20
1757:             .Left        = 5
1758:             .Width       = 494
1759:             .Height      = 2
1760:             .BackColor   = RGB(180, 180, 180)
1761:             .BorderColor = RGB(180, 180, 180)
1762:         ENDWITH
1763: 
1764:         *-- Labels cabecalho IPI/ICMS (top=26)
1765:         loc_oAba.AddObject("lbl_4c_SayBaseIPI", "Label")
1766:         WITH loc_oAba.lbl_4c_SayBaseIPI
1767:             .Caption   = "Base C" + CHR(225) + "lculo IPI"
1768:             .Top       = 26
1769:             .Left      = 5
1770:             .AutoSize  = .T.
1771:             .FontName  = "Tahoma"
1772:             .FontSize  = 8
1773:             .BackStyle = 0
1774:             .ForeColor = RGB(53, 53, 53)
1775:         ENDWITH
1776: 
1777:         loc_oAba.AddObject("lbl_4c_SayValorIPI", "Label")
1778:         WITH loc_oAba.lbl_4c_SayValorIPI
1779:             .Caption   = "Valor IPI"
1780:             .Top       = 26
1781:             .Left      = 116
1782:             .AutoSize  = .T.
1783:             .FontName  = "Tahoma"
1784:             .FontSize  = 8
1785:             .BackStyle = 0
1786:             .ForeColor = RGB(53, 53, 53)
1787:         ENDWITH
1788: 
1789:         loc_oAba.AddObject("lbl_4c_SayBaseICMS", "Label")
1790:         WITH loc_oAba.lbl_4c_SayBaseICMS
1791:             .Caption   = "Base C" + CHR(225) + "lculo ICMS"
1792:             .Top       = 26
1793:             .Left      = 227
1794:             .AutoSize  = .T.
1795:             .FontName  = "Tahoma"
1796:             .FontSize  = 8
1797:             .BackStyle = 0
1798:             .ForeColor = RGB(53, 53, 53)
1799:         ENDWITH
1800: 
1801:         loc_oAba.AddObject("lbl_4c_SayPercICMS", "Label")
1802:         WITH loc_oAba.lbl_4c_SayPercICMS
1803:             .Caption   = "% ICMS "
1804:             .Top       = 26
1805:             .Left      = 340
1806:             .AutoSize  = .T.
1807:             .FontName  = "Tahoma"
1808:             .FontSize  = 8
1809:             .BackStyle = 0
1810:             .ForeColor = RGB(53, 53, 53)
1811:         ENDWITH
1812: 
1813:         loc_oAba.AddObject("lbl_4c_SayValorICMS", "Label")
1814:         WITH loc_oAba.lbl_4c_SayValorICMS
1815:             .Caption   = "Valor ICMS"
1816:             .Top       = 26
1817:             .Left      = 394
1818:             .AutoSize  = .T.
1819:             .FontName  = "Tahoma"
1820:             .FontSize  = 8
1821:             .BackStyle = 0
1822:             .ForeColor = RGB(53, 53, 53)
1823:         ENDWITH
1824: 
1825:         *-- Campos IPI/ICMS (top=43)
1826:         loc_oAba.AddObject("txt_4c_BaseIPI", "TextBox")
1827:         WITH loc_oAba.txt_4c_BaseIPI
1828:             .Top      = 43
1829:             .Left     = 5
1830:             .Width    = 107
1831:             .Height   = 21
1832:             .FontName = "Tahoma"
1833:             .FontSize = 8
1834:             .ReadOnly = .T.
1835:             .Value    = 0
1836:         ENDWITH
1837: 
1838:         loc_oAba.AddObject("txt_4c_ValorIPI", "TextBox")
1839:         WITH loc_oAba.txt_4c_ValorIPI
1840:             .Top      = 43
1841:             .Left     = 116
1842:             .Width    = 107
1843:             .Height   = 21
1844:             .FontName = "Tahoma"
1845:             .FontSize = 8
1846:             .ReadOnly = .T.
1847:             .Value    = 0
1848:         ENDWITH
1849: 
1850:         loc_oAba.AddObject("txt_4c_BaseICMS", "TextBox")
1851:         WITH loc_oAba.txt_4c_BaseICMS
1852:             .Top      = 43
1853:             .Left     = 227
1854:             .Width    = 107
1855:             .Height   = 21
1856:             .FontName = "Tahoma"
1857:             .FontSize = 8
1858:             .ReadOnly = .T.
1859:             .Value    = 0
1860:         ENDWITH
1861: 
1862:         loc_oAba.AddObject("txt_4c_PercICMS", "TextBox")
1863:         WITH loc_oAba.txt_4c_PercICMS
1864:             .Top      = 43
1865:             .Left     = 338
1866:             .Width    = 52
1867:             .Height   = 21
1868:             .FontName = "Tahoma"
1869:             .FontSize = 8
1870:             .ReadOnly = .T.
1871:             .Value    = 0
1872:         ENDWITH
1873: 
1874:         loc_oAba.AddObject("txt_4c_ValorICMS", "TextBox")
1875:         WITH loc_oAba.txt_4c_ValorICMS
1876:             .Top      = 43
1877:             .Left     = 394
1878:             .Width    = 107
1879:             .Height   = 21
1880:             .FontName = "Tahoma"
1881:             .FontSize = 8
1882:             .ReadOnly = .T.
1883:             .Value    = 0
1884:         ENDWITH
1885: 
1886:         *-- Labels Totais (top=67)
1887:         loc_oAba.AddObject("lbl_4c_SayTotProds", "Label")
1888:         WITH loc_oAba.lbl_4c_SayTotProds
1889:             .Caption   = "Total Produtos"
1890:             .Top       = 67
1891:             .Left      = 5
1892:             .AutoSize  = .T.
1893:             .FontName  = "Tahoma"
1894:             .FontSize  = 8
1895:             .BackStyle = 0
1896:             .ForeColor = RGB(53, 53, 53)
1897:         ENDWITH
1898: 
1899:         loc_oAba.AddObject("lbl_4c_SayTotalNf", "Label")
1900:         WITH loc_oAba.lbl_4c_SayTotalNf
1901:             .Caption   = "Total NFiscal"
1902:             .Top       = 67
1903:             .Left      = 116
1904:             .AutoSize  = .T.
1905:             .FontName  = "Tahoma"
1906:             .FontSize  = 8
1907:             .BackStyle = 0
1908:             .ForeColor = RGB(53, 53, 53)
1909:         ENDWITH
1910: 
1911:         *-- Campos Totais (top=83)
1912:         loc_oAba.AddObject("txt_4c_TotalProds", "TextBox")
1913:         WITH loc_oAba.txt_4c_TotalProds
1914:             .Top      = 83
1915:             .Left     = 5
1916:             .Width    = 107
1917:             .Height   = 21
1918:             .FontName = "Tahoma"
1919:             .FontSize = 8
1920:             .ReadOnly = .T.
1921:             .Value    = 0
1922:         ENDWITH
1923: 
1924:         loc_oAba.AddObject("txt_4c_TotalNf", "TextBox")
1925:         WITH loc_oAba.txt_4c_TotalNf
1926:             .Top      = 83
1927:             .Left     = 116
1928:             .Width    = 106
1929:             .Height   = 21
1930:             .FontName = "Tahoma"
1931:             .FontSize = 8
1932:             .ReadOnly = .T.
1933:             .Value    = 0
1934:         ENDWITH
1935: 
1936:         *-- Botao Dados (abre SigMvExp): top=17, left=516
1937:         loc_oAba.AddObject("cmd_4c_Dados", "CommandButton")
1938:         WITH loc_oAba.cmd_4c_Dados
1939:             .Caption         = "Dados"
1940:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
1941:             .PicturePosition = 13
1942:             .Top             = 17
1943:             .Left            = 516
1944:             .Width           = 75
1945:             .Height          = 75
1946:             .FontName        = "Comic Sans MS"
1947:             .FontBold        = .T.
1948:             .FontItalic      = .T.

*-- Linhas 1956 a 2444:
1956:         ENDWITH
1957: 
1958:         *-- Say18: "Outros Valores" (top=115, left=5)
1959:         loc_oAba.AddObject("lbl_4c_SayOutrosVal", "Label")
1960:         WITH loc_oAba.lbl_4c_SayOutrosVal
1961:             .Caption   = " Outros Valores "
1962:             .Top       = 115
1963:             .Left      = 5
1964:             .AutoSize  = .T.
1965:             .FontName  = "Tahoma"
1966:             .FontSize  = 8
1967:             .BackStyle = 0
1968:             .ForeColor = RGB(53, 53, 53)
1969:         ENDWITH
1970: 
1971:         *-- Shape3: divisor "Outros Valores" (top=132, left=5, width=494, height=2)
1972:         loc_oAba.AddObject("shp_4c_Div3", "Shape")
1973:         WITH loc_oAba.shp_4c_Div3
1974:             .Top         = 132
1975:             .Left        = 5
1976:             .Width       = 494
1977:             .Height      = 2
1978:             .BackColor   = RGB(180, 180, 180)
1979:             .BorderColor = RGB(180, 180, 180)
1980:         ENDWITH
1981: 
1982:         *-- Labels Outros Valores (top=137)
1983:         loc_oAba.AddObject("lbl_4c_SayTFrete", "Label")
1984:         WITH loc_oAba.lbl_4c_SayTFrete
1985:             .Caption   = "Valor do Frete"
1986:             .Top       = 137
1987:             .Left      = 5
1988:             .AutoSize  = .T.
1989:             .FontName  = "Tahoma"
1990:             .FontSize  = 8
1991:             .BackStyle = 0
1992:             .ForeColor = RGB(53, 53, 53)
1993:         ENDWITH
1994: 
1995:         loc_oAba.AddObject("lbl_4c_SayTSeguros", "Label")
1996:         WITH loc_oAba.lbl_4c_SayTSeguros
1997:             .Caption   = "Valor do Seguro"
1998:             .Top       = 137
1999:             .Left      = 119
2000:             .AutoSize  = .T.
2001:             .FontName  = "Tahoma"
2002:             .FontSize  = 8
2003:             .BackStyle = 0
2004:             .ForeColor = RGB(53, 53, 53)
2005:         ENDWITH
2006: 
2007:         loc_oAba.AddObject("lbl_4c_SayDespAces", "Label")
2008:         WITH loc_oAba.lbl_4c_SayDespAces
2009:             .Caption   = "Despesas Acess" + CHR(243) + "rias"
2010:             .Top       = 137
2011:             .Left      = 233
2012:             .AutoSize  = .T.
2013:             .FontName  = "Tahoma"
2014:             .FontSize  = 8
2015:             .BackStyle = 0
2016:             .ForeColor = RGB(53, 53, 53)
2017:         ENDWITH
2018: 
2019:         *-- Campos Outros Valores (top=153)
2020:         loc_oAba.AddObject("txt_4c_TFrete", "TextBox")
2021:         WITH loc_oAba.txt_4c_TFrete
2022:             .Top      = 153
2023:             .Left     = 5
2024:             .Width    = 105
2025:             .Height   = 21
2026:             .FontName = "Tahoma"
2027:             .FontSize = 8
2028:             .ReadOnly = .T.
2029:             .Value    = 0
2030:         ENDWITH
2031: 
2032:         loc_oAba.AddObject("txt_4c_TSeguros", "TextBox")
2033:         WITH loc_oAba.txt_4c_TSeguros
2034:             .Top      = 153
2035:             .Left     = 119
2036:             .Width    = 105
2037:             .Height   = 21
2038:             .FontName = "Tahoma"
2039:             .FontSize = 8
2040:             .ReadOnly = .T.
2041:             .Value    = 0
2042:         ENDWITH
2043: 
2044:         loc_oAba.AddObject("txt_4c_DespAces", "TextBox")
2045:         WITH loc_oAba.txt_4c_DespAces
2046:             .Top      = 153
2047:             .Left     = 233
2048:             .Width    = 105
2049:             .Height   = 21
2050:             .FontName = "Tahoma"
2051:             .FontSize = 8
2052:             .ReadOnly = .T.
2053:             .Value    = 0
2054:         ENDWITH
2055: 
2056:         *-- Say26: "Transportador" (top=185, left=5)
2057:         loc_oAba.AddObject("lbl_4c_SayTransp", "Label")
2058:         WITH loc_oAba.lbl_4c_SayTransp
2059:             .Caption   = " Transportador "
2060:             .Top       = 185
2061:             .Left      = 5
2062:             .AutoSize  = .T.
2063:             .FontName  = "Tahoma"
2064:             .FontSize  = 8
2065:             .BackStyle = 0
2066:             .ForeColor = RGB(53, 53, 53)
2067:         ENDWITH
2068: 
2069:         *-- Shape4: divisor "Transportador" (top=203, left=5, width=494, height=2)
2070:         loc_oAba.AddObject("shp_4c_Div4", "Shape")
2071:         WITH loc_oAba.shp_4c_Div4
2072:             .Top         = 203
2073:             .Left        = 5
2074:             .Width       = 494
2075:             .Height      = 2
2076:             .BackColor   = RGB(180, 180, 180)
2077:             .BorderColor = RGB(180, 180, 180)
2078:         ENDWITH
2079: 
2080:         *-- Say20: label "Transportadora" (top=209, left=5)
2081:         loc_oAba.AddObject("lbl_4c_SayTranspNome", "Label")
2082:         WITH loc_oAba.lbl_4c_SayTranspNome
2083:             .Caption   = "Transportadora"
2084:             .Top       = 209
2085:             .Left      = 5
2086:             .AutoSize  = .T.
2087:             .FontName  = "Tahoma"
2088:             .FontSize  = 8
2089:             .BackStyle = 0
2090:             .ForeColor = RGB(53, 53, 53)
2091:         ENDWITH
2092: 
2093:         *-- Codigo transportadora (top=225, left=5, width=82)
2094:         loc_oAba.AddObject("txt_4c_CodTransp", "TextBox")
2095:         WITH loc_oAba.txt_4c_CodTransp
2096:             .Top       = 225
2097:             .Left      = 5
2098:             .Width     = 82
2099:             .Height    = 23
2100:             .MaxLength = 10
2101:             .FontName  = "Tahoma"
2102:             .FontSize  = 8
2103:             .ReadOnly  = .T.
2104:             .Value     = ""
2105:         ENDWITH
2106: 
2107:         *-- Nome transportadora (top=225, left=90, width=377)
2108:         loc_oAba.AddObject("txt_4c_TranspNome", "TextBox")
2109:         WITH loc_oAba.txt_4c_TranspNome
2110:             .Top       = 225
2111:             .Left      = 90
2112:             .Width     = 377
2113:             .Height    = 23
2114:             .MaxLength = 40
2115:             .FontName  = "Tahoma"
2116:             .FontSize  = 8
2117:             .ReadOnly  = .T.
2118:             .Value     = ""
2119:         ENDWITH
2120: 
2121:         *-- Say21: "Endereco" (top=251, left=5)
2122:         loc_oAba.AddObject("lbl_4c_SayTranspEnde", "Label")
2123:         WITH loc_oAba.lbl_4c_SayTranspEnde
2124:             .Caption   = "Endere" + CHR(231) + "o"
2125:             .Top       = 251
2126:             .Left      = 5
2127:             .AutoSize  = .T.
2128:             .FontName  = "Tahoma"
2129:             .FontSize  = 8
2130:             .BackStyle = 0
2131:             .ForeColor = RGB(53, 53, 53)
2132:         ENDWITH
2133: 
2134:         *-- Endereco transportadora (top=267, left=5, width=462)
2135:         loc_oAba.AddObject("txt_4c_TranspEnde", "TextBox")
2136:         WITH loc_oAba.txt_4c_TranspEnde
2137:             .Top       = 267
2138:             .Left      = 5
2139:             .Width     = 462
2140:             .Height    = 23
2141:             .MaxLength = 60
2142:             .FontName  = "Tahoma"
2143:             .FontSize  = 8
2144:             .ReadOnly  = .T.
2145:             .Value     = ""
2146:         ENDWITH
2147: 
2148:         *-- Labels linha de Cidade/UF/Placa/Frete (top=293)
2149:         loc_oAba.AddObject("lbl_4c_SayCidade", "Label")
2150:         WITH loc_oAba.lbl_4c_SayCidade
2151:             .Caption   = "Cidade"
2152:             .Top       = 293
2153:             .Left      = 5
2154:             .AutoSize  = .T.
2155:             .FontName  = "Tahoma"
2156:             .FontSize  = 8
2157:             .BackStyle = 0
2158:             .ForeColor = RGB(53, 53, 53)
2159:         ENDWITH
2160: 
2161:         loc_oAba.AddObject("lbl_4c_SayEstado", "Label")
2162:         WITH loc_oAba.lbl_4c_SayEstado
2163:             .Caption   = "UF"
2164:             .Top       = 293
2165:             .Left      = 184
2166:             .AutoSize  = .T.
2167:             .FontName  = "Tahoma"
2168:             .FontSize  = 8
2169:             .BackStyle = 0
2170:             .ForeColor = RGB(53, 53, 53)
2171:         ENDWITH
2172: 
2173:         loc_oAba.AddObject("lbl_4c_SayPlaca", "Label")
2174:         WITH loc_oAba.lbl_4c_SayPlaca
2175:             .Caption   = "Placa"
2176:             .Top       = 293
2177:             .Left      = 221
2178:             .AutoSize  = .T.
2179:             .FontName  = "Tahoma"
2180:             .FontSize  = 8
2181:             .BackStyle = 0
2182:             .ForeColor = RGB(53, 53, 53)
2183:         ENDWITH
2184: 
2185:         loc_oAba.AddObject("lbl_4c_SayUfPlaca", "Label")
2186:         WITH loc_oAba.lbl_4c_SayUfPlaca
2187:             .Caption   = "UF"
2188:             .Top       = 293
2189:             .Left      = 303
2190:             .AutoSize  = .T.
2191:             .FontName  = "Tahoma"
2192:             .FontSize  = 8
2193:             .BackStyle = 0
2194:             .ForeColor = RGB(53, 53, 53)
2195:         ENDWITH
2196: 
2197:         loc_oAba.AddObject("lbl_4c_SayTipoFrete", "Label")
2198:         WITH loc_oAba.lbl_4c_SayTipoFrete
2199:             .Caption   = "Frete"
2200:             .Top       = 293
2201:             .Left      = 337
2202:             .AutoSize  = .T.
2203:             .FontName  = "Tahoma"
2204:             .FontSize  = 8
2205:             .BackStyle = 0
2206:             .ForeColor = RGB(53, 53, 53)
2207:         ENDWITH
2208: 
2209:         *-- Campos Cidade/UF/Placa/Frete (top=309)
2210:         loc_oAba.AddObject("txt_4c_TranspCida", "TextBox")
2211:         WITH loc_oAba.txt_4c_TranspCida
2212:             .Top       = 309
2213:             .Left      = 5
2214:             .Width     = 175
2215:             .Height    = 23
2216:             .MaxLength = 40
2217:             .FontName  = "Tahoma"
2218:             .FontSize  = 8
2219:             .ReadOnly  = .T.
2220:             .Value     = ""
2221:         ENDWITH
2222: 
2223:         loc_oAba.AddObject("txt_4c_TranspEsta", "TextBox")
2224:         WITH loc_oAba.txt_4c_TranspEsta
2225:             .Top       = 309
2226:             .Left      = 183
2227:             .Width     = 26
2228:             .Height    = 23
2229:             .MaxLength = 2
2230:             .FontName  = "Tahoma"
2231:             .FontSize  = 8
2232:             .ReadOnly  = .T.
2233:             .Value     = ""
2234:         ENDWITH
2235: 
2236:         loc_oAba.AddObject("txt_4c_Placa", "TextBox")
2237:         WITH loc_oAba.txt_4c_Placa
2238:             .Top       = 309
2239:             .Left      = 219
2240:             .Width     = 80
2241:             .Height    = 23
2242:             .MaxLength = 8
2243:             .FontName  = "Tahoma"
2244:             .FontSize  = 8
2245:             .ReadOnly  = .T.
2246:             .Value     = ""
2247:         ENDWITH
2248: 
2249:         loc_oAba.AddObject("txt_4c_UfPlaca", "TextBox")
2250:         WITH loc_oAba.txt_4c_UfPlaca
2251:             .Top       = 309
2252:             .Left      = 302
2253:             .Width     = 26
2254:             .Height    = 23
2255:             .MaxLength = 2
2256:             .FontName  = "Tahoma"
2257:             .FontSize  = 8
2258:             .ReadOnly  = .T.
2259:             .Value     = ""
2260:         ENDWITH
2261: 
2262:         loc_oAba.AddObject("txt_4c_TipoFrete", "TextBox")
2263:         WITH loc_oAba.txt_4c_TipoFrete
2264:             .Top       = 309
2265:             .Left      = 336
2266:             .Width     = 132
2267:             .Height    = 23
2268:             .MaxLength = 20
2269:             .FontName  = "Tahoma"
2270:             .FontSize  = 8
2271:             .ReadOnly  = .T.
2272:             .Value     = ""
2273:         ENDWITH
2274: 
2275:         *-- Say16: "Volumes Transportados" (top=342, left=5)
2276:         loc_oAba.AddObject("lbl_4c_SayVolumes", "Label")
2277:         WITH loc_oAba.lbl_4c_SayVolumes
2278:             .Caption   = " Volumes Transportados "
2279:             .Top       = 342
2280:             .Left      = 5
2281:             .AutoSize  = .T.
2282:             .FontName  = "Tahoma"
2283:             .FontSize  = 8
2284:             .BackStyle = 0
2285:             .ForeColor = RGB(53, 53, 53)
2286:         ENDWITH
2287: 
2288:         *-- Shape2: divisor "Volumes" (top=360, left=5, width=494, height=2)
2289:         loc_oAba.AddObject("shp_4c_Div2", "Shape")
2290:         WITH loc_oAba.shp_4c_Div2
2291:             .Top         = 360
2292:             .Left        = 5
2293:             .Width       = 494
2294:             .Height      = 2
2295:             .BackColor   = RGB(180, 180, 180)
2296:             .BorderColor = RGB(180, 180, 180)
2297:         ENDWITH
2298: 
2299:         *-- Labels Volumes (top=364)
2300:         loc_oAba.AddObject("lbl_4c_SayQtdes", "Label")
2301:         WITH loc_oAba.lbl_4c_SayQtdes
2302:             .Caption   = "Qtde."
2303:             .Top       = 364
2304:             .Left      = 5
2305:             .AutoSize  = .T.
2306:             .FontName  = "Tahoma"
2307:             .FontSize  = 8
2308:             .BackStyle = 0
2309:             .ForeColor = RGB(53, 53, 53)
2310:         ENDWITH
2311: 
2312:         loc_oAba.AddObject("lbl_4c_SayEspe", "Label")
2313:         WITH loc_oAba.lbl_4c_SayEspe
2314:             .Caption   = "Esp" + CHR(233) + "cie"
2315:             .Top       = 364
2316:             .Left      = 59
2317:             .AutoSize  = .T.
2318:             .FontName  = "Tahoma"
2319:             .FontSize  = 8
2320:             .BackStyle = 0
2321:             .ForeColor = RGB(53, 53, 53)
2322:         ENDWITH
2323: 
2324:         loc_oAba.AddObject("lbl_4c_SayMarcas", "Label")
2325:         WITH loc_oAba.lbl_4c_SayMarcas
2326:             .Caption   = "Marca"
2327:             .Top       = 364
2328:             .Left      = 149
2329:             .AutoSize  = .T.
2330:             .FontName  = "Tahoma"
2331:             .FontSize  = 8
2332:             .BackStyle = 0
2333:             .ForeColor = RGB(53, 53, 53)
2334:         ENDWITH
2335: 
2336:         loc_oAba.AddObject("lbl_4c_SayNumeros", "Label")
2337:         WITH loc_oAba.lbl_4c_SayNumeros
2338:             .Caption   = "N" + CHR(250) + "mero"
2339:             .Top       = 364
2340:             .Left      = 239
2341:             .AutoSize  = .T.
2342:             .FontName  = "Tahoma"
2343:             .FontSize  = 8
2344:             .BackStyle = 0
2345:             .ForeColor = RGB(53, 53, 53)
2346:         ENDWITH
2347: 
2348:         loc_oAba.AddObject("lbl_4c_SayPesoLiq", "Label")
2349:         WITH loc_oAba.lbl_4c_SayPesoLiq
2350:             .Caption   = "Peso L" + CHR(237) + "quido"
2351:             .Top       = 364
2352:             .Left      = 329
2353:             .AutoSize  = .T.
2354:             .FontName  = "Tahoma"
2355:             .FontSize  = 8
2356:             .BackStyle = 0
2357:             .ForeColor = RGB(53, 53, 53)
2358:         ENDWITH
2359: 
2360:         loc_oAba.AddObject("lbl_4c_SayPesoBruto", "Label")
2361:         WITH loc_oAba.lbl_4c_SayPesoBruto
2362:             .Caption   = "Peso Bruto"
2363:             .Top       = 364
2364:             .Left      = 405
2365:             .AutoSize  = .T.
2366:             .FontName  = "Tahoma"
2367:             .FontSize  = 8
2368:             .BackStyle = 0
2369:             .ForeColor = RGB(53, 53, 53)
2370:         ENDWITH
2371: 
2372:         *-- Campos Volumes (top=380)
2373:         loc_oAba.AddObject("txt_4c_Qtdes", "TextBox")
2374:         WITH loc_oAba.txt_4c_Qtdes
2375:             .Top      = 380
2376:             .Left     = 5
2377:             .Width    = 51
2378:             .Height   = 21
2379:             .FontName = "Tahoma"
2380:             .FontSize = 8
2381:             .ReadOnly = .T.
2382:             .Value    = 0
2383:         ENDWITH
2384: 
2385:         loc_oAba.AddObject("txt_4c_EspeVol", "TextBox")
2386:         WITH loc_oAba.txt_4c_EspeVol
2387:             .Top       = 380
2388:             .Left      = 59
2389:             .Width     = 87
2390:             .Height    = 21
2391:             .MaxLength = 20
2392:             .FontName  = "Tahoma"
2393:             .FontSize  = 8
2394:             .ReadOnly  = .T.
2395:             .Value     = ""
2396:         ENDWITH
2397: 
2398:         loc_oAba.AddObject("txt_4c_Marcas", "TextBox")
2399:         WITH loc_oAba.txt_4c_Marcas
2400:             .Top       = 380
2401:             .Left      = 149
2402:             .Width     = 87
2403:             .Height    = 21
2404:             .MaxLength = 20
2405:             .FontName  = "Tahoma"
2406:             .FontSize  = 8
2407:             .ReadOnly  = .T.
2408:             .Value     = ""
2409:         ENDWITH
2410: 
2411:         loc_oAba.AddObject("txt_4c_NumerosVol", "TextBox")
2412:         WITH loc_oAba.txt_4c_NumerosVol
2413:             .Top       = 380
2414:             .Left      = 239
2415:             .Width     = 87
2416:             .Height    = 21
2417:             .MaxLength = 20
2418:             .FontName  = "Tahoma"
2419:             .FontSize  = 8
2420:             .ReadOnly  = .T.
2421:             .Value     = ""
2422:         ENDWITH
2423: 
2424:         loc_oAba.AddObject("txt_4c_PesoLiq", "TextBox")
2425:         WITH loc_oAba.txt_4c_PesoLiq
2426:             .Top      = 380
2427:             .Left     = 329
2428:             .Width    = 73
2429:             .Height   = 21
2430:             .FontName = "Tahoma"
2431:             .FontSize = 8
2432:             .ReadOnly = .T.
2433:             .Value    = 0
2434:         ENDWITH
2435: 
2436:         loc_oAba.AddObject("txt_4c_PesoBruto", "TextBox")
2437:         WITH loc_oAba.txt_4c_PesoBruto
2438:             .Top      = 380
2439:             .Left     = 405
2440:             .Width    = 73
2441:             .Height   = 21
2442:             .FontName = "Tahoma"
2443:             .FontSize = 8
2444:             .ReadOnly = .T.

*-- Linhas 2456 a 2558:
2456:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page2
2457: 
2458:         *-- Say1: "Descricao dos Servicos Prestados :" (top=2, left=7)
2459:         loc_oAba.AddObject("lbl_4c_SayDescSer", "Label")
2460:         WITH loc_oAba.lbl_4c_SayDescSer
2461:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o dos Servi" + CHR(231) + "os Prestados : "
2462:             .Top       = 2
2463:             .Left      = 7
2464:             .AutoSize  = .T.
2465:             .FontName  = "Tahoma"
2466:             .FontSize  = 8
2467:             .BackStyle = 0
2468:             .ForeColor = RGB(53, 53, 53)
2469:         ENDWITH
2470: 
2471:         *-- Memo_desc EditBox (top=18, left=5, width=724, height=144)
2472:         loc_oAba.AddObject("edt_4c_DescSer", "EditBox")
2473:         WITH loc_oAba.edt_4c_DescSer
2474:             .Top      = 18
2475:             .Left     = 5
2476:             .Width    = 724
2477:             .Height   = 144
2478:             .FontName = "Tahoma"
2479:             .FontSize = 8
2480:             .ReadOnly = .T.
2481:             .Value    = ""
2482:         ENDWITH
2483: 
2484:         *-- Say2: "Valor Total Servicos :" (top=167, left=15)
2485:         loc_oAba.AddObject("lbl_4c_SayVtotsers", "Label")
2486:         WITH loc_oAba.lbl_4c_SayVtotsers
2487:             .Caption   = "Valor Total Servi" + CHR(231) + "os : "
2488:             .Top       = 167
2489:             .Left      = 15
2490:             .AutoSize  = .T.
2491:             .FontName  = "Tahoma"
2492:             .FontSize  = 8
2493:             .BackStyle = 0
2494:             .ForeColor = RGB(53, 53, 53)
2495:         ENDWITH
2496: 
2497:         *-- Get_vtotser (top=164, left=144, width=136)
2498:         loc_oAba.AddObject("txt_4c_Vtotsers", "TextBox")
2499:         WITH loc_oAba.txt_4c_Vtotsers
2500:             .Top      = 164
2501:             .Left     = 144
2502:             .Width    = 136
2503:             .Height   = 23
2504:             .FontName = "Tahoma"
2505:             .FontSize = 8
2506:             .ReadOnly = .T.
2507:             .Value    = 0
2508:         ENDWITH
2509: 
2510:         *-- Say3: "% I.S.S. :" (top=192, left=81)
2511:         loc_oAba.AddObject("lbl_4c_SayPerciss", "Label")
2512:         WITH loc_oAba.lbl_4c_SayPerciss
2513:             .Caption   = "% I.S.S. : "
2514:             .Top       = 192
2515:             .Left      = 81
2516:             .AutoSize  = .T.
2517:             .FontName  = "Tahoma"
2518:             .FontSize  = 8
2519:             .BackStyle = 0
2520:             .ForeColor = RGB(53, 53, 53)
2521:         ENDWITH
2522: 
2523:         *-- Get_perciss (top=189, left=144, width=52)
2524:         loc_oAba.AddObject("txt_4c_Perciss", "TextBox")
2525:         WITH loc_oAba.txt_4c_Perciss
2526:             .Top      = 189
2527:             .Left     = 144
2528:             .Width    = 52
2529:             .Height   = 23
2530:             .FontName = "Tahoma"
2531:             .FontSize = 8
2532:             .ReadOnly = .T.
2533:             .Value    = 0
2534:         ENDWITH
2535: 
2536:         *-- Say4: "Valor Total do I.S.S. :" (top=217, left=14)
2537:         loc_oAba.AddObject("lbl_4c_SayVtotiss", "Label")
2538:         WITH loc_oAba.lbl_4c_SayVtotiss
2539:             .Caption   = "Valor Total do I.S.S. : "
2540:             .Top       = 217
2541:             .Left      = 14
2542:             .AutoSize  = .T.
2543:             .FontName  = "Tahoma"
2544:             .FontSize  = 8
2545:             .BackStyle = 0
2546:             .ForeColor = RGB(53, 53, 53)
2547:         ENDWITH
2548: 
2549:         *-- Get_vtotiss (top=214, left=144, width=136)
2550:         loc_oAba.AddObject("txt_4c_Vtotiss", "TextBox")
2551:         WITH loc_oAba.txt_4c_Vtotiss
2552:             .Top      = 214
2553:             .Left     = 144
2554:             .Width    = 136
2555:             .Height   = 23
2556:             .FontName = "Tahoma"
2557:             .FontSize = 8
2558:             .ReadOnly = .T.

*-- Linhas 2636 a 2656:
2636:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
2637:                     THIS.this_cModoAtual = "VISUALIZAR"
2638:                     THIS.BOParaForm()
2639:                     THIS.HabilitarCampos(.F.)
2640:                     *-- Desabilitar Confirmar em modo VISUALIZAR (somente leitura)
2641:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
2642:                     THIS.AlternarPagina(2)
2643:                     loc_lResultado = .T.
2644:                 ELSE
2645:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
2646:                         "Erro ao carregar NF")
2647:                 ENDIF
2648:             ENDIF
2649: 
2650:         CATCH TO loc_oErro
2651:             MsgErro(loc_oErro.Message, "Erro ao visualizar NF")
2652:         ENDTRY
2653: 
2654:         RETURN loc_lResultado
2655:     ENDPROC
2656: 

*-- Linhas 2753 a 2770:
2753:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2754: 
2755:         WITH loc_oPg1.cnt_4c_Botoes
2756:             .cmd_4c_InserirCarta.Enabled = !loc_lEdicao
2757:             .cmd_4c_AlteraCarta.Enabled  = !loc_lEdicao
2758:             .cmd_4c_ImpCarta.Enabled     = !loc_lEdicao
2759:             .Visible     = .T.
2760:         ENDWITH
2761:         loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = !loc_lEdicao
2762: 
2763:         WITH loc_oPg2.cnt_4c_Salva
2764:             .cmd_4c_Confirmar.Enabled = loc_lEdicao
2765:             .cmd_4c_Cancelar.Enabled  = .T.
2766:             .Visible     = .T.
2767:         ENDWITH
2768:     ENDPROC
2769: 
2770: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CNFBO.prg):
*==============================================================================
* CNFBO.prg - Business Object de Correcao de Notas Fiscais
* Tabela principal: SigMvNfi (PK: cidchaves)
*==============================================================================

DEFINE CLASS CNFBO AS BusinessBase

    *-- =========================================================================
    *-- Chave primaria e identificacao
    *-- =========================================================================
    this_cCidchaves    = ""   && char(20) PK composta
    this_cEmpdopnums   = ""   && char(29) emps+dopes+numes
    this_cEmps         = ""   && char(3)

    *-- =========================================================================
    *-- Cabecalho da NF
    *-- =========================================================================
    this_cDopes        = ""   && char(20) tipo de operacao
    this_nNumes        = 0    && numeric(6,0) numero interno
    this_cNfis         = ""   && char(6) numero da NF fiscal
    this_cSeries       = ""   && char(8) serie
    this_cEspecienfs   = ""   && char(6) especie da NF
    this_tEmis         = {}   && datetime data emissao
    this_tDtsaidas     = {}   && datetime data saida
    this_tDatans       = {}   && datetime data da nota
    this_cOperas       = ""   && char(1) E=Entrada S=Saida
    this_lCorrecs      = .F.  && bit possui carta de correcao
    this_lCancelas     = .F.  && bit cancelada
    this_lRegs         = .F.  && bit registrada

    *-- =========================================================================
    *-- Fiscal / CFOP
    *-- =========================================================================
    this_cCfis         = ""   && char(10) cod. fiscal CFOP
    this_cClfis        = ""   && char(12) classe fiscal
    this_cCodcons      = ""   && char(9)  cod. condicao
    this_cConds        = ""   && char(12) condicoes
    this_cCfosubs      = ""   && char(10) CFOP substituto

    *-- Display-only: JOIN SigCdCfo.descricaos
    this_cDescricaos   = ""

    *-- =========================================================================
    *-- Cliente / Fornecedor
    *-- =========================================================================
    this_cClifors      = ""   && char(20) cod. cliente/fornecedor
    this_cCgcs         = ""   && char(21) CGC/CNPJ

    *-- Display-only: JOIN SigCdCli.rclis
    this_cRclis        = ""

    *-- =========================================================================
    *-- Impostos - IPI
    *-- =========================================================================
    this_nBasecipis    = 0    && numeric(14,2) base calculo IPI
    this_nValipis      = 0    && numeric(14,2) valor IPI
    this_nIpis         = 0    && numeric(4,2)  aliquota IPI
    this_nIpincreds    = 0    && numeric(14,2) IPI nao credita
    this_nBasecip2s    = 0    && numeric(14,2) base IPI 2
    this_nBasecip3s    = 0    && numeric(14,2) base IPI 3
    this_nDesipis      = 0    && numeric(15,2) desoner. IPI
    this_nFrtipis      = 0    && numeric(15,2) frete IPI
    this_nSegipis      = 0    && numeric(15,2) seguro IPI

    *-- =========================================================================
    *-- Impostos - ICMS
    *-- =========================================================================
    this_nBasecicms    = 0    && numeric(14,2) base calculo ICMS
    this_nValicms      = 0    && numeric(14,2) valor ICMS
    this_nIcms         = 0    && numeric(4,2)  aliquota % ICMS
    this_nBasecic2s    = 0    && numeric(14,2) base ICMS 2
    this_nBasecic3s    = 0    && numeric(14,2) base ICMS 3
    this_nBcicmss      = 0    && numeric(15,2) base ICMS subst.
    this_nIcmss        = 0    && numeric(15,2) ICMS substituicao
    this_nDesicms      = 0    && numeric(15,2) desoner. ICMS
    this_nFrticms      = 0    && numeric(15,2) frete ICMS
    this_nSegicms      = 0    && numeric(15,2) seguro ICMS
    this_nVfcpst       = 0    && numeric(14,2) FCP ST

    *-- =========================================================================
    *-- Totais
    *-- =========================================================================
    this_nTotProds     = 0    && numeric(14,2) total produtos
    this_nTotNotas     = 0    && numeric(14,2) total da NF
    this_nVals         = 0    && numeric(14,2) valor
    this_nPesos        = 0    && numeric(7,2)  peso

    *-- =========================================================================
    *-- Outros valores / frete / seguro
    *-- =========================================================================
    this_nVlFretes     = 0    && numeric(14,2) valor do frete
    this_nVlSeguros    = 0    && numeric(14,2) valor do seguro
    this_nDespAces     = 0    && numeric(14,2) despesas acessorias

    *-- =========================================================================
    *-- Transporte
    *-- =========================================================================
    this_cCodtrans     = ""   && char(10) cod. transportadora
    this_nFretes       = 0    && numeric(1,0) tipo frete 0=Emit/1=Dest
    this_cPlacas       = ""   && char(8)  placa veiculo
    this_cUfPlacas     = ""   && char(2)  UF placa
    this_tDatatrans    = {}   && datetime data transporte
    this_nNtrans       = 0    && numeric(6,0) numero transporte
    this_cObsfretes    = ""   && char(10) obs frete

    *-- Display-only via JOIN SigPrTrp
    this_cTranspNome   = ""
    this_cTranspEnde   = ""
    this_cTranspCida   = ""
    this_cTranspEsta   = ""

    *-- =========================================================================
    *-- Volumes transportados
    *-- =========================================================================
    this_nQtdes        = 0    && numeric(6,0) qtde de volumes
    this_cEspes        = ""   && char(10) especie do volume
    this_cMarcas       = ""   && char(10) marca do volume
    this_cNumeros      = ""   && char(10) numero do volume
    this_nPliqs        = 0    && numeric(10,3) peso liquido
    this_nPbrus        = 0    && numeric(10,3) peso bruto
    this_cObspbrus     = ""   && char(10) obs peso bruto
    this_cObspliqs     = ""   && char(10) obs peso liquido

    *-- =========================================================================
    *-- Servicos
    *-- =========================================================================
    this_cDescsers     = ""   && text  descricao servicos (memo)
    this_nVtotsers     = 0    && numeric(14,2) valor total servicos
    this_nPerciss      = 0    && numeric(5,2)  % ISS
    this_nVtotiss      = 0    && numeric(14,2) valor total ISS
    this_cCodservs     = ""   && char(10) cod. servico
    this_cDescservs    = ""   && char(40) desc. servico

    *-- ISS retido / outras retencoes
    this_nIssretidos   = 0    && numeric(1,0)  ISS retido flag
    this_nOutretens    = 0    && numeric(15,2) outras retencoes
    this_cPrestservs   = ""   && char(7)  prestador servicos
    this_nVdeducoes    = 0    && numeric(15,2) valor deducoes
    this_nVdscconds    = 0    && numeric(15,2) desc. condicionado
    this_nVdsciconds   = 0    && numeric(15,2) desc. incondicionado
    this_cTiponfs      = ""   && char(2)  tipo NF
    this_nTptribsers   = 0    && numeric(2,0)  tipo tribut. servicos
    this_cCodsrvfis    = ""   && char(6)  cod. servico fiscal
    this_cCodbenefs    = ""   && char(3)  cod. beneficio

    *-- =========================================================================
    *-- PIS / COFINS / CSLL / IR / INSS
    *-- =========================================================================
    this_nPcofins      = 0    && numeric(5,2)  % COFINS
    this_nVcofins      = 0    && numeric(14,2) valor COFINS
    this_nPcsll        = 0    && numeric(5,2)  % CSLL
    this_nVcsll        = 0    && numeric(14,2) valor CSLL
    this_nPinss        = 0    && numeric(5,2)  % INSS
    this_nVinss        = 0    && numeric(14,2) valor INSS
    this_nPirf         = 0    && numeric(5,2)  % IR
    this_nVirf         = 0    && numeric(14,2) valor IR
    this_nPpis         = 0    && numeric(5,2)  % PIS
    this_nVpis         = 0    && numeric(14,2) valor PIS
    this_nValiis       = 0    && numeric(14,2) valor II

    *-- =========================================================================
    *-- RPS (Recibo Provisorio de Servicos)
    *-- =========================================================================
    this_nLoterps      = 0    && numeric(6,0)  lote RPS
    this_nNumrps       = 0    && numeric(12,0) numero RPS
    this_cSerierps     = ""   && char(5)  serie RPS
    this_cTiporps      = ""   && char(5)  tipo RPS

    *-- =========================================================================
    *-- NF-e / Chaves eletronicas
    *-- =========================================================================
    this_cNfechv       = ""   && char(44) chave NF-e
    this_cNfechvc      = ""   && char(44) chave NF-e cancelamento
    this_cChnfes       = ""   && char(44) chave NF-e referenciada
    this_cNfepdf       = ""   && text     NF-e PDF
    this_cNfeprt       = ""   && char(15) NF-e protocolo
    this_cNfetxt       = ""   && text     NF-e texto
    this_cNfexml       = ""   && text     NF-e XML
    this_cCanxml       = ""   && text     XML cancelamento
    this_tDdesembs     = {}   && datetime data desembarque
    this_tDregdis      = {}   && datetime data registro DI
    this_cNdis         = ""   && char(10) numero DI
    this_tInvcbds      = {}   && datetime data invalida CBD
    this_nChkenvias    = 0    && numeric(1,0) flag enviado
    this_cChaveexterna = ""   && char(33) chave externa
    this_nChkrastreio  = 0    && numeric(1,0) flag rastreio

    *-- =========================================================================
    *-- Observacoes / Misc
    *-- =========================================================================
    this_cObss         = ""   && char(40) observacoes
    this_cObs2s        = ""   && char(40) observacoes 2
    this_nImpress      = 0    && numeric(6,0)  numero de impressoes
    this_nSelos        = 0    && numeric(10,0) selos
    this_cLocals       = ""   && char(10) local
    this_tImportas     = {}   && datetime data importacao
    this_cNumeronota   = ""   && char(10) numero nota alternativo

    *-- =========================================================================
    *-- Filtros de pesquisa (usados em Buscar)
    *-- =========================================================================
    this_cEmpsFiltro    = ""   && empresa para filtro
    this_cSeriesFiltro  = ""   && serie para filtro
    this_tEmisDeFiltro  = {}   && periodo emissao de
    this_tEmisAteFiltro = {}   && periodo emissao ate
    this_cOpeFiltro     = "A"  && E=Entrada S=Saida A=Ambas
    this_cNfisDeFiltro  = ""   && NF de (filtro por numero)
    this_cNfisAteFiltro = ""   && NF ate (filtro por numero)
    this_lCancelasFiltro = .F. && incluir canceladas

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvNfi"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * LimparDados - Limpa propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCidchaves    = ""
        THIS.this_cEmpdopnums   = ""
        THIS.this_cEmps         = ""
        THIS.this_cDopes        = ""
        THIS.this_nNumes        = 0
        THIS.this_cNfis         = ""
        THIS.this_cSeries       = ""
        THIS.this_cEspecienfs   = ""
        THIS.this_tEmis         = {}
        THIS.this_tDtsaidas     = {}
        THIS.this_tDatans       = {}
        THIS.this_cOperas       = ""
        THIS.this_lCorrecs      = .F.
        THIS.this_lCancelas     = .F.
        THIS.this_lRegs         = .F.
        THIS.this_cCfis         = ""
        THIS.this_cClfis        = ""
        THIS.this_cCodcons      = ""
        THIS.this_cConds        = ""
        THIS.this_cCfosubs      = ""
        THIS.this_cDescricaos   = ""
        THIS.this_cClifors      = ""
        THIS.this_cCgcs         = ""
        THIS.this_cRclis        = ""
        THIS.this_nBasecipis    = 0
        THIS.this_nValipis      = 0
        THIS.this_nIpis         = 0
        THIS.this_nIpincreds    = 0
        THIS.this_nBasecip2s    = 0
        THIS.this_nBasecip3s    = 0
        THIS.this_nDesipis      = 0
        THIS.this_nFrtipis      = 0
        THIS.this_nSegipis      = 0
        THIS.this_nBasecicms    = 0
        THIS.this_nValicms      = 0
        THIS.this_nIcms         = 0
        THIS.this_nBasecic2s    = 0
        THIS.this_nBasecic3s    = 0
        THIS.this_nBcicmss      = 0
        THIS.this_nIcmss        = 0
        THIS.this_nDesicms      = 0
        THIS.this_nFrticms      = 0
        THIS.this_nSegicms      = 0
        THIS.this_nVfcpst       = 0
        THIS.this_nTotProds     = 0
        THIS.this_nTotNotas     = 0
        THIS.this_nVals         = 0
        THIS.this_nPesos        = 0
        THIS.this_nVlFretes     = 0
        THIS.this_nVlSeguros    = 0
        THIS.this_nDespAces     = 0
        THIS.this_cCodtrans     = ""
        THIS.this_nFretes       = 0
        THIS.this_cPlacas       = ""
        THIS.this_cUfPlacas     = ""
        THIS.this_tDatatrans    = {}
        THIS.this_nNtrans       = 0
        THIS.this_cObsfretes    = ""
        THIS.this_cTranspNome   = ""
        THIS.this_cTranspEnde   = ""
        THIS.this_cTranspCida   = ""
        THIS.this_cTranspEsta   = ""
        THIS.this_nQtdes        = 0
        THIS.this_cEspes        = ""
        THIS.this_cMarcas       = ""
        THIS.this_cNumeros      = ""
        THIS.this_nPliqs        = 0
        THIS.this_nPbrus        = 0
        THIS.this_cObspbrus     = ""
        THIS.this_cObspliqs     = ""
        THIS.this_cDescsers     = ""
        THIS.this_nVtotsers     = 0
        THIS.this_nPerciss      = 0
        THIS.this_nVtotiss      = 0
        THIS.this_cCodservs     = ""
        THIS.this_cDescservs    = ""
        THIS.this_nIssretidos   = 0
        THIS.this_nOutretens    = 0
        THIS.this_cPrestservs   = ""
        THIS.this_nVdeducoes    = 0
        THIS.this_nVdscconds    = 0
        THIS.this_nVdsciconds   = 0
        THIS.this_cTiponfs      = ""
        THIS.this_nTptribsers   = 0
        THIS.this_cCodsrvfis    = ""
        THIS.this_cCodbenefs    = ""
        THIS.this_nPcofins      = 0
        THIS.this_nVcofins      = 0
        THIS.this_nPcsll        = 0
        THIS.this_nVcsll        = 0
        THIS.this_nPinss        = 0
        THIS.this_nVinss        = 0
        THIS.this_nPirf         = 0
        THIS.this_nVirf         = 0
        THIS.this_nPpis         = 0
        THIS.this_nVpis         = 0
        THIS.this_nValiis       = 0
        THIS.this_nLoterps      = 0
        THIS.this_nNumrps       = 0
        THIS.this_cSerierps     = ""
        THIS.this_cTiporps      = ""
        THIS.this_cNfechv       = ""
        THIS.this_cNfechvc      = ""
        THIS.this_cChnfes       = ""
        THIS.this_cNfepdf       = ""
        THIS.this_cNfeprt       = ""
        THIS.this_cNfetxt       = ""
        THIS.this_cNfexml       = ""
        THIS.this_cCanxml       = ""
        THIS.this_tDdesembs     = {}
        THIS.this_tDregdis      = {}
        THIS.this_cNdis         = ""
        THIS.this_tInvcbds      = {}
        THIS.this_nChkenvias    = 0
        THIS.this_cChaveexterna = ""
        THIS.this_nChkrastreio  = 0
        THIS.this_cObss         = ""
        THIS.this_cObs2s        = ""
        THIS.this_nImpress      = 0
        THIS.this_nSelos        = 0
        THIS.this_cLocals       = ""
        THIS.this_tImportas     = {}
        THIS.this_cNumeronota   = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega dados do cursor para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "C")
            THIS.this_cEmpdopnums  = TratarNulo(empdopnums,  "C")
            THIS.this_cEmps        = TratarNulo(emps,        "C")
            THIS.this_cDopes       = TratarNulo(dopes,       "C")
            THIS.this_nNumes       = TratarNulo(numes,       "N")
            THIS.this_cNfis        = TratarNulo(nfis,        "C")
            THIS.this_cSeries      = TratarNulo(series,      "C")
            THIS.this_cEspecienfs  = TratarNulo(especienfs,  "C")
            IF !ISNULL(emis)
                THIS.this_tEmis    = emis
            ENDIF
            IF !ISNULL(dtsaidas)
                THIS.this_tDtsaidas = dtsaidas
            ENDIF
            IF !ISNULL(datans)
                THIS.this_tDatans  = datans
            ENDIF
            THIS.this_cOperas      = TratarNulo(operas,      "C")
            THIS.this_lCorrecs     = (IIF(ISNULL(correcs),  0, correcs)  <> 0)
            THIS.this_lCancelas    = (IIF(ISNULL(cancelas), 0, cancelas) <> 0)
            THIS.this_lRegs        = (IIF(ISNULL(regs),     0, regs)     <> 0)
            THIS.this_cCfis        = TratarNulo(cfis,        "C")
            THIS.this_cClfis       = TratarNulo(clfis,       "C")
            THIS.this_cCodcons     = TratarNulo(codcons,     "C")
            THIS.this_cConds       = TratarNulo(conds,       "C")
            THIS.this_cClifors     = TratarNulo(clifors,     "C")
            THIS.this_cCgcs        = TratarNulo(cgcs,        "C")
            THIS.this_nBasecipis   = TratarNulo(basecipis,   "N")
            THIS.this_nValipis     = TratarNulo(valipis,     "N")
            THIS.this_nIpis        = TratarNulo(ipis,        "N")
            THIS.this_nIpincreds   = TratarNulo(ipincreds,   "N")
            THIS.this_nBasecip2s   = TratarNulo(basecip2s,   "N")
            THIS.this_nBasecip3s   = TratarNulo(basecip3s,   "N")
            THIS.this_nBasecicms   = TratarNulo(basecicms,   "N")
            THIS.this_nValicms     = TratarNulo(valicms,     "N")
            THIS.this_nIcms        = TratarNulo(icms,        "N")
            THIS.this_nBasecic2s   = TratarNulo(basecic2s,   "N")
            THIS.this_nBasecic3s   = TratarNulo(basecic3s,   "N")
            THIS.this_nTotProds    = TratarNulo(totprods,    "N")
            THIS.this_nTotNotas    = TratarNulo(totnotas,    "N")
            THIS.this_nVals        = TratarNulo(vals,        "N")
            THIS.this_nPesos       = TratarNulo(pesos,       "N")
            THIS.this_nVlFretes    = TratarNulo(vlfretes,    "N")
            THIS.this_nVlSeguros   = TratarNulo(vlseguros,   "N")
            THIS.this_nDespAces    = TratarNulo(despaces,    "N")
            THIS.this_cCodtrans    = TratarNulo(codtrans,    "C")
            THIS.this_nFretes      = TratarNulo(fretes,      "N")
            THIS.this_cPlacas      = TratarNulo(placas,      "C")
            THIS.this_cUfPlacas    = TratarNulo(ufplacas,    "C")
            IF !ISNULL(datatrans)
                THIS.this_tDatatrans = datatrans
            ENDIF
            THIS.this_nQtdes       = TratarNulo(qtdes,       "N")
            THIS.this_cEspes       = TratarNulo(espes,       "C")
            THIS.this_cMarcas      = TratarNulo(marcas,      "C")
            THIS.this_cNumeros     = TratarNulo(numeros,     "C")
            THIS.this_nPliqs       = TratarNulo(pliqs,       "N")
            THIS.this_nPbrus       = TratarNulo(pbrus,       "N")
            THIS.this_cDescsers    = TratarNulo(descsers,    "C")
            THIS.this_nVtotsers    = TratarNulo(vtotsers,    "N")
            THIS.this_nPerciss     = TratarNulo(perciss,     "N")
            THIS.this_nVtotiss     = TratarNulo(vtotiss,     "N")
            THIS.this_nImpress     = TratarNulo(impress,     "N")
            THIS.this_cObss        = TratarNulo(obss,        "C")
            THIS.this_cObs2s       = TratarNulo(obs2s,       "C")
            IF !ISNULL(importas)
                THIS.this_tImportas = importas
            ENDIF
            *-- Campos de JOIN (presentes quando vem de Buscar ou CarregarPorCodigo)
            IF TYPE("rclis") <> "U"
                THIS.this_cRclis       = TratarNulo(rclis,       "C")
            ENDIF
            IF TYPE("descricaos") <> "U"
                THIS.this_cDescricaos  = TratarNulo(descricaos,  "C")
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar cursor: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Pesquisa NFs com filtros configurados nas propriedades de filtro
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cJoinCfg, loc_cWhereOpe, loc_cWhereSerie, loc_cWhereData
        LOCAL loc_cWhereNfi, loc_cWhereCan, loc_nCfgCount
        loc_lSucesso  = .F.
        loc_nCfgCount = 0

        IF EMPTY(THIS.this_cEmps)
            MsgAviso("Empresa obrigat" + CHR(243) + "ria para pesquisa.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verifica SigCnFNF: join por emps+series ou apenas series
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS qtd FROM SigCnFNF WHERE emps = " + ;
                EscaparSQL(PADR(THIS.this_cEmps, 3)), ;
                "cursor_4c_CfgNFNF")
            IF loc_nResultado >= 0 AND USED("cursor_4c_CfgNFNF") AND RECCOUNT("cursor_4c_CfgNFNF") > 0
                SELECT cursor_4c_CfgNFNF
                loc_nCfgCount = cursor_4c_CfgNFNF.qtd
            ENDIF
            IF USED("cursor_4c_CfgNFNF")
                USE IN cursor_4c_CfgNFNF
            ENDIF

            IF loc_nCfgCount > 0
                loc_cJoinCfg = "LEFT JOIN SigCnFNF g ON g.emps + g.series = n.emps + n.series"
            ELSE
                loc_cJoinCfg = "LEFT JOIN SigCnFNF g ON g.series = n.series"
            ENDIF

            *-- Filtro operacao E/S/A
            DO CASE
                CASE THIS.this_cOpeFiltro = "E"
                    loc_cWhereOpe = " AND n.operas = 'E'"
                CASE THIS.this_cOpeFiltro = "S"
                    loc_cWhereOpe = " AND n.operas = 'S'"
                OTHERWISE
                    loc_cWhereOpe = " AND n.operas IN ('E','S')"
            ENDCASE

            *-- Filtro serie
            IF EMPTY(THIS.this_cSeriesFiltro)
                loc_cWhereSerie = ""
            ELSE
                loc_cWhereSerie = " AND n.series = " + EscaparSQL(PADR(THIS.this_cSeriesFiltro, 8))
            ENDIF

            *-- Filtro data emissao
            IF EMPTY(THIS.this_tEmisDeFiltro) OR EMPTY(THIS.this_tEmisAteFiltro)
                loc_cWhereData = ""
            ELSE
                loc_cWhereData = " AND CAST(n.emis AS DATE) BETWEEN " + ;
                    FormatarDataSQL(THIS.this_tEmisDeFiltro) + ;
                    " AND " + FormatarDataSQL(THIS.this_tEmisAteFiltro)
            ENDIF

            *-- Filtro numero NF
            IF EMPTY(THIS.this_cNfisDeFiltro) AND EMPTY(THIS.this_cNfisAteFiltro)
                loc_cWhereNfi = ""
            ELSE
                loc_cWhereNfi = " AND n.nfis BETWEEN " + ;
                    EscaparSQL(PADR(THIS.this_cNfisDeFiltro, 6)) + ;
                    " AND " + EscaparSQL(IIF(EMPTY(THIS.this_cNfisAteFiltro), ;
                        REPLICATE(CHR(254), 6), PADR(THIS.this_cNfisAteFiltro, 6)))
            ENDIF

            *-- Filtro canceladas (padrao = so nao canceladas)
            IF THIS.this_lCancelasFiltro
                loc_cWhereCan = ""
            ELSE
                loc_cWhereCan = " AND n.cancelas = 0"
            ENDIF

            loc_cSQL = "SELECT n.cidchaves, n.empdopnums, n.emps, n.dopes, n.numes," + ;
                " n.nfis, n.series, n.especienfs, n.emis, n.dtsaidas, n.datans," + ;
                " n.operas, n.correcs, n.cancelas, n.regs," + ;
                " n.cfis, n.clfis, n.codcons, n.conds," + ;
                " n.clifors, n.cgcs," + ;
                " n.basecipis, n.valipis, n.ipis, n.ipincreds," + ;
                " n.basecip2s, n.basecip3s," + ;
                " n.basecicms, n.valicms, n.icms," + ;
                " n.basecic2s, n.basecic3s," + ;
                " n.totprods, n.totnotas, n.vals, n.pesos," + ;
                " n.vlfretes, n.vlseguros, n.despaces," + ;
                " n.codtrans, n.fretes, n.placas, n.ufplacas, n.datatrans," + ;
                " n.qtdes, n.espes, n.marcas, n.numeros, n.pliqs, n.pbrus," + ;
                " n.descsers, n.vtotsers, n.perciss, n.vtotiss," + ;
                " n.impress, n.obss, n.obs2s, n.importas," + ;
                " c.rclis, f.descricaos" + ;
                " FROM SigMvNfi n" + ;
                " " + loc_cJoinCfg + ;
                " LEFT JOIN SigCdCfo f ON f.codigos = n.cfis" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = n.clifors" + ;
                " WHERE n.emps = " + EscaparSQL(PADR(THIS.this_cEmps, 3)) + ;
                loc_cWhereSerie + ;
                loc_cWhereData + ;
                loc_cWhereOpe + ;
                loc_cWhereCan + ;
                loc_cWhereNfi + ;
                " ORDER BY n.nfis, n.emis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar notas fiscais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar notas fiscais:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo pelo cidchaves (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.*, c.rclis, f.descricaos" + ;
                " FROM SigMvNfi n" + ;
                " LEFT JOIN SigCdCfo f ON f.codigos = n.cfis" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = n.clifors" + ;
                " WHERE n.cidchaves = " + EscaparSQL(PADR(ALLTRIM(par_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar NF:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        *-- Carregar dados da transportadora automaticamente apos carregar NF
        IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCodtrans))
            THIS.CarregarTransportadora(THIS.this_cCodtrans)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarTransportadora - Carrega dados do transportador por codtrans
    *==========================================================================
    PROTECTED PROCEDURE CarregarTransportadora(par_cCodTrans)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cTranspNome = ""
        THIS.this_cTranspEnde = ""
        THIS.this_cTranspCida = ""
        THIS.this_cTranspEsta = ""

        IF EMPTY(par_cCodTrans)
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT razaos, endes, cidas, estas" + ;
                " FROM SigPrTrp WHERE itras = " + ;
                EscaparSQL(PADR(ALLTRIM(par_cCodTrans), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Transp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Transp") AND RECCOUNT("cursor_4c_Transp") > 0
                SELECT cursor_4c_Transp
                THIS.this_cTranspNome = TratarNulo(razaos, "C")
                THIS.this_cTranspEnde = TratarNulo(endes,  "C")
                THIS.this_cTranspCida = TratarNulo(cidas,  "C")
                THIS.this_cTranspEsta = TratarNulo(estas,  "C")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar transportadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Transp")
            USE IN cursor_4c_Transp
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarSeries - Carrega series para lookup no filtro
    *==========================================================================
    PROCEDURE BuscarSeries(par_cEmpsFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cEmpsFiltro)
                loc_cSQL = "SELECT DISTINCT Cods, Descs FROM SigCdSer ORDER BY Cods"
            ELSE
                loc_cSQL = "SELECT DISTINCT Cods, Descs FROM SigCdSer" + ;
                    " WHERE emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpsFiltro), 3)) + ;
                    " ORDER BY Cods"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Series")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT no SigMvNfi
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigMvNfi" + ;
                " (cidchaves, empdopnums, emps, dopes, numes," + ;
                "  nfis, series, especienfs, emis, dtsaidas, datans, operas," + ;
                "  correcs, cancelas, regs, cfis, clfis, codcons, conds," + ;
                "  clifors, cgcs, basecipis, valipis, ipis, ipincreds," + ;
                "  basecip2s, basecip3s, basecicms, valicms, icms," + ;
                "  basecic2s, basecic3s, totprods, totnotas, vals, pesos," + ;
                "  vlfretes, vlseguros, despaces, codtrans, fretes," + ;
                "  placas, ufplacas, datatrans," + ;
                "  qtdes, espes, marcas, numeros, pliqs, pbrus," + ;
                "  descsers, vtotsers, perciss, vtotiss, impress, obss, obs2s)" + ;
                " VALUES ("
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmpdopnums), 29)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cNfis), 6)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cSeries), 8)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEspecienfs), 6)) + "," + ;
                IIF(EMPTY(THIS.this_tEmis), "NULL", FormatarDataSQL(THIS.this_tEmis)) + "," + ;
                IIF(EMPTY(THIS.this_tDtsaidas), "NULL", FormatarDataSQL(THIS.this_tDtsaidas)) + "," + ;
                IIF(EMPTY(THIS.this_tDatans), "NULL", FormatarDataSQL(THIS.this_tDatans)) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cOperas), 1)) + ","
            loc_cSQL = loc_cSQL + ;
                IIF(THIS.this_lCorrecs, "1", "0") + "," + ;
                IIF(THIS.this_lCancelas, "1", "0") + "," + ;
                IIF(THIS.this_lRegs, "1", "0") + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCfis), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cClfis), 12)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcons), 9)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cConds), 12)) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cClifors), 20)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCgcs), 21)) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecipis) + "," + ;
                FormatarNumeroSQL(THIS.this_nValipis) + "," + ;
                FormatarNumeroSQL(THIS.this_nIpis) + "," + ;
                FormatarNumeroSQL(THIS.this_nIpincreds) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBasecip2s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecip3s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecicms) + "," + ;
                FormatarNumeroSQL(THIS.this_nValicms) + "," + ;
                FormatarNumeroSQL(THIS.this_nIcms) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBasecic2s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecic3s) + "," + ;
                FormatarNumeroSQL(THIS.this_nTotProds) + "," + ;
                FormatarNumeroSQL(THIS.this_nTotNotas) + "," + ;
                FormatarNumeroSQL(THIS.this_nVals) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesos) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nVlFretes) + "," + ;
                FormatarNumeroSQL(THIS.this_nVlSeguros) + "," + ;
                FormatarNumeroSQL(THIS.this_nDespAces) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtrans), 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nFretes) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cPlacas), 8)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cUfPlacas), 2)) + "," + ;
                IIF(EMPTY(THIS.this_tDatatrans), "NULL", FormatarDataSQL(THIS.this_tDatatrans)) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nQtdes) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEspes), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cMarcas), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cNumeros), 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nPliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPbrus) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescsers)) + "," + ;
                FormatarNumeroSQL(THIS.this_nVtotsers) + "," + ;
                FormatarNumeroSQL(THIS.this_nPerciss) + "," + ;
                FormatarNumeroSQL(THIS.this_nVtotiss) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpress) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cObss), 40)) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cObs2s), 40)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Insert")
            USE IN cursor_4c_Insert
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE no SigMvNfi pelo cidchaves
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvNfi SET" + ;
                " nfis     = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cNfis), 6)) + "," + ;
                " dtsaidas = " + IIF(EMPTY(THIS.this_tDtsaidas), "NULL", FormatarDataSQL(THIS.this_tDtsaidas)) + "," + ;
                " correcs  = " + IIF(THIS.this_lCorrecs, "1", "0") + ","
            loc_cSQL = loc_cSQL + ;
                " cfis    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCfis), 10)) + "," + ;
                " clfis   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cClfis), 12)) + "," + ;
                " clifors = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cClifors), 20)) + ","
            loc_cSQL = loc_cSQL + ;
                " basecipis = " + FormatarNumeroSQL(THIS.this_nBasecipis) + "," + ;
                " valipis   = " + FormatarNumeroSQL(THIS.this_nValipis) + "," + ;
                " ipis      = " + FormatarNumeroSQL(THIS.this_nIpis) + "," + ;
                " basecicms = " + FormatarNumeroSQL(THIS.this_nBasecicms) + ","
            loc_cSQL = loc_cSQL + ;
                " valicms  = " + FormatarNumeroSQL(THIS.this_nValicms) + "," + ;
                " icms     = " + FormatarNumeroSQL(THIS.this_nIcms) + "," + ;
                " totprods = " + FormatarNumeroSQL(THIS.this_nTotProds) + "," + ;
                " totnotas = " + FormatarNumeroSQL(THIS.this_nTotNotas) + ","
            loc_cSQL = loc_cSQL + ;
                " vlfretes  = " + FormatarNumeroSQL(THIS.this_nVlFretes) + "," + ;
                " vlseguros = " + FormatarNumeroSQL(THIS.this_nVlSeguros) + "," + ;
                " despaces  = " + FormatarNumeroSQL(THIS.this_nDespAces) + ","
            loc_cSQL = loc_cSQL + ;
                " codtrans = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtrans), 10)) + "," + ;
                " fretes   = " + FormatarNumeroSQL(THIS.this_nFretes) + "," + ;
                " placas   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cPlacas), 8)) + "," + ;
                " ufplacas = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUfPlacas), 2)) + ","
            loc_cSQL = loc_cSQL + ;
                " datatrans = " + IIF(EMPTY(THIS.this_tDatatrans), "NULL", FormatarDataSQL(THIS.this_tDatatrans)) + "," + ;
                " qtdes     = " + FormatarNumeroSQL(THIS.this_nQtdes) + "," + ;
                " espes     = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEspes), 10)) + ","
            loc_cSQL = loc_cSQL + ;
                " marcas  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cMarcas), 10)) + "," + ;
                " numeros = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cNumeros), 10)) + "," + ;
                " pliqs   = " + FormatarNumeroSQL(THIS.this_nPliqs) + "," + ;
                " pbrus   = " + FormatarNumeroSQL(THIS.this_nPbrus) + ","
            loc_cSQL = loc_cSQL + ;
                " descsers = " + EscaparSQL(ALLTRIM(THIS.this_cDescsers)) + "," + ;
                " vtotsers = " + FormatarNumeroSQL(THIS.this_nVtotsers) + "," + ;
                " perciss  = " + FormatarNumeroSQL(THIS.this_nPerciss) + "," + ;
                " vtotiss  = " + FormatarNumeroSQL(THIS.this_nVtotiss) + ","
            loc_cSQL = loc_cSQL + ;
                " obss  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObss), 40)) + "," + ;
                " obs2s = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObs2s), 40)) + ;
                " WHERE cidchaves = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE do SigMvNfi pelo cidchaves
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvNfi" + ;
                " WHERE cidchaves = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Delete")
            USE IN cursor_4c_Delete
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

