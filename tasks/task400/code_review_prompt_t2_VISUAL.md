# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [ALINHAMENTO] Botao 'cmd_4c_Copia' tem Top=19 mas grupo usa Top=5 (diferenca de 14px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelarCopia' tem Top=19 mas grupo usa Top=5 (diferenca de 14px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDup.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2897 linhas total):

*-- Linhas 55 a 64:
55:                 MsgErro("Erro ao criar DupBO", "Erro")
56:             ELSE
57:                 THIS.ConfigurarPageFrame()
58:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
62:                     THIS.CarregarLista()
63:                 ENDIF
64: 

*-- Linhas 82 a 100:
82:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83:             WITH THIS.pgf_4c_Paginas
84:                 .PageCount  = 2
85:                 .Top        = -29
86:                 .Left       = 0
87:                 .Width      = THIS.Width
88:                 .Height     = THIS.Height + 29
89:                 .Tabs       = .F.
90:                 .TabStretch = 1
91:                 .Visible    = .T.
92:                 .Page1.Caption   = "Lista"
93:                 .Page1.BackColor = RGB(236, 236, 236)
94:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:                 .Page2.Caption   = "Dados"
96:                 .Page2.BackColor = RGB(236, 236, 236)
97:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             ENDWITH
99: 
100:             THIS.ConfigurarPaginaLista()

*-- Linhas 120 a 156:
120:             *-- Container cabecalho (cntSombra no legado) - Top=2 dentro da Page
121:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
122:             WITH loc_oPagina.cnt_4c_Cabecalho
123:                 .Top         = 2
124:                 .Left        = 0
125:                 .Width       = THIS.Width
126:                 .Height      = 80
127:                 .BackColor   = RGB(100, 100, 100)
128:                 .BorderWidth = 0
129:                 .Visible     = .T.
130: 
131:                 .AddObject("lbl_4c_Sombra", "Label")
132:                 WITH .lbl_4c_Sombra
133:                     .Caption   = THIS.Caption
134:                     .Top       = 15
135:                     .Left      = 10
136:                     .Width     = THIS.Width
137:                     .Height    = 40
138:                     .FontName  = "Tahoma"
139:                     .FontSize  = 16
140:                     .FontBold  = .T.
141:                     .ForeColor = RGB(0, 0, 0)
142:                     .BackStyle = 0
143:                     .AutoSize  = .F.
144:                     .Visible   = .T.
145:                 ENDWITH
146: 
147:                 .AddObject("lbl_4c_Titulo", "Label")
148:                 WITH .lbl_4c_Titulo
149:                     .Caption   = THIS.Caption
150:                     .Top       = 18
151:                     .Left      = 10
152:                     .Width     = THIS.Width
153:                     .Height    = 46
154:                     .FontName  = "Tahoma"
155:                     .FontSize  = 16
156:                     .FontBold  = .T.

*-- Linhas 164 a 187:
164:             *-- Container botoes CRUD (Grupo_Op no legado) - lado direito
165:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
166:             WITH loc_oPagina.cnt_4c_Botoes
167:                 .Top         = 0
168:                 .Left        = 542
169:                 .Width       = 390
170:                 .Height      = 85
171:                 .BackStyle   = 1
172:                 .BackColor   = RGB(53, 53, 53)
173:                 .BorderWidth = 0
174:                 .Visible     = .T.
175: 
176:                 .AddObject("cmd_4c_Incluir", "CommandButton")
177:                 WITH .cmd_4c_Incluir
178:                     .Caption         = "Incluir"
179:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:                     .PicturePosition = 13
181:                     .Top             = 5
182:                     .Left            =  542
183:                     .Width           = 75
184:                     .Height          = 75
185:                     .FontName        = "Tahoma"
186:                     .FontSize        = 8
187:                     .FontBold        = .T.

*-- Linhas 194 a 208:
194:                     .AutoSize        = .F.
195:                 ENDWITH
196: 
197:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
198:                 WITH .cmd_4c_Visualizar
199:                     .Caption         = "Visualizar"
200:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
201:                     .PicturePosition = 13
202:                     .Top             = 5
203:                     .Left            =  542
204:                     .Width           = 75
205:                     .Height          = 75
206:                     .FontName        = "Tahoma"
207:                     .FontSize        = 8
208:                     .FontBold        = .T.

*-- Linhas 216 a 230:
216:                     .AutoSize        = .F.
217:                 ENDWITH
218: 
219:                 .AddObject("cmd_4c_Alterar", "CommandButton")
220:                 WITH .cmd_4c_Alterar
221:                     .Caption         = "Alterar"
222:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:                     .PicturePosition = 13
224:                     .Top             = 5
225:                     .Left            =  542
226:                     .Width           = 75
227:                     .Height          = 75
228:                     .FontName        = "Tahoma"
229:                     .FontSize        = 8
230:                     .FontBold        = .T.

*-- Linhas 238 a 252:
238:                     .AutoSize        = .F.
239:                 ENDWITH
240: 
241:                 .AddObject("cmd_4c_Excluir", "CommandButton")
242:                 WITH .cmd_4c_Excluir
243:                     .Caption         = "Excluir"
244:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:                     .PicturePosition = 13
246:                     .Top             = 5
247:                     .Left            =  542
248:                     .Width           = 75
249:                     .Height          = 75
250:                     .FontName        = "Tahoma"
251:                     .FontSize        = 8
252:                     .FontBold        = .T.

*-- Linhas 260 a 274:
260:                     .AutoSize        = .F.
261:                 ENDWITH
262: 
263:                 .AddObject("cmd_4c_Buscar", "CommandButton")
264:                 WITH .cmd_4c_Buscar
265:                     .Caption         = "Buscar"
266:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
267:                     .PicturePosition = 13
268:                     .Top             = 5
269:                     .Left            =  542
270:                     .Width           = 75
271:                     .Height          = 75
272:                     .FontName        = "Tahoma"
273:                     .FontSize        = 8
274:                     .FontBold        = .T.

*-- Linhas 286 a 308:
286:             *-- Container saida - padrao canonico (CLAUDE.md regra #10)
287:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
288:             WITH loc_oPagina.cnt_4c_Saida
289:                 .Top         = 29
290:                 .Left        = 917
291:                 .Width       = 90
292:                 .Height      = 85
293:                 .BackStyle   = 0
294:                 .BorderWidth = 0
295:                 .Visible     = .T.
296: 
297:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
298:                 WITH .cmd_4c_Encerrar
299:                     .Caption         = "Encerrar"
300:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
301:                     .PicturePosition = 13
302:                     .Top             = 5
303:                     .Left            = 917
304:                     .Width           = 75
305:                     .Height          = 75
306:                     .FontName        = "Tahoma"
307:                     .FontSize        = 8
308:                     .FontBold        = .T.

*-- Linhas 315 a 336:
315:                     .AutoSize        = .F.
316:                 ENDWITH
317:             ENDWITH
318: 
319:             *-- Botao Copiar (Copia no legado) - original top=4 -> migrado 4+29=33
320:             loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
321:             WITH loc_oPagina.cmd_4c_Copia
322:                 .Caption         = "Copiar"
323:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
324:                 .PicturePosition = 13
325:                 .Top             = 19
326:                 .Left            = 474
327:                 .Width           = 75
328:                 .Height          = 75
329:                 .FontName        = "Tahoma"
330:                 .FontSize        = 8
331:                 .FontBold        = .T.
332:                 .FontItalic      = .T.
333:                 .ForeColor       = RGB(90, 90, 90)
334:                 .BackColor       = RGB(255, 255, 255)
335:                 .Themes          = .F.
336:                 .SpecialEffect   = 0

*-- Linhas 347 a 356:
347:             loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
348:             loc_oPagina.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.series"
349:             WITH loc_oPagina.grd_4c_Lista
350:                 .Top                = 117
351:                 .Left               = 12
352:                 .Width              = 890
353:                 .Height             = 490
354:                 .FontName           = "Verdana"
355:                 .FontSize           = 8
356:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 370 a 502:
370:                     .ControlSource    = "cursor_4c_Dados.series"
371:                     .Width            = 100
372:                     .Resizable        = .T.
373:                     .Header1.Caption  = "S" + CHR(233) + "rie"
374:                 ENDWITH
375:             ENDWITH
376: 
377:             *-- Painel flutuante de copia de series (cntcopia no legado - Visible=.F.)
378:             *-- Top=270 = 241 (original) + 29 (compensacao PageFrame)
379:             *-- Nome "cnt_4c_CopiaFl" -> UPPER = "CNT_4C_COPIAFL" (guardado em TornarControlesVisiveis)
380:             loc_oPagina.AddObject("cnt_4c_CopiaFl", "Container")
381:             WITH loc_oPagina.cnt_4c_CopiaFl
382:                 .Top         = 270
383:                 .Left        = 335
384:                 .Width       = 317
385:                 .Height      = 123
386:                 .BackColor   = RGB(220, 220, 220)
387:                 .BorderWidth = 1
388:                 .Visible     = .F.
389: 
390:                 .AddObject("lbl_4c_LblSerieOrigem", "Label")
391:                 WITH .lbl_4c_LblSerieOrigem
392:                     .Caption   = "S" + CHR(233) + "rie Origem :"
393:                     .Top       = 40
394:                     .Left      = 29
395:                     .Width     = 72
396:                     .Height    = 15
397:                     .FontName  = "Tahoma"
398:                     .FontSize  = 8
399:                     .BackStyle = 0
400:                     .ForeColor = RGB(0, 0, 0)
401:                     .Visible   = .T.
402:                 ENDWITH
403: 
404:                 .AddObject("txt_4c_SeriesOrigem", "TextBox")
405:                 WITH .txt_4c_SeriesOrigem
406:                     .Top      = 36
407:                     .Left     = 103
408:                     .Width    = 34
409:                     .Height   = 24
410:                     .FontName = "Tahoma"
411:                     .FontSize = 8
412:                     .Value    = ""
413:                     .ReadOnly = .T.
414:                     .Visible  = .T.
415:                 ENDWITH
416: 
417:                 .AddObject("lbl_4c_LblSerieDestino", "Label")
418:                 WITH .lbl_4c_LblSerieDestino
419:                     .Caption   = "S" + CHR(233) + "rie Destino :"
420:                     .Top       = 66
421:                     .Left      = 27
422:                     .Width     = 72
423:                     .Height    = 15
424:                     .FontName  = "Tahoma"
425:                     .FontSize  = 8
426:                     .BackStyle = 0
427:                     .ForeColor = RGB(0, 0, 0)
428:                     .Visible   = .T.
429:                 ENDWITH
430: 
431:                 .AddObject("txt_4c_SerieDestino", "TextBox")
432:                 WITH .txt_4c_SerieDestino
433:                     .Top      = 62
434:                     .Left     = 103
435:                     .Width    = 34
436:                     .Height   = 24
437:                     .FontName = "Tahoma"
438:                     .FontSize = 8
439:                     .Value    = ""
440:                     .Visible  = .T.
441:                 ENDWITH
442: 
443:                 .AddObject("cmd_4c_OKCopia", "CommandButton")
444:                 WITH .cmd_4c_OKCopia
445:                     .Caption       = "Confirmar"
446:                     .Top           = 5
447:                     .Left          = 158
448:                     .Width         = 75
449:                     .Height        = 75
450:                     .FontName      = "Tahoma"
451:                     .FontSize      = 8
452:                     .ForeColor     = RGB(90, 90, 90)
453:                     .BackColor     = RGB(255, 255, 255)
454:                     .Themes        = .F.
455:                     .SpecialEffect = 0
456:                     .MousePointer  = 15
457:                     .Visible       = .T.
458:                 ENDWITH
459: 
460:                 .AddObject("cmd_4c_CancelarCopia", "CommandButton")
461:                 WITH .cmd_4c_CancelarCopia
462:                     .Caption       = "Cancelar"
463:                     .Top           = 19
464:                     .Left          = 239
465:                     .Width         = 75
466:                     .Height        = 75
467:                     .FontName      = "Tahoma"
468:                     .FontSize      = 8
469:                     .ForeColor     = RGB(90, 90, 90)
470:                     .BackColor     = RGB(255, 255, 255)
471:                     .Themes        = .F.
472:                     .SpecialEffect = 0
473:                     .MousePointer  = 15
474:                     .Visible       = .T.
475:                 ENDWITH
476:             ENDWITH
477: 
478:             *-- BINDEVENTs da Page1
479:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,        "Click", THIS, "BtnIncluirClick")
480:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,     "Click", THIS, "BtnVisualizarClick")
481:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,        "Click", THIS, "BtnAlterarClick")
482:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,        "Click", THIS, "BtnExcluirClick")
483:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,         "Click", THIS, "BtnBuscarClick")
484:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,        "Click", THIS, "BtnEncerrarClick")
485:             BINDEVENT(loc_oPagina.cmd_4c_Copia,                        "Click", THIS, "BtnCopiarClick")
486:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_OKCopia,       "Click", THIS, "BtnOKCopiarClick")
487:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiarClick")
488:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.txt_4c_SerieDestino,  "KeyPress", THIS, "ValidarSerieDestino")
489: 
490:             THIS.TornarControlesVisiveis(loc_oPagina)
491: 
492:         CATCH TO loException
493:             MsgErro("Erro ao configurar Page1:" + CHR(13) + loException.Message, "Erro")
494:         ENDTRY
495:     ENDPROC
496: 
497:     *==========================================================================
498:     * ConfigurarPaginaDados - Configura Page2 (Dados)
499:     * Fase 5: Serie, Cabecalho e primeira linha do Sacado
500:     * Fase 6: Segunda linha Sacado, Observacao e Impressora (a adicionar)
501:     *==========================================================================
502:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 510 a 1102:
510:             *------------------------------------------------------------------
511:             * SERIE (PK) - txt_4c_Series: top=70+29=99 / Label40: top=72+29=101
512:             *------------------------------------------------------------------
513:             loc_oPagina.AddObject("lbl_4c_LblSerie", "Label")
514:             WITH loc_oPagina.lbl_4c_LblSerie
515:                 .Caption   = "S" + CHR(233) + "rie :"
516:                 .Top       = 101
517:                 .Left      = 185
518:                 .Width     = 37
519:                 .Height    = 15
520:                 .FontName  = "Tahoma"
521:                 .FontSize  = 8
522:                 .ForeColor = RGB(90, 90, 90)
523:                 .BackStyle = 0
524:                 .Visible   = .T.
525:             ENDWITH
526: 
527:             loc_oPagina.AddObject("txt_4c_Series", "TextBox")
528:             WITH loc_oPagina.txt_4c_Series
529:                 .Value    = ""
530:                 .Top      = 99
531:                 .Left     = 229
532:                 .Width    = 31
533:                 .Height   = 18
534:                 .FontName = "Tahoma"
535:                 .FontSize = 8
536:                 .Visible  = .T.
537:             ENDWITH
538: 
539:             *------------------------------------------------------------------
540:             * SECAO CABECALHO (linha/coluna impressao dados do documento)
541:             * Label27 top=103+29=132 / Shape1 top=119+29=148
542:             *------------------------------------------------------------------
543:             loc_oPagina.AddObject("lbl_4c_SecCabecalho", "Label")
544:             WITH loc_oPagina.lbl_4c_SecCabecalho
545:                 .Caption   = "Cabe" + CHR(231) + "alho"
546:                 .Top       = 132
547:                 .Left      = 183
548:                 .Width     = 80
549:                 .Height    = 15
550:                 .FontName  = "Tahoma"
551:                 .FontSize  = 8
552:                 .FontBold  = .T.
553:                 .ForeColor = RGB(90, 90, 90)
554:                 .BackStyle = 0
555:                 .Visible   = .T.
556:             ENDWITH
557: 
558:             loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
559:             WITH loc_oPagina.shp_4c_Shape1
560:                 .Top           = 148
561:                 .Left          = 173
562:                 .Width         = 560
563:                 .Height        = 2
564:                 .FillColor     = RGB(150, 150, 150)
565:                 .ForeColor     = RGB(150, 150, 150)
566:                 .BackStyle     = 0
567:                 .BorderStyle   = 1
568:                 .SpecialEffect = 0
569:                 .Visible       = .T.
570:             ENDWITH
571: 
572:             *-- Data Emissao (Label5/Text5/Label6/Text6) top=124+29=153 / 138+29=167
573:             loc_oPagina.AddObject("lbl_4c_LblDtDoc", "Label")
574:             WITH loc_oPagina.lbl_4c_LblDtDoc
575:                 .Caption   = "Data Emiss" + CHR(227) + "o"
576:                 .Top       = 153
577:                 .Left      = 184
578:                 .Width     = 66
579:                 .Height    = 15
580:                 .FontName  = "Tahoma"
581:                 .FontSize  = 8
582:                 .ForeColor = RGB(90, 90, 90)
583:                 .BackStyle = 0
584:                 .Visible   = .T.
585:             ENDWITH
586:             loc_oPagina.AddObject("txt_4c_Text5", "TextBox")
587:             WITH loc_oPagina.txt_4c_Text5
588:                 .Value    = 0
589:                 .Top      = 167
590:                 .Left     = 184
591:                 .Width    = 41
592:                 .Height   = 18
593:                 .FontName = "Tahoma"
594:                 .FontSize = 8
595:                 .Visible  = .T.
596:             ENDWITH
597:             loc_oPagina.AddObject("lbl_4c_XDtDoc", "Label")
598:             WITH loc_oPagina.lbl_4c_XDtDoc
599:                 .Caption   = "x"
600:                 .Top       = 169
601:                 .Left      = 226
602:                 .Width     = 8
603:                 .Height    = 15
604:                 .FontName  = "Tahoma"
605:                 .FontSize  = 8
606:                 .ForeColor = RGB(90, 90, 90)
607:                 .BackStyle = 0
608:                 .Visible   = .T.
609:             ENDWITH
610:             loc_oPagina.AddObject("txt_4c_Text6", "TextBox")
611:             WITH loc_oPagina.txt_4c_Text6
612:                 .Value    = 0
613:                 .Top      = 167
614:                 .Left     = 233
615:                 .Width    = 41
616:                 .Height   = 18
617:                 .FontName = "Tahoma"
618:                 .FontSize = 8
619:                 .Visible  = .T.
620:             ENDWITH
621: 
622:             *-- Nota Fiscal (Label1/Text1/Label2/Text2) top=153 / 167
623:             loc_oPagina.AddObject("lbl_4c_LblNota", "Label")
624:             WITH loc_oPagina.lbl_4c_LblNota
625:                 .Caption   = "Nota Fiscal"
626:                 .Top       = 153
627:                 .Left      = 293
628:                 .Width     = 54
629:                 .Height    = 15
630:                 .FontName  = "Tahoma"
631:                 .FontSize  = 8
632:                 .ForeColor = RGB(90, 90, 90)
633:                 .BackStyle = 0
634:                 .Visible   = .T.
635:             ENDWITH
636:             loc_oPagina.AddObject("txt_4c_Text1", "TextBox")
637:             WITH loc_oPagina.txt_4c_Text1
638:                 .Value    = 0
639:                 .Top      = 167
640:                 .Left     = 293
641:                 .Width    = 41
642:                 .Height   = 18
643:                 .FontName = "Tahoma"
644:                 .FontSize = 8
645:                 .Visible  = .T.
646:             ENDWITH
647:             loc_oPagina.AddObject("lbl_4c_XNota", "Label")
648:             WITH loc_oPagina.lbl_4c_XNota
649:                 .Caption   = "x"
650:                 .Top       = 169
651:                 .Left      = 335
652:                 .Width     = 8
653:                 .Height    = 15
654:                 .FontName  = "Tahoma"
655:                 .FontSize  = 8
656:                 .ForeColor = RGB(90, 90, 90)
657:                 .BackStyle = 0
658:                 .Visible   = .T.
659:             ENDWITH
660:             loc_oPagina.AddObject("txt_4c_Text2", "TextBox")
661:             WITH loc_oPagina.txt_4c_Text2
662:                 .Value    = 0
663:                 .Top      = 167
664:                 .Left     = 342
665:                 .Width    = 41
666:                 .Height   = 18
667:                 .FontName = "Tahoma"
668:                 .FontSize = 8
669:                 .Visible  = .T.
670:             ENDWITH
671: 
672:             *-- Valor da Duplicata (Label9/Text9/Label10/Text10)
673:             loc_oPagina.AddObject("lbl_4c_LblVlDoc", "Label")
674:             WITH loc_oPagina.lbl_4c_LblVlDoc
675:                 .Caption   = "Valor da Duplicata"
676:                 .Top       = 153
677:                 .Left      = 403
678:                 .Width     = 88
679:                 .Height    = 15
680:                 .FontName  = "Tahoma"
681:                 .FontSize  = 8
682:                 .ForeColor = RGB(90, 90, 90)
683:                 .BackStyle = 0
684:                 .Visible   = .T.
685:             ENDWITH
686:             loc_oPagina.AddObject("txt_4c_Text9", "TextBox")
687:             WITH loc_oPagina.txt_4c_Text9
688:                 .Value    = 0
689:                 .Top      = 168
690:                 .Left     = 403
691:                 .Width    = 41
692:                 .Height   = 18
693:                 .FontName = "Tahoma"
694:                 .FontSize = 8
695:                 .Visible  = .T.
696:             ENDWITH
697:             loc_oPagina.AddObject("lbl_4c_XVlDoc", "Label")
698:             WITH loc_oPagina.lbl_4c_XVlDoc
699:                 .Caption   = "x"
700:                 .Top       = 169
701:                 .Left      = 445
702:                 .Width     = 8
703:                 .Height    = 15
704:                 .FontName  = "Tahoma"
705:                 .FontSize  = 8
706:                 .ForeColor = RGB(90, 90, 90)
707:                 .BackStyle = 0
708:                 .Visible   = .T.
709:             ENDWITH
710:             loc_oPagina.AddObject("txt_4c_Text10", "TextBox")
711:             WITH loc_oPagina.txt_4c_Text10
712:                 .Value    = 0
713:                 .Top      = 168
714:                 .Left     = 452
715:                 .Width    = 41
716:                 .Height   = 18
717:                 .FontName = "Tahoma"
718:                 .FontSize = 8
719:                 .Visible  = .T.
720:             ENDWITH
721: 
722:             *-- N da Duplicata (Label7/Text7/Label8/Text8)
723:             loc_oPagina.AddObject("lbl_4c_LblNrDoc", "Label")
724:             WITH loc_oPagina.lbl_4c_LblNrDoc
725:                 .Caption   = "N" + CHR(176) + " da Duplicata"
726:                 .Top       = 153
727:                 .Left      = 513
728:                 .Width     = 76
729:                 .Height    = 15
730:                 .FontName  = "Tahoma"
731:                 .FontSize  = 8
732:                 .ForeColor = RGB(90, 90, 90)
733:                 .BackStyle = 0
734:                 .Visible   = .T.
735:             ENDWITH
736:             loc_oPagina.AddObject("txt_4c_Text7", "TextBox")
737:             WITH loc_oPagina.txt_4c_Text7
738:                 .Value    = 0
739:                 .Top      = 167
740:                 .Left     = 513
741:                 .Width    = 41
742:                 .Height   = 18
743:                 .FontName = "Tahoma"
744:                 .FontSize = 8
745:                 .Visible  = .T.
746:             ENDWITH
747:             loc_oPagina.AddObject("lbl_4c_XNrDoc", "Label")
748:             WITH loc_oPagina.lbl_4c_XNrDoc
749:                 .Caption   = "x"
750:                 .Top       = 169
751:                 .Left      = 555
752:                 .Width     = 8
753:                 .Height    = 15
754:                 .FontName  = "Tahoma"
755:                 .FontSize  = 8
756:                 .ForeColor = RGB(90, 90, 90)
757:                 .BackStyle = 0
758:                 .Visible   = .T.
759:             ENDWITH
760:             loc_oPagina.AddObject("txt_4c_Text8", "TextBox")
761:             WITH loc_oPagina.txt_4c_Text8
762:                 .Value    = 0
763:                 .Top      = 167
764:                 .Left     = 562
765:                 .Width    = 41
766:                 .Height   = 18
767:                 .FontName = "Tahoma"
768:                 .FontSize = 8
769:                 .Visible  = .T.
770:             ENDWITH
771: 
772:             *-- Vencimento (Label3/Text3/Label4/Text4)
773:             loc_oPagina.AddObject("lbl_4c_LblDtVenc", "Label")
774:             WITH loc_oPagina.lbl_4c_LblDtVenc
775:                 .Caption   = "Vencimento"
776:                 .Top       = 153
777:                 .Left      = 623
778:                 .Width     = 57
779:                 .Height    = 15
780:                 .FontName  = "Tahoma"
781:                 .FontSize  = 8
782:                 .ForeColor = RGB(90, 90, 90)
783:                 .BackStyle = 0
784:                 .Visible   = .T.
785:             ENDWITH
786:             loc_oPagina.AddObject("txt_4c_Text3", "TextBox")
787:             WITH loc_oPagina.txt_4c_Text3
788:                 .Value    = 0
789:                 .Top      = 167
790:                 .Left     = 623
791:                 .Width    = 41
792:                 .Height   = 18
793:                 .FontName = "Tahoma"
794:                 .FontSize = 8
795:                 .Visible  = .T.
796:             ENDWITH
797:             loc_oPagina.AddObject("lbl_4c_XDtVenc", "Label")
798:             WITH loc_oPagina.lbl_4c_XDtVenc
799:                 .Caption   = "x"
800:                 .Top       = 169
801:                 .Left      = 665
802:                 .Width     = 8
803:                 .Height    = 15
804:                 .FontName  = "Tahoma"
805:                 .FontSize  = 8
806:                 .ForeColor = RGB(90, 90, 90)
807:                 .BackStyle = 0
808:                 .Visible   = .T.
809:             ENDWITH
810:             loc_oPagina.AddObject("txt_4c_Text4", "TextBox")
811:             WITH loc_oPagina.txt_4c_Text4
812:                 .Value    = 0
813:                 .Top      = 167
814:                 .Left     = 672
815:                 .Width    = 41
816:                 .Height   = 18
817:                 .FontName = "Tahoma"
818:                 .FontSize = 8
819:                 .Visible  = .T.
820:             ENDWITH
821: 
822:             *------------------------------------------------------------------
823:             * SECAO SACADO - primeira linha (linha/coluna dados do cliente)
824:             * Label31 top=174+29=203 / Shape3 top=190+29=219
825:             *------------------------------------------------------------------
826:             loc_oPagina.AddObject("lbl_4c_SecSacado", "Label")
827:             WITH loc_oPagina.lbl_4c_SecSacado
828:                 .Caption   = "Sacado"
829:                 .Top       = 203
830:                 .Left      = 183
831:                 .Width     = 43
832:                 .Height    = 15
833:                 .FontName  = "Tahoma"
834:                 .FontSize  = 8
835:                 .FontBold  = .T.
836:                 .ForeColor = RGB(90, 90, 90)
837:                 .BackStyle = 0
838:                 .Visible   = .T.
839:             ENDWITH
840: 
841:             loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
842:             WITH loc_oPagina.shp_4c_Shape3
843:                 .Top           = 219
844:                 .Left          = 173
845:                 .Width         = 560
846:                 .Height        = 2
847:                 .FillColor     = RGB(150, 150, 150)
848:                 .ForeColor     = RGB(150, 150, 150)
849:                 .BackStyle     = 0
850:                 .BorderStyle   = 1
851:                 .SpecialEffect = 0
852:                 .Visible       = .T.
853:             ENDWITH
854: 
855:             *-- Razao Social (Label13/Text15/Label14/Text16) top=195+29=224 / 210+29=239
856:             loc_oPagina.AddObject("lbl_4c_LblRazCli", "Label")
857:             WITH loc_oPagina.lbl_4c_LblRazCli
858:                 .Caption   = "Raz" + CHR(227) + "o Social"
859:                 .Top       = 224
860:                 .Left      = 183
861:                 .Width     = 62
862:                 .Height    = 15
863:                 .FontName  = "Tahoma"
864:                 .FontSize  = 8
865:                 .ForeColor = RGB(90, 90, 90)
866:                 .BackStyle = 0
867:                 .Visible   = .T.
868:             ENDWITH
869:             loc_oPagina.AddObject("txt_4c_Text15", "TextBox")
870:             WITH loc_oPagina.txt_4c_Text15
871:                 .Value    = 0
872:                 .Top      = 239
873:                 .Left     = 183
874:                 .Width    = 41
875:                 .Height   = 18
876:                 .FontName = "Tahoma"
877:                 .FontSize = 8
878:                 .Visible  = .T.
879:             ENDWITH
880:             loc_oPagina.AddObject("lbl_4c_XRazCli", "Label")
881:             WITH loc_oPagina.lbl_4c_XRazCli
882:                 .Caption   = "x"
883:                 .Top       = 240
884:                 .Left      = 225
885:                 .Width     = 8
886:                 .Height    = 15
887:                 .FontName  = "Tahoma"
888:                 .FontSize  = 8
889:                 .ForeColor = RGB(90, 90, 90)
890:                 .BackStyle = 0
891:                 .Visible   = .T.
892:             ENDWITH
893:             loc_oPagina.AddObject("txt_4c_Text16", "TextBox")
894:             WITH loc_oPagina.txt_4c_Text16
895:                 .Value    = 0
896:                 .Top      = 239
897:                 .Left     = 232
898:                 .Width    = 41
899:                 .Height   = 18
900:                 .FontName = "Tahoma"
901:                 .FontSize = 8
902:                 .Visible  = .T.
903:             ENDWITH
904: 
905:             *-- C.G.C./C.P.F. (Label15/Text17/Label16/Text18)
906:             loc_oPagina.AddObject("lbl_4c_LblCgcCli", "Label")
907:             WITH loc_oPagina.lbl_4c_LblCgcCli
908:                 .Caption   = "C.G.C./C.P.F."
909:                 .Top       = 224
910:                 .Left      = 293
911:                 .Width     = 70
912:                 .Height    = 15
913:                 .FontName  = "Tahoma"
914:                 .FontSize  = 8
915:                 .ForeColor = RGB(90, 90, 90)
916:                 .BackStyle = 0
917:                 .Visible   = .T.
918:             ENDWITH
919:             loc_oPagina.AddObject("txt_4c_Text17", "TextBox")
920:             WITH loc_oPagina.txt_4c_Text17
921:                 .Value    = 0
922:                 .Top      = 239
923:                 .Left     = 293
924:                 .Width    = 41
925:                 .Height   = 18
926:                 .FontName = "Tahoma"
927:                 .FontSize = 8
928:                 .Visible  = .T.
929:             ENDWITH
930:             loc_oPagina.AddObject("lbl_4c_XCgcCli", "Label")
931:             WITH loc_oPagina.lbl_4c_XCgcCli
932:                 .Caption   = "x"
933:                 .Top       = 240
934:                 .Left      = 335
935:                 .Width     = 8
936:                 .Height    = 15
937:                 .FontName  = "Tahoma"
938:                 .FontSize  = 8
939:                 .ForeColor = RGB(90, 90, 90)
940:                 .BackStyle = 0
941:                 .Visible   = .T.
942:             ENDWITH
943:             loc_oPagina.AddObject("txt_4c_Text18", "TextBox")
944:             WITH loc_oPagina.txt_4c_Text18
945:                 .Value    = 0
946:                 .Top      = 239
947:                 .Left     = 342
948:                 .Width    = 41
949:                 .Height   = 18
950:                 .FontName = "Tahoma"
951:                 .FontSize = 8
952:                 .Visible  = .T.
953:             ENDWITH
954: 
955:             *-- Insc. Estadual (Label11/Text11/Label12/Text12)
956:             loc_oPagina.AddObject("lbl_4c_LblEstCli", "Label")
957:             WITH loc_oPagina.lbl_4c_LblEstCli
958:                 .Caption   = "Insc. Estadual"
959:                 .Top       = 224
960:                 .Left      = 403
961:                 .Width     = 70
962:                 .Height    = 15
963:                 .FontName  = "Tahoma"
964:                 .FontSize  = 8
965:                 .ForeColor = RGB(90, 90, 90)
966:                 .BackStyle = 0
967:                 .Visible   = .T.
968:             ENDWITH
969:             loc_oPagina.AddObject("txt_4c_Text11", "TextBox")
970:             WITH loc_oPagina.txt_4c_Text11
971:                 .Value    = 0
972:                 .Top      = 239
973:                 .Left     = 403
974:                 .Width    = 41
975:                 .Height   = 18
976:                 .FontName = "Tahoma"
977:                 .FontSize = 8
978:                 .Visible  = .T.
979:             ENDWITH
980:             loc_oPagina.AddObject("lbl_4c_XEstCli", "Label")
981:             WITH loc_oPagina.lbl_4c_XEstCli
982:                 .Caption   = "x"
983:                 .Top       = 240
984:                 .Left      = 445
985:                 .Width     = 8
986:                 .Height    = 15
987:                 .FontName  = "Tahoma"
988:                 .FontSize  = 8
989:                 .ForeColor = RGB(90, 90, 90)
990:                 .BackStyle = 0
991:                 .Visible   = .T.
992:             ENDWITH
993:             loc_oPagina.AddObject("txt_4c_Text12", "TextBox")
994:             WITH loc_oPagina.txt_4c_Text12
995:                 .Value    = 0
996:                 .Top      = 239
997:                 .Left     = 452
998:                 .Width    = 41
999:                 .Height   = 18
1000:                 .FontName = "Tahoma"
1001:                 .FontSize = 8
1002:                 .Visible  = .T.
1003:             ENDWITH
1004: 
1005:             *-- Valor por Extenso (Label28/Text13/Label29/Text14)
1006:             loc_oPagina.AddObject("lbl_4c_LblExtens", "Label")
1007:             WITH loc_oPagina.lbl_4c_LblExtens
1008:                 .Caption   = "Valor por Extenso"
1009:                 .Top       = 223
1010:                 .Left      = 516
1011:                 .Width     = 87
1012:                 .Height    = 15
1013:                 .FontName  = "Tahoma"
1014:                 .FontSize  = 8
1015:                 .ForeColor = RGB(90, 90, 90)
1016:                 .BackStyle = 0
1017:                 .Visible   = .T.
1018:             ENDWITH
1019:             loc_oPagina.AddObject("txt_4c_Text13", "TextBox")
1020:             WITH loc_oPagina.txt_4c_Text13
1021:                 .Value    = 0
1022:                 .Top      = 238
1023:                 .Left     = 516
1024:                 .Width    = 41
1025:                 .Height   = 18
1026:                 .FontName = "Tahoma"
1027:                 .FontSize = 8
1028:                 .Visible  = .T.
1029:             ENDWITH
1030:             loc_oPagina.AddObject("lbl_4c_XExtens", "Label")
1031:             WITH loc_oPagina.lbl_4c_XExtens
1032:                 .Caption   = "x"
1033:                 .Top       = 239
1034:                 .Left      = 558
1035:                 .Width     = 8
1036:                 .Height    = 15
1037:                 .FontName  = "Tahoma"
1038:                 .FontSize  = 8
1039:                 .ForeColor = RGB(90, 90, 90)
1040:                 .BackStyle = 0
1041:                 .Visible   = .T.
1042:             ENDWITH
1043:             loc_oPagina.AddObject("txt_4c_Text14", "TextBox")
1044:             WITH loc_oPagina.txt_4c_Text14
1045:                 .Value    = 0
1046:                 .Top      = 238
1047:                 .Left     = 565
1048:                 .Width    = 41
1049:                 .Height   = 18
1050:                 .FontName = "Tahoma"
1051:                 .FontSize = 8
1052:                 .Visible  = .T.
1053:             ENDWITH
1054: 
1055:             *-- Praca (Label30/Text32/Label37/Text33)
1056:             loc_oPagina.AddObject("lbl_4c_LblPraca", "Label")
1057:             WITH loc_oPagina.lbl_4c_LblPraca
1058:                 .Caption   = "Pra" + CHR(231) + "a"
1059:                 .Top       = 224
1060:                 .Left      = 626
1061:                 .Width     = 32
1062:                 .Height    = 15
1063:                 .FontName  = "Tahoma"
1064:                 .FontSize  = 8
1065:                 .ForeColor = RGB(90, 90, 90)
1066:                 .BackStyle = 0
1067:                 .Visible   = .T.
1068:             ENDWITH
1069:             loc_oPagina.AddObject("txt_4c_Text32", "TextBox")
1070:             WITH loc_oPagina.txt_4c_Text32
1071:                 .Value    = 0
1072:                 .Top      = 239
1073:                 .Left     = 626
1074:                 .Width    = 41
1075:                 .Height   = 18
1076:                 .FontName = "Tahoma"
1077:                 .FontSize = 8
1078:                 .Visible  = .T.
1079:             ENDWITH
1080:             loc_oPagina.AddObject("lbl_4c_XPraca", "Label")
1081:             WITH loc_oPagina.lbl_4c_XPraca
1082:                 .Caption   = "x"
1083:                 .Top       = 240
1084:                 .Left      = 668
1085:                 .Width     = 8
1086:                 .Height    = 15
1087:                 .FontName  = "Tahoma"
1088:                 .FontSize  = 8
1089:                 .ForeColor = RGB(90, 90, 90)
1090:                 .BackStyle = 0
1091:                 .Visible   = .T.
1092:             ENDWITH
1093:             loc_oPagina.AddObject("txt_4c_Text33", "TextBox")
1094:             WITH loc_oPagina.txt_4c_Text33
1095:                 .Value    = 0
1096:                 .Top      = 239
1097:                 .Left     = 675
1098:                 .Width    = 41
1099:                 .Height   = 18
1100:                 .FontName = "Tahoma"
1101:                 .FontSize = 8
1102:                 .Visible  = .T.

*-- Linhas 1108 a 1602:
1108:             *------------------------------------------------------------------
1109:             loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
1110:             WITH loc_oPagina.shp_4c_Shape2
1111:                 .Top           = 318
1112:                 .Left          = 174
1113:                 .Width         = 262
1114:                 .Height        = 2
1115:                 .FillColor     = RGB(150, 150, 150)
1116:                 .ForeColor     = RGB(150, 150, 150)
1117:                 .BackStyle     = 0
1118:                 .BorderStyle   = 1
1119:                 .SpecialEffect = 0
1120:                 .Visible       = .T.
1121:             ENDWITH
1122: 
1123:             loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
1124:             WITH loc_oPagina.shp_4c_Shape6
1125:                 .Top           = 318
1126:                 .Left          = 437
1127:                 .Width         = 217
1128:                 .Height        = 2
1129:                 .FillColor     = RGB(150, 150, 150)
1130:                 .ForeColor     = RGB(150, 150, 150)
1131:                 .BackStyle     = 0
1132:                 .BorderStyle   = 1
1133:                 .SpecialEffect = 0
1134:                 .Visible       = .T.
1135:             ENDWITH
1136: 
1137:             *-- Endereco (Label17/Text19/lbl_4c_XEnd/Text20) top=229+29=258 / 244+29=273
1138:             loc_oPagina.AddObject("lbl_4c_LblEnd", "Label")
1139:             WITH loc_oPagina.lbl_4c_LblEnd
1140:                 .Caption   = "Endere" + CHR(231) + "o"
1141:                 .Top       = 258
1142:                 .Left      = 183
1143:                 .Width     = 47
1144:                 .Height    = 15
1145:                 .FontName  = "Tahoma"
1146:                 .FontSize  = 8
1147:                 .ForeColor = RGB(90, 90, 90)
1148:                 .BackStyle = 0
1149:                 .Visible   = .T.
1150:             ENDWITH
1151:             loc_oPagina.AddObject("txt_4c_Text19", "TextBox")
1152:             WITH loc_oPagina.txt_4c_Text19
1153:                 .Value    = 0
1154:                 .Top      = 273
1155:                 .Left     = 183
1156:                 .Width    = 41
1157:                 .Height   = 18
1158:                 .FontName = "Tahoma"
1159:                 .FontSize = 8
1160:                 .Visible  = .T.
1161:             ENDWITH
1162:             loc_oPagina.AddObject("lbl_4c_XEnd", "Label")
1163:             WITH loc_oPagina.lbl_4c_XEnd
1164:                 .Caption   = "x"
1165:                 .Top       = 275
1166:                 .Left      = 225
1167:                 .Width     = 8
1168:                 .Height    = 15
1169:                 .FontName  = "Tahoma"
1170:                 .FontSize  = 8
1171:                 .ForeColor = RGB(90, 90, 90)
1172:                 .BackStyle = 0
1173:                 .Visible   = .T.
1174:             ENDWITH
1175:             loc_oPagina.AddObject("txt_4c_Text20", "TextBox")
1176:             WITH loc_oPagina.txt_4c_Text20
1177:                 .Value    = 0
1178:                 .Top      = 273
1179:                 .Left     = 232
1180:                 .Width    = 41
1181:                 .Height   = 18
1182:                 .FontName = "Tahoma"
1183:                 .FontSize = 8
1184:                 .Visible  = .T.
1185:             ENDWITH
1186: 
1187:             *-- Bairro (Label19/Text21/Label20/Text22)
1188:             loc_oPagina.AddObject("lbl_4c_LblBairro", "Label")
1189:             WITH loc_oPagina.lbl_4c_LblBairro
1190:                 .Caption   = "Bairro"
1191:                 .Top       = 258
1192:                 .Left      = 293
1193:                 .Width     = 30
1194:                 .Height    = 15
1195:                 .FontName  = "Tahoma"
1196:                 .FontSize  = 8
1197:                 .ForeColor = RGB(90, 90, 90)
1198:                 .BackStyle = 0
1199:                 .Visible   = .T.
1200:             ENDWITH
1201:             loc_oPagina.AddObject("txt_4c_Text21", "TextBox")
1202:             WITH loc_oPagina.txt_4c_Text21
1203:                 .Value    = 0
1204:                 .Top      = 273
1205:                 .Left     = 293
1206:                 .Width    = 41
1207:                 .Height   = 18
1208:                 .FontName = "Tahoma"
1209:                 .FontSize = 8
1210:                 .Visible  = .T.
1211:             ENDWITH
1212:             loc_oPagina.AddObject("lbl_4c_XBairro", "Label")
1213:             WITH loc_oPagina.lbl_4c_XBairro
1214:                 .Caption   = "x"
1215:                 .Top       = 274
1216:                 .Left      = 335
1217:                 .Width     = 8
1218:                 .Height    = 15
1219:                 .FontName  = "Tahoma"
1220:                 .FontSize  = 8
1221:                 .ForeColor = RGB(90, 90, 90)
1222:                 .BackStyle = 0
1223:                 .Visible   = .T.
1224:             ENDWITH
1225:             loc_oPagina.AddObject("txt_4c_Text22", "TextBox")
1226:             WITH loc_oPagina.txt_4c_Text22
1227:                 .Value    = 0
1228:                 .Top      = 273
1229:                 .Left     = 342
1230:                 .Width    = 41
1231:                 .Height   = 18
1232:                 .FontName = "Tahoma"
1233:                 .FontSize = 8
1234:                 .Visible  = .T.
1235:             ENDWITH
1236: 
1237:             *-- C.E.P. (Label25/Text27/Label26/Text28)
1238:             loc_oPagina.AddObject("lbl_4c_LblCep", "Label")
1239:             WITH loc_oPagina.lbl_4c_LblCep
1240:                 .Caption   = "C.E.P."
1241:                 .Top       = 259
1242:                 .Left      = 403
1243:                 .Width     = 33
1244:                 .Height    = 15
1245:                 .FontName  = "Tahoma"
1246:                 .FontSize  = 8
1247:                 .ForeColor = RGB(90, 90, 90)
1248:                 .BackStyle = 0
1249:                 .Visible   = .T.
1250:             ENDWITH
1251:             loc_oPagina.AddObject("txt_4c_Text27", "TextBox")
1252:             WITH loc_oPagina.txt_4c_Text27
1253:                 .Value    = 0
1254:                 .Top      = 273
1255:                 .Left     = 403
1256:                 .Width    = 41
1257:                 .Height   = 18
1258:                 .FontName = "Tahoma"
1259:                 .FontSize = 8
1260:                 .Visible  = .T.
1261:             ENDWITH
1262:             loc_oPagina.AddObject("lbl_4c_XCep", "Label")
1263:             WITH loc_oPagina.lbl_4c_XCep
1264:                 .Caption   = "x"
1265:                 .Top       = 274
1266:                 .Left      = 445
1267:                 .Width     = 8
1268:                 .Height    = 15
1269:                 .FontName  = "Tahoma"
1270:                 .FontSize  = 8
1271:                 .ForeColor = RGB(90, 90, 90)
1272:                 .BackStyle = 0
1273:                 .Visible   = .T.
1274:             ENDWITH
1275:             loc_oPagina.AddObject("txt_4c_Text28", "TextBox")
1276:             WITH loc_oPagina.txt_4c_Text28
1277:                 .Value    = 0
1278:                 .Top      = 273
1279:                 .Left     = 452
1280:                 .Width    = 41
1281:                 .Height   = 18
1282:                 .FontName = "Tahoma"
1283:                 .FontSize = 8
1284:                 .Visible  = .T.
1285:             ENDWITH
1286: 
1287:             *-- Cidade (Label21/Text23/Label22/Text24)
1288:             loc_oPagina.AddObject("lbl_4c_LblCidade", "Label")
1289:             WITH loc_oPagina.lbl_4c_LblCidade
1290:                 .Caption   = "Cidade"
1291:                 .Top       = 259
1292:                 .Left      = 516
1293:                 .Width     = 35
1294:                 .Height    = 15
1295:                 .FontName  = "Tahoma"
1296:                 .FontSize  = 8
1297:                 .ForeColor = RGB(90, 90, 90)
1298:                 .BackStyle = 0
1299:                 .Visible   = .T.
1300:             ENDWITH
1301:             loc_oPagina.AddObject("txt_4c_Text23", "TextBox")
1302:             WITH loc_oPagina.txt_4c_Text23
1303:                 .Value    = 0
1304:                 .Top      = 273
1305:                 .Left     = 516
1306:                 .Width    = 41
1307:                 .Height   = 18
1308:                 .FontName = "Tahoma"
1309:                 .FontSize = 8
1310:                 .Visible  = .T.
1311:             ENDWITH
1312:             loc_oPagina.AddObject("lbl_4c_XCidade", "Label")
1313:             WITH loc_oPagina.lbl_4c_XCidade
1314:                 .Caption   = "x"
1315:                 .Top       = 274
1316:                 .Left      = 558
1317:                 .Width     = 8
1318:                 .Height    = 15
1319:                 .FontName  = "Tahoma"
1320:                 .FontSize  = 8
1321:                 .ForeColor = RGB(90, 90, 90)
1322:                 .BackStyle = 0
1323:                 .Visible   = .T.
1324:             ENDWITH
1325:             loc_oPagina.AddObject("txt_4c_Text24", "TextBox")
1326:             WITH loc_oPagina.txt_4c_Text24
1327:                 .Value    = 0
1328:                 .Top      = 273
1329:                 .Left     = 565
1330:                 .Width    = 41
1331:                 .Height   = 18
1332:                 .FontName = "Tahoma"
1333:                 .FontSize = 8
1334:                 .Visible  = .T.
1335:             ENDWITH
1336: 
1337:             *-- U.F. (Label23/Text25/Label24/Text26)
1338:             loc_oPagina.AddObject("lbl_4c_LblUF", "Label")
1339:             WITH loc_oPagina.lbl_4c_LblUF
1340:                 .Caption   = "U.F."
1341:                 .Top       = 259
1342:                 .Left      = 626
1343:                 .Width     = 23
1344:                 .Height    = 15
1345:                 .FontName  = "Tahoma"
1346:                 .FontSize  = 8
1347:                 .ForeColor = RGB(90, 90, 90)
1348:                 .BackStyle = 0
1349:                 .Visible   = .T.
1350:             ENDWITH
1351:             loc_oPagina.AddObject("txt_4c_Text25", "TextBox")
1352:             WITH loc_oPagina.txt_4c_Text25
1353:                 .Value    = 0
1354:                 .Top      = 273
1355:                 .Left     = 626
1356:                 .Width    = 41
1357:                 .Height   = 18
1358:                 .FontName = "Tahoma"
1359:                 .FontSize = 8
1360:                 .Visible  = .T.
1361:             ENDWITH
1362:             loc_oPagina.AddObject("lbl_4c_XUF", "Label")
1363:             WITH loc_oPagina.lbl_4c_XUF
1364:                 .Caption   = "x"
1365:                 .Top       = 274
1366:                 .Left      = 668
1367:                 .Width     = 8
1368:                 .Height    = 15
1369:                 .FontName  = "Tahoma"
1370:                 .FontSize  = 8
1371:                 .ForeColor = RGB(90, 90, 90)
1372:                 .BackStyle = 0
1373:                 .Visible   = .T.
1374:             ENDWITH
1375:             loc_oPagina.AddObject("txt_4c_Text26", "TextBox")
1376:             WITH loc_oPagina.txt_4c_Text26
1377:                 .Value    = 0
1378:                 .Top      = 273
1379:                 .Left     = 675
1380:                 .Width    = 41
1381:                 .Height   = 18
1382:                 .FontName = "Tahoma"
1383:                 .FontSize = 8
1384:                 .Visible  = .T.
1385:             ENDWITH
1386: 
1387:             *------------------------------------------------------------------
1388:             * SECAO OBSERVACAO
1389:             * Label44 (Observacao) top=273+29=302
1390:             *------------------------------------------------------------------
1391:             loc_oPagina.AddObject("lbl_4c_SecObs", "Label")
1392:             WITH loc_oPagina.lbl_4c_SecObs
1393:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1394:                 .Top       = 302
1395:                 .Left      = 184
1396:                 .Width     = 69
1397:                 .Height    = 15
1398:                 .FontName  = "Tahoma"
1399:                 .FontSize  = 8
1400:                 .FontBold  = .T.
1401:                 .ForeColor = RGB(90, 90, 90)
1402:                 .BackStyle = 0
1403:                 .Visible   = .T.
1404:             ENDWITH
1405: 
1406:             *-- Obs linha/coluna (Text36/lbl_4c_XObs/Text37) top=292+29=321 / 304+29=333
1407:             loc_oPagina.AddObject("txt_4c_Text36", "TextBox")
1408:             WITH loc_oPagina.txt_4c_Text36
1409:                 .Value    = 0
1410:                 .Top      = 333
1411:                 .Left     = 184
1412:                 .Width    = 41
1413:                 .Height   = 18
1414:                 .FontName = "Tahoma"
1415:                 .FontSize = 8
1416:                 .Visible  = .T.
1417:             ENDWITH
1418:             loc_oPagina.AddObject("lbl_4c_XObs", "Label")
1419:             WITH loc_oPagina.lbl_4c_XObs
1420:                 .Caption   = "x"
1421:                 .Top       = 335
1422:                 .Left      = 227
1423:                 .Width     = 8
1424:                 .Height    = 15
1425:                 .FontName  = "Tahoma"
1426:                 .FontSize  = 8
1427:                 .ForeColor = RGB(90, 90, 90)
1428:                 .BackStyle = 0
1429:                 .Visible   = .T.
1430:             ENDWITH
1431:             loc_oPagina.AddObject("txt_4c_Text37", "TextBox")
1432:             WITH loc_oPagina.txt_4c_Text37
1433:                 .Value    = 0
1434:                 .Top      = 333
1435:                 .Left     = 233
1436:                 .Width    = 41
1437:                 .Height   = 18
1438:                 .FontName = "Tahoma"
1439:                 .FontSize = 8
1440:                 .Visible  = .T.
1441:             ENDWITH
1442: 
1443:             *-- N Colunas/N Linhas Obs (Label42/Text38/Label43/Text39) top=292+29=321 / 304+29=333
1444:             loc_oPagina.AddObject("lbl_4c_LblNcol", "Label")
1445:             WITH loc_oPagina.lbl_4c_LblNcol
1446:                 .Caption   = "N" + CHR(176) + " Colunas"
1447:                 .Top       = 321
1448:                 .Left      = 298
1449:                 .Width     = 55
1450:                 .Height    = 15
1451:                 .FontName  = "Tahoma"
1452:                 .FontSize  = 8
1453:                 .ForeColor = RGB(90, 90, 90)
1454:                 .BackStyle = 0
1455:                 .Visible   = .T.
1456:             ENDWITH
1457:             loc_oPagina.AddObject("txt_4c_Text38", "TextBox")
1458:             WITH loc_oPagina.txt_4c_Text38
1459:                 .Value    = 0
1460:                 .Top      = 333
1461:                 .Left     = 298
1462:                 .Width    = 41
1463:                 .Height   = 18
1464:                 .FontName = "Tahoma"
1465:                 .FontSize = 8
1466:                 .Visible  = .T.
1467:             ENDWITH
1468:             loc_oPagina.AddObject("lbl_4c_LblNlin", "Label")
1469:             WITH loc_oPagina.lbl_4c_LblNlin
1470:                 .Caption   = "N" + CHR(176) + " Linhas"
1471:                 .Top       = 321
1472:                 .Left      = 369
1473:                 .Width     = 47
1474:                 .Height    = 15
1475:                 .FontName  = "Tahoma"
1476:                 .FontSize  = 8
1477:                 .ForeColor = RGB(90, 90, 90)
1478:                 .BackStyle = 0
1479:                 .Visible   = .T.
1480:             ENDWITH
1481:             loc_oPagina.AddObject("txt_4c_Text39", "TextBox")
1482:             WITH loc_oPagina.txt_4c_Text39
1483:                 .Value    = 0
1484:                 .Top      = 333
1485:                 .Left     = 369
1486:                 .Width    = 41
1487:                 .Height   = 18
1488:                 .FontName = "Tahoma"
1489:                 .FontSize = 8
1490:                 .Visible  = .T.
1491:             ENDWITH
1492: 
1493:             *-- Valor da NF linha/coluna (Label38/Text34/Label39/Text35) top=291+29=320 / 306+29=335
1494:             loc_oPagina.AddObject("lbl_4c_LblVlNF", "Label")
1495:             WITH loc_oPagina.lbl_4c_LblVlNF
1496:                 .Caption   = "Valor da NF"
1497:                 .Top       = 320
1498:                 .Left      = 443
1499:                 .Width     = 57
1500:                 .Height    = 15
1501:                 .FontName  = "Tahoma"
1502:                 .FontSize  = 8
1503:                 .ForeColor = RGB(90, 90, 90)
1504:                 .BackStyle = 0
1505:                 .Visible   = .T.
1506:             ENDWITH
1507:             loc_oPagina.AddObject("txt_4c_Text34", "TextBox")
1508:             WITH loc_oPagina.txt_4c_Text34
1509:                 .Value    = 0
1510:                 .Top      = 335
1511:                 .Left     = 443
1512:                 .Width    = 41
1513:                 .Height   = 18
1514:                 .FontName = "Tahoma"
1515:                 .FontSize = 8
1516:                 .Visible  = .T.
1517:             ENDWITH
1518:             loc_oPagina.AddObject("lbl_4c_XVlNF", "Label")
1519:             WITH loc_oPagina.lbl_4c_XVlNF
1520:                 .Caption   = "x"
1521:                 .Top       = 336
1522:                 .Left      = 485
1523:                 .Width     = 8
1524:                 .Height    = 15
1525:                 .FontName  = "Tahoma"
1526:                 .FontSize  = 8
1527:                 .ForeColor = RGB(90, 90, 90)
1528:                 .BackStyle = 0
1529:                 .Visible   = .T.
1530:             ENDWITH
1531:             loc_oPagina.AddObject("txt_4c_Text35", "TextBox")
1532:             WITH loc_oPagina.txt_4c_Text35
1533:                 .Value    = 0
1534:                 .Top      = 335
1535:                 .Left     = 492
1536:                 .Width    = 41
1537:                 .Height   = 18
1538:                 .FontName = "Tahoma"
1539:                 .FontSize = 8
1540:                 .Visible  = .T.
1541:             ENDWITH
1542: 
1543:             *-- Codigo linha/coluna (Label45/Text41/Label46/Text42) top=291+29=320 / 306+29=335
1544:             loc_oPagina.AddObject("lbl_4c_LblCod", "Label")
1545:             WITH loc_oPagina.lbl_4c_LblCod
1546:                 .Caption   = "C" + CHR(243) + "digo"
1547:                 .Top       = 320
1548:                 .Left      = 556
1549:                 .Width     = 35
1550:                 .Height    = 15
1551:                 .FontName  = "Tahoma"
1552:                 .FontSize  = 8
1553:                 .ForeColor = RGB(90, 90, 90)
1554:                 .BackStyle = 0
1555:                 .Visible   = .T.
1556:             ENDWITH
1557:             loc_oPagina.AddObject("txt_4c_Text41", "TextBox")
1558:             WITH loc_oPagina.txt_4c_Text41
1559:                 .Value    = 0
1560:                 .Top      = 335
1561:                 .Left     = 556
1562:                 .Width    = 41
1563:                 .Height   = 18
1564:                 .FontName = "Tahoma"
1565:                 .FontSize = 8
1566:                 .Visible  = .T.
1567:             ENDWITH
1568:             loc_oPagina.AddObject("lbl_4c_XCod", "Label")
1569:             WITH loc_oPagina.lbl_4c_XCod
1570:                 .Caption   = "x"
1571:                 .Top       = 336
1572:                 .Left      = 598
1573:                 .Width     = 8
1574:                 .Height    = 15
1575:                 .FontName  = "Tahoma"
1576:                 .FontSize  = 8
1577:                 .ForeColor = RGB(90, 90, 90)
1578:                 .BackStyle = 0
1579:                 .Visible   = .T.
1580:             ENDWITH
1581:             loc_oPagina.AddObject("txt_4c_Text42", "TextBox")
1582:             WITH loc_oPagina.txt_4c_Text42
1583:                 .Value    = 0
1584:                 .Top      = 335
1585:                 .Left     = 605
1586:                 .Width    = 41
1587:                 .Height   = 18
1588:                 .FontName = "Tahoma"
1589:                 .FontSize = 8
1590:                 .Visible  = .T.
1591:             ENDWITH
1592: 
1593:             *-- Shape4: separador top=354+29=383
1594:             loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
1595:             WITH loc_oPagina.shp_4c_Shape4
1596:                 .Top           = 383
1597:                 .Left          = 173
1598:                 .Width         = 263
1599:                 .Height        = 2
1600:                 .FillColor     = RGB(150, 150, 150)
1601:                 .ForeColor     = RGB(150, 150, 150)
1602:                 .BackStyle     = 0

*-- Linhas 1609 a 1755:
1609:             * SECAO IMPRESSORA / FONTE
1610:             * Label35 top=338+29=367
1611:             *------------------------------------------------------------------
1612:             loc_oPagina.AddObject("lbl_4c_SecImpr", "Label")
1613:             WITH loc_oPagina.lbl_4c_SecImpr
1614:                 .Caption   = "Impressora / Fonte"
1615:                 .Top       = 367
1616:                 .Left      = 183
1617:                 .Width     = 112
1618:                 .Height    = 15
1619:                 .FontName  = "Tahoma"
1620:                 .FontSize  = 8
1621:                 .FontBold  = .T.
1622:                 .ForeColor = RGB(90, 90, 90)
1623:                 .BackStyle = 0
1624:                 .Visible   = .T.
1625:             ENDWITH
1626: 
1627:             *-- Nome da Impressora (Label32/Text29) top=359+29=388 / 373+29=402
1628:             loc_oPagina.AddObject("lbl_4c_LblNomeImp", "Label")
1629:             WITH loc_oPagina.lbl_4c_LblNomeImp
1630:                 .Caption   = "Nome da Impressora"
1631:                 .Top       = 388
1632:                 .Left      = 183
1633:                 .Width     = 101
1634:                 .Height    = 15
1635:                 .FontName  = "Tahoma"
1636:                 .FontSize  = 8
1637:                 .ForeColor = RGB(90, 90, 90)
1638:                 .BackStyle = 0
1639:                 .Visible   = .T.
1640:             ENDWITH
1641:             loc_oPagina.AddObject("txt_4c_Text29", "TextBox")
1642:             WITH loc_oPagina.txt_4c_Text29
1643:                 .Value    = ""
1644:                 .Top      = 402
1645:                 .Left     = 183
1646:                 .Width    = 240
1647:                 .Height   = 18
1648:                 .FontName = "Tahoma"
1649:                 .FontSize = 8
1650:                 .Visible  = .T.
1651:             ENDWITH
1652: 
1653:             *-- Fonte Padrao (Label33/Text30) top=392+29=421 / 406+29=435
1654:             loc_oPagina.AddObject("lbl_4c_LblFonte", "Label")
1655:             WITH loc_oPagina.lbl_4c_LblFonte
1656:                 .Caption   = "Fonte Padr" + CHR(227) + "o"
1657:                 .Top       = 421
1658:                 .Left      = 183
1659:                 .Width     = 67
1660:                 .Height    = 15
1661:                 .FontName  = "Tahoma"
1662:                 .FontSize  = 8
1663:                 .ForeColor = RGB(90, 90, 90)
1664:                 .BackStyle = 0
1665:                 .Visible   = .T.
1666:             ENDWITH
1667:             loc_oPagina.AddObject("txt_4c_Text30", "TextBox")
1668:             WITH loc_oPagina.txt_4c_Text30
1669:                 .Value    = ""
1670:                 .Top      = 435
1671:                 .Left     = 183
1672:                 .Width    = 192
1673:                 .Height   = 18
1674:                 .FontName = "Tahoma"
1675:                 .FontSize = 8
1676:                 .Visible  = .T.
1677:             ENDWITH
1678: 
1679:             *-- Tamanho da Fonte (Label34/Text31) top=392+29=421 / 406+29=435
1680:             loc_oPagina.AddObject("lbl_4c_LblTamFonte", "Label")
1681:             WITH loc_oPagina.lbl_4c_LblTamFonte
1682:                 .Caption   = "Tamanho"
1683:                 .Top       = 421
1684:                 .Left      = 384
1685:                 .Width     = 46
1686:                 .Height    = 15
1687:                 .FontName  = "Tahoma"
1688:                 .FontSize  = 8
1689:                 .ForeColor = RGB(90, 90, 90)
1690:                 .BackStyle = 0
1691:                 .Visible   = .T.
1692:             ENDWITH
1693:             loc_oPagina.AddObject("txt_4c_Text31", "TextBox")
1694:             WITH loc_oPagina.txt_4c_Text31
1695:                 .Value    = 0
1696:                 .Top      = 435
1697:                 .Left     = 384
1698:                 .Width    = 41
1699:                 .Height   = 18
1700:                 .FontName = "Tahoma"
1701:                 .FontSize = 8
1702:                 .Visible  = .T.
1703:             ENDWITH
1704: 
1705:             *-- Tamanho da Folha (Label47/Text40) top=424+29=453 / 439+29=468
1706:             loc_oPagina.AddObject("lbl_4c_LblTamFolha", "Label")
1707:             WITH loc_oPagina.lbl_4c_LblTamFolha
1708:                 .Caption   = "Tamanho da Folha"
1709:                 .Top       = 453
1710:                 .Left      = 183
1711:                 .Width     = 90
1712:                 .Height    = 15
1713:                 .FontName  = "Tahoma"
1714:                 .FontSize  = 8
1715:                 .ForeColor = RGB(90, 90, 90)
1716:                 .BackStyle = 0
1717:                 .Visible   = .T.
1718:             ENDWITH
1719:             loc_oPagina.AddObject("txt_4c_Text40", "TextBox")
1720:             WITH loc_oPagina.txt_4c_Text40
1721:                 .Value    = ""
1722:                 .Top      = 468
1723:                 .Left     = 183
1724:                 .Width    = 240
1725:                 .Height   = 18
1726:                 .FontName = "Tahoma"
1727:                 .FontSize = 8
1728:                 .Visible  = .T.
1729:             ENDWITH
1730: 
1731:             *------------------------------------------------------------------
1732:             * BOTOES DE ACAO (Confirmar / Cancelar) - Grupo_Salva no legado
1733:             *-- Top=33 = 4 (original) + 29 (compensacao PageFrame)
1734:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
1735:             WITH loc_oPagina.cnt_4c_BotoesAcao
1736:                 .Top         = 33
1737:                 .Left        = 842
1738:                 .Width       = 160
1739:                 .Height      = 85
1740:                 .BackStyle   = 0
1741:                 .BorderWidth = 0
1742:                 .Visible     = .T.
1743: 
1744:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
1745:                 WITH .cmd_4c_Confirmar
1746:                     .Caption         = "Confirmar"
1747:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1748:                     .PicturePosition = 13
1749:                     .Top             = 5
1750:                     .Left            = 5
1751:                     .Width           = 75
1752:                     .Height          = 75
1753:                     .FontName        = "Tahoma"
1754:                     .FontSize        = 8
1755:                     .FontBold        = .T.

*-- Linhas 1762 a 1776:
1762:                     .AutoSize        = .F.
1763:                 ENDWITH
1764: 
1765:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
1766:                 WITH .cmd_4c_Cancelar
1767:                     .Caption         = "Encerrar"
1768:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1769:                     .PicturePosition = 13
1770:                     .Top             = 5
1771:                     .Left            = 80
1772:                     .Width           = 75
1773:                     .Height          = 75
1774:                     .FontName        = "Tahoma"
1775:                     .FontSize        = 8
1776:                     .FontBold        = .T.

*-- Linhas 1786 a 1795:
1786:             ENDWITH
1787: 
1788:             *-- BINDEVENTs da Page2
1789:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1790:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1791: 
1792:             THIS.TornarControlesVisiveis(loc_oPagina)
1793: 
1794:         CATCH TO loException
1795:             MsgErro("Erro ao configurar Page2:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 1815 a 1823:
1815:                     loc_oGrid.RecordSource              = "cursor_4c_Dados"
1816:                     loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.series"
1817:                     loc_oGrid.Column1.Width             = 100
1818:                     loc_oGrid.Column1.Header1.Caption   = "S" + CHR(233) + "rie"
1819:                     THIS.FormatarGridLista(loc_oGrid)
1820:                     loc_lResultado = .T.
1821:                 ENDIF
1822:             CATCH TO loException
1823:                 MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 1863 a 1872:
1863:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
1864:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
1865:         ELSE
1866:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1867:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1868:             ENDIF
1869:         ENDIF
1870:     ENDPROC
1871: 
1872:     *==========================================================================

*-- Linhas 1890 a 1899:
1890:             THIS.this_cModoAtual = "VISUALIZAR"
1891:             THIS.BOParaForm()
1892:             THIS.pgf_4c_Paginas.ActivePage = 2
1893:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1894:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1895:             ENDIF
1896:         ENDIF
1897:     ENDPROC
1898: 
1899:     *==========================================================================

*-- Linhas 1921 a 1930:
1921:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Text5", 5)
1922:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Text5.SetFocus
1923:             ELSE
1924:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1925:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1926:                 ENDIF
1927:             ENDIF
1928:         ENDIF
1929:     ENDPROC
1930: 

*-- Linhas 1969 a 1978:
1969:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value = ""
1970:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
1971:         ELSE
1972:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1973:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1974:             ENDIF
1975:         ENDIF
1976:     ENDPROC
1977: 
1978:     *==========================================================================

*-- Linhas 1998 a 2006:
1998:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 1
1999:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource            = "cursor_4c_Dados"
2000:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.series"
2001:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "S" + CHR(233) + "rie"
2002:                 THIS.FormatarGridLista(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista)
2003:                 THIS.this_cModoAtual = "LISTA"
2004:                 THIS.pgf_4c_Paginas.Visible = .T.
2005:                 THIS.pgf_4c_Paginas.ActivePage = 1
2006:             ENDIF

*-- Linhas 2052 a 2072:
2052: 
2053:         *-- Desabilitar controles durante a copia (como no legado)
2054:         loc_oPg1.cnt_4c_Botoes.Enabled = .F.
2055:         loc_oPg1.grd_4c_Lista.Enabled  = .F.
2056:         loc_oPg1.cnt_4c_Saida.Enabled  = .F.
2057:         loc_oPg1.cmd_4c_Copia.Enabled  = .F.
2058: 
2059:         *-- Preencher e exibir painel
2060:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value  = loc_cSeries
2061:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value  = ""
2062:         loc_oPg1.cnt_4c_CopiaFl.Visible                    = .T.
2063:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2064:     ENDPROC
2065: 
2066:     *==========================================================================
2067:     * BtnOKCopiarClick - Executa copia da serie
2068:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.OK.Click
2069:     *==========================================================================
2070:     PROCEDURE BtnOKCopiarClick()
2071:         LOCAL loc_oPg1, loc_cSerieOrigem, loc_cSerieDestino
2072:         LOCAL loc_cSQLCheck, loc_nCheck, loc_lResultado

*-- Linhas 2120 a 2140:
2120:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2121: 
2122:         loc_oPg1.cnt_4c_Botoes.Enabled = .T.
2123:         loc_oPg1.grd_4c_Lista.Enabled  = .T.
2124:         loc_oPg1.cnt_4c_Saida.Enabled  = .T.
2125:         loc_oPg1.cmd_4c_Copia.Enabled  = .T.
2126:         loc_oPg1.cnt_4c_CopiaFl.Visible = .F.
2127:         loc_oPg1.grd_4c_Lista.SetFocus
2128:     ENDPROC
2129: 
2130:     *==========================================================================
2131:     * ValidarSerieDestino - Abre lookup de series ao sair do campo destino
2132:     * Baseado no legado: SIGCDDUP.Pagina.Lista.cntcopia.nomedest.Valid
2133:     * Tabela SigCdSer (series disponiveis)
2134:     *==========================================================================
2135:     PROCEDURE ValidarSerieDestino
2136:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2137:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2138:             RETURN
2139:         ENDIF
2140:         LOCAL loc_oPg1, loc_cSerieDest, loc_oBusca

*-- Linhas 2812 a 2837:
2812:             RETURN
2813:         ENDIF
2814: 
2815:         loc_oBtnConf = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
2816:         loc_oBtnCanc = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar
2817: 
2818:         DO CASE
2819:         CASE THIS.this_cModoAtual = "VISUALIZAR"
2820:             loc_oBtnConf.Caption = "OK"
2821:             loc_oBtnConf.Enabled = .T.
2822:             loc_oBtnCanc.Enabled = .T.
2823:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2824:             loc_oBtnConf.Caption = "Confirmar"
2825:             loc_oBtnConf.Enabled = .T.
2826:             loc_oBtnCanc.Enabled = .T.
2827:         CASE THIS.this_cModoAtual = "BUSCAR"
2828:             loc_oBtnConf.Caption = "Buscar"
2829:             loc_oBtnConf.Enabled = .T.
2830:             loc_oBtnCanc.Enabled = .T.
2831:         OTHERWISE
2832:             loc_oBtnConf.Caption = "Confirmar"
2833:             loc_oBtnConf.Enabled = .T.
2834:             loc_oBtnCanc.Enabled = .T.
2835:         ENDCASE
2836:     ENDPROC
2837: 


### BO (C:\4c\projeto\app\classes\DupBO.prg):
*==============================================================================
* DupBO.prg - Business Object para Configuracao de Duplicatas
* Tabela: SigCnFDU
* PK: series
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS DupBO AS BusinessBase

    *-- Chave primaria
    this_cSeries = ""

    *-- Cabecalho - posicoes de impressao da Nota Fiscal
    this_nNlnNotas   = 0
    this_nNclNotas   = 0
    this_nNlnDtVencs = 0
    this_nNclDtVencs = 0
    this_nNlnDtDocs  = 0
    this_nNclDtDocs  = 0
    this_nNlnNrDocs  = 0
    this_nNclNrDocs  = 0
    this_nNlnVlDocs  = 0
    this_nNclVlDocs  = 0

    *-- Sacado - posicoes de impressao do cliente/cobranca
    this_nNlnRazClis = 0
    this_nNclRazClis = 0
    this_nNlnCgcClis = 0
    this_nNclCgcClis = 0
    this_nNlnEndCobs = 0
    this_nNclEndCobs = 0
    this_nNlnBaiCobs = 0
    this_nNclBaiCobs = 0
    this_nNlnCidCobs = 0
    this_nNclCidCobs = 0
    this_nNlnEstCobs = 0
    this_nNclEstCobs = 0
    this_nNlnCepCobs = 0
    this_nNclCepCobs = 0
    this_nNlnEstClis = 0
    this_nNclEstClis = 0
    this_nNlnExtens  = 0
    this_nNclExtens  = 0
    this_nNlPracas   = 0
    this_nNcPracas   = 0

    *-- Observacao - posicoes e dimensoes
    this_nNlObs     = 0
    this_nNcObs     = 0
    this_nTamColObs = 0
    this_nTamLinObs = 0

    *-- Codigo - posicao de impressao
    this_nNlnCods   = 0
    this_nNclCods   = 0

    *-- Valor NF - posicao de impressao
    this_nLNota     = 0
    this_nCNota     = 0

    *-- Impressora e fonte
    this_cNomeImps  = ""
    this_cFontePdrs = ""
    this_nTamFontes = 0
    this_cTamFolhas = ""

    *-- Auditoria
    this_dDatas    = {}
    this_cHoras    = ""
    this_cUsuarios = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCnFDU"
        THIS.this_cCampoChave = "series"
        RETURN .T.
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSeries
    ENDFUNC

    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT series FROM SigCnFDU"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE series LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY series"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cSeries)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigCnFDU WHERE series = " + EscaparSQL(par_cSeries)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSeries      = ALLTRIM(TratarNulo(series,      "C"))
            THIS.this_nNlnNotas    = TratarNulo(nlnnotas,    "N")
            THIS.this_nNclNotas    = TratarNulo(nclnotas,    "N")
            THIS.this_nNlnDtVencs  = TratarNulo(nlndtvencs,  "N")
            THIS.this_nNclDtVencs  = TratarNulo(ncldtvencs,  "N")
            THIS.this_nNlnDtDocs   = TratarNulo(nlndtdocs,   "N")
            THIS.this_nNclDtDocs   = TratarNulo(ncldtdocs,   "N")
            THIS.this_nNlnNrDocs   = TratarNulo(nlnnrdocs,   "N")
            THIS.this_nNclNrDocs   = TratarNulo(nclnrdocs,   "N")
            THIS.this_nNlnVlDocs   = TratarNulo(nlnvldocs,   "N")
            THIS.this_nNclVlDocs   = TratarNulo(nclvldocs,   "N")
            THIS.this_nNlnRazClis  = TratarNulo(nlnrazclis,  "N")
            THIS.this_nNclRazClis  = TratarNulo(nclrazclis,  "N")
            THIS.this_nNlnCgcClis  = TratarNulo(nlncgcclis,  "N")
            THIS.this_nNclCgcClis  = TratarNulo(nclcgcclis,  "N")
            THIS.this_nNlnEndCobs  = TratarNulo(nlnendcobs,  "N")
            THIS.this_nNclEndCobs  = TratarNulo(nclendcobs,  "N")
            THIS.this_nNlnBaiCobs  = TratarNulo(nlnbaicobs,  "N")
            THIS.this_nNclBaiCobs  = TratarNulo(nclbaicobs,  "N")
            THIS.this_nNlnCidCobs  = TratarNulo(nlncidcobs,  "N")
            THIS.this_nNclCidCobs  = TratarNulo(nclcidcobs,  "N")
            THIS.this_nNlnEstCobs  = TratarNulo(nlnestcobs,  "N")
            THIS.this_nNclEstCobs  = TratarNulo(nclestcobs,  "N")
            THIS.this_nNlnCepCobs  = TratarNulo(nlncepcobs,  "N")
            THIS.this_nNclCepCobs  = TratarNulo(nclcepcobs,  "N")
            THIS.this_nNlnEstClis  = TratarNulo(nlnestclis,  "N")
            THIS.this_nNclEstClis  = TratarNulo(nclestclis,  "N")
            THIS.this_nNlnExtens   = TratarNulo(nlnextens,   "N")
            THIS.this_nNclExtens   = TratarNulo(nclextens,   "N")
            THIS.this_nNlPracas    = TratarNulo(nlpracas,    "N")
            THIS.this_nNcPracas    = TratarNulo(ncpracas,    "N")
            THIS.this_nNlObs       = TratarNulo(nlobs,       "N")
            THIS.this_nNcObs       = TratarNulo(ncobs,       "N")
            THIS.this_nTamColObs   = TratarNulo(tamcolobs,   "N")
            THIS.this_nTamLinObs   = TratarNulo(tamlinobs,   "N")
            THIS.this_nNlnCods     = TratarNulo(nlncods,     "N")
            THIS.this_nNclCods     = TratarNulo(nclcods,     "N")
            THIS.this_nLNota       = TratarNulo(lnota,       "N")
            THIS.this_nCNota       = TratarNulo(cnota,       "N")
            THIS.this_cNomeImps    = ALLTRIM(TratarNulo(cnomeimps,    "C"))
            THIS.this_cFontePdrs   = ALLTRIM(TratarNulo(cfontepdrs,   "C"))
            THIS.this_nTamFontes   = TratarNulo(ntamfontes,   "N")
            THIS.this_cTamFolhas   = ALLTRIM(TratarNulo(ctamfolhas,   "C"))
            THIS.this_cHoras       = ALLTRIM(TratarNulo(choras,       "C"))
            THIS.this_cUsuarios    = ALLTRIM(TratarNulo(cusuarios,    "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCnFDU (" + ;
                "series, cemps, cnomeimps, cfontepdrs, ntamfontes, ctamfolhas," + ;
                " cusuarios, ddatas, choras, clocals," + ;
                " nlnnotas, nclnotas, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlnrazclis, nclrazclis," + ;
                " nlncgcclis, nclcgcclis, nlnendcobs, nclendcobs," + ;
                " nlnbaicobs, nclbaicobs, nlncidcobs, nclcidcobs," + ;
                " nlnestcobs, nclestcobs, nlncepcobs, nclcepcobs," + ;
                " nlnestclis, nclestclis, nlnextens, nclextens," + ;
                " nlpracas, ncpracas, nlobs, ncobs," + ;
                " tamcolobs, tamlinobs, nlncods, nclcods, lnota, cnota" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cSeries) + ", " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cNomeImps,  128)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamFontes) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTamFolhas,  80)) + ", " + ;
                EscaparSQL(LEFT(gc_4c_UsuarioLogado,   20)) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(TIME()) + ", " + ;
                EscaparSQL("") + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnNotas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclNotas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnDtVencs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclDtVencs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnDtDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclDtDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnNrDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclNrDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnVlDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclVlDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnRazClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclRazClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCgcClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCgcClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEndCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEndCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclBaiCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCidCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCidCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEstCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEstCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCepCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCepCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEstClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEstClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnExtens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclExtens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlPracas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcPracas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlObs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcObs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamColObs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamLinObs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCods)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCods)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLNota)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nCNota)      + ;
                ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Insert")
                TABLEREVERT(.T., "cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCnFDU SET " + ;
                "cnomeimps  = " + EscaparSQL(LEFT(THIS.this_cNomeImps,  128)) + ", " + ;
                "cfontepdrs = " + EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + ", " + ;
                "ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamFontes) + ", " + ;
                "ctamfolhas = " + EscaparSQL(LEFT(THIS.this_cTamFolhas,  80)) + ", " + ;
                "cusuarios  = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado,   20)) + ", " + ;
                "ddatas = GETDATE(), " + ;
                "choras = " + EscaparSQL(TIME()) + ", " + ;
                "nlnnotas   = " + FormatarNumeroSQL(THIS.this_nNlnNotas)   + ", " + ;
                "nclnotas   = " + FormatarNumeroSQL(THIS.this_nNclNotas)   + ", " + ;
                "nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + ", " + ;
                "ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + ", " + ;
                "nlndtdocs  = " + FormatarNumeroSQL(THIS.this_nNlnDtDocs)  + ", " + ;
                "ncldtdocs  = " + FormatarNumeroSQL(THIS.this_nNclDtDocs)  + ", " + ;
                "nlnnrdocs  = " + FormatarNumeroSQL(THIS.this_nNlnNrDocs)  + ", " + ;
                "nclnrdocs  = " + FormatarNumeroSQL(THIS.this_nNclNrDocs)  + ", " + ;
                "nlnvldocs  = " + FormatarNumeroSQL(THIS.this_nNlnVlDocs)  + ", " + ;
                "nclvldocs  = " + FormatarNumeroSQL(THIS.this_nNclVlDocs)  + ", " + ;
                "nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + ", " + ;
                "nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclRazClis) + ", " + ;
                "nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + ", " + ;
                "nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + ", " + ;
                "nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + ", " + ;
                "nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + ", " + ;
                "nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + ", " + ;
                "nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + ", " + ;
                "nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + ", " + ;
                "nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + ", " + ;
                "nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + ", " + ;
                "nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + ", " + ;
                "nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + ", " + ;
                "nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + ", " + ;
                "nlnestclis = " + FormatarNumeroSQL(THIS.this_nNlnEstClis) + ", " + ;
                "nclestclis = " + FormatarNumeroSQL(THIS.this_nNclEstClis) + ", " + ;
                "nlnextens  = " + FormatarNumeroSQL(THIS.this_nNlnExtens)  + ", " + ;
                "nclextens  = " + FormatarNumeroSQL(THIS.this_nNclExtens)  + ", " + ;
                "nlpracas   = " + FormatarNumeroSQL(THIS.this_nNlPracas)   + ", " + ;
                "ncpracas   = " + FormatarNumeroSQL(THIS.this_nNcPracas)   + ", " + ;
                "nlobs      = " + FormatarNumeroSQL(THIS.this_nNlObs)      + ", " + ;
                "ncobs      = " + FormatarNumeroSQL(THIS.this_nNcObs)      + ", " + ;
                "tamcolobs  = " + FormatarNumeroSQL(THIS.this_nTamColObs)  + ", " + ;
                "tamlinobs  = " + FormatarNumeroSQL(THIS.this_nTamLinObs)  + ", " + ;
                "nlncods    = " + FormatarNumeroSQL(THIS.this_nNlnCods)    + ", " + ;
                "nclcods    = " + FormatarNumeroSQL(THIS.this_nNclCods)    + ", " + ;
                "lnota      = " + FormatarNumeroSQL(THIS.this_nLNota)      + ", " + ;
                "cnota      = " + FormatarNumeroSQL(THIS.this_nCNota)      + ;
                " WHERE series = " + EscaparSQL(THIS.this_cSeries)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Update")
                TABLEREVERT(.T., "cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCnFDU WHERE series = " + EscaparSQL(THIS.this_cSeries)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Delete")
                TABLEREVERT(.T., "cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

