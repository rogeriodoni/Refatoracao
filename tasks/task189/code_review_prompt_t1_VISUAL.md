# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (16)
- [ALINHAMENTO] Botao 'cmd_4c_SairDisp' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [ALINHAMENTO] Botao 'cmd_4c_OkEstq' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [ALINHAMENTO] Botao 'cmd_4c_OkLinhas' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [ALINHAMENTO] Botao 'cmd_4c_SairReq' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 194: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 214: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 234: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 272: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 291: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 310: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 787: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 999: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1264: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1411: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2978 linhas total):

*-- Linhas 60 a 70:
60:         THIS.this_nNumerodaop = IIF(VARTYPE(par_nNumerodaop) = "N", par_nNumerodaop, 0)
61:         THIS.this_oParentForm = IIF(VARTYPE(par_oParentForm) = "O", par_oParentForm, .NULL.)
62:         IF THIS.this_lReserva
63:             THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
64:         ELSE
65:             THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
66:         ENDIF
67:         RETURN DODEFAULT()
68:     ENDPROC
69: 
70:     *==========================================================================

*-- Linhas 134 a 177:
134:     PROTECTED PROCEDURE ConfigurarCabecalho()
135:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
136:         WITH THIS.cnt_4c_Cabecalho
137:             .Top        = 0
138:             .Left       = 0
139:             .Width      = 1004
140:             .Height     = 80
141:             .BackStyle  = 1
142:             .BackColor  = RGB(100,100,100)
143:             .BorderWidth = 0
144:             .AddObject("lbl_4c_Sombra", "Label")
145:             WITH .lbl_4c_Sombra
146:                 .AutoSize  = .F.
147:                 .FontBold  = .T.
148:                 .FontName  = "Tahoma"
149:                 .FontSize  = 18
150:                 .WordWrap  = .T.
151:                 .Alignment = 0
152:                 .BackStyle = 0
153:                 .Caption   = THISFORM.Caption
154:                 .Height    = 40
155:                 .Left      = 10
156:                 .Top       = 18
157:                 .Width     = THIS.Width
158:                 .ForeColor = RGB(0,0,0)
159:             ENDWITH
160:             .AddObject("lbl_4c_Titulo", "Label")
161:             WITH .lbl_4c_Titulo
162:                 .AutoSize  = .F.
163:                 .FontBold  = .T.
164:                 .FontName  = "Tahoma"
165:                 .FontSize  = 18
166:                 .WordWrap  = .T.
167:                 .Alignment = 0
168:                 .BackStyle = 0
169:                 .Caption   = THISFORM.Caption
170:                 .Height    = 46
171:                 .Left      = 10
172:                 .Top       = 17
173:                 .Width     = THIS.Width
174:                 .ForeColor = RGB(255,255,255)
175:             ENDWITH
176:         ENDWITH
177:     ENDPROC

*-- Linhas 183 a 318:
183:         LOCAL loc_lcIcones
184:         loc_lcIcones = gc_4c_CaminhoIcones
185: 
186:         THIS.AddObject("cmd_4c_Requisicoes", "CommandButton")
187:         WITH THIS.cmd_4c_Requisicoes
188:             .Top             = 3
189:             .Left            = 472
190:             .Height          = 75
191:             .Width           = 75
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .FontName        = "Comic Sans MS"
195:             .FontSize        = 8
196:             .WordWrap        = .T.
197:             .Caption         = "\<Requisi" + CHR(231) + CHR(245) + "es"
198:             .Picture         = loc_lcIcones + "geral_datas_60.jpg"
199:             .DisabledPicture = loc_lcIcones + "geral_datas_60.jpg"
200:             .Themes          = .T.
201:             .ForeColor       = RGB(90,90,90)
202:             .BackColor       = RGB(255,255,255)
203:             .Enabled         = .F.
204:         ENDWITH
205: 
206:         THIS.AddObject("cmd_4c_Estoques", "CommandButton")
207:         WITH THIS.cmd_4c_Estoques
208:             .Top             = 3
209:             .Left            = 547
210:             .Height          = 75
211:             .Width           = 75
212:             .FontBold        = .T.
213:             .FontItalic      = .T.
214:             .FontName        = "Comic Sans MS"
215:             .FontSize        = 8
216:             .WordWrap        = .T.
217:             .Caption         = "\<Estoques"
218:             .Picture         = loc_lcIcones + "geral_marcar_60.jpg"
219:             .DisabledPicture = loc_lcIcones + "geral_marcar_60.jpg"
220:             .Themes          = .T.
221:             .ForeColor       = RGB(90,90,90)
222:             .BackColor       = RGB(255,255,255)
223:             .Enabled         = .F.
224:         ENDWITH
225: 
226:         THIS.AddObject("cmd_4c_Disponiveis", "CommandButton")
227:         WITH THIS.cmd_4c_Disponiveis
228:             .Top             = 3
229:             .Left            = 622
230:             .Height          = 75
231:             .Width           = 75
232:             .FontBold        = .T.
233:             .FontItalic      = .T.
234:             .FontName        = "Comic Sans MS"
235:             .FontSize        = 8
236:             .WordWrap        = .T.
237:             .Caption         = "\<Dispon" + CHR(237) + "veis"
238:             .Picture         = loc_lcIcones + "geral_palete_60.jpg"
239:             .DisabledPicture = loc_lcIcones + "geral_palete_60.jpg"
240:             .Themes          = .T.
241:             .ForeColor       = RGB(90,90,90)
242:             .BackColor       = RGB(255,255,255)
243:         ENDWITH
244: 
245:         THIS.AddObject("cmd_4c_LinhasTot", "CommandButton")
246:         WITH THIS.cmd_4c_LinhasTot
247:             .Top             = 3
248:             .Left            = 697
249:             .Height          = 75
250:             .Width           = 75
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .FontName        = "Comic Sans MS"
254:             .FontSize        = 8
255:             .WordWrap        = .T.
256:             .Caption         = "\<Total/Linhas"
257:             .Picture         = loc_lcIcones + "geral_grafico_pizza_60.jpg"
258:             .DisabledPicture = loc_lcIcones + "geral_grafico_pizza_60.jpg"
259:             .Themes          = .T.
260:             .ForeColor       = RGB(90,90,90)
261:             .BackColor       = RGB(255,255,255)
262:         ENDWITH
263: 
264:         THIS.AddObject("cmd_4c_Relatorio", "CommandButton")
265:         WITH THIS.cmd_4c_Relatorio
266:             .Top             = 3
267:             .Left            = 772
268:             .Height          = 75
269:             .Width           = 75
270:             .FontBold        = .T.
271:             .FontItalic      = .T.
272:             .FontName        = "Comic Sans MS"
273:             .FontSize        = 8
274:             .WordWrap        = .T.
275:             .Caption         = "\<Relat" + CHR(243) + "rio"
276:             .Picture         = loc_lcIcones + "geral_impressora_60.jpg"
277:             .DisabledPicture = loc_lcIcones + "geral_impressora_60.jpg"
278:             .Themes          = .T.
279:             .ForeColor       = RGB(90,90,90)
280:             .BackColor       = RGB(255,255,255)
281:         ENDWITH
282: 
283:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
284:         WITH THIS.cmd_4c_Processar
285:             .Top             = 3
286:             .Left            = 847
287:             .Height          = 75
288:             .Width           = 75
289:             .FontBold        = .T.
290:             .FontItalic      = .T.
291:             .FontName        = "Comic Sans MS"
292:             .FontSize        = 8
293:             .WordWrap        = .T.
294:             .Caption         = "\<Processar"
295:             .Picture         = loc_lcIcones + "geral_processar_60.jpg"
296:             .DisabledPicture = loc_lcIcones + "geral_processar_60.jpg"
297:             .Themes          = .T.
298:             .ForeColor       = RGB(90,90,90)
299:             .BackColor       = RGB(255,255,255)
300:         ENDWITH
301: 
302:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
303:         WITH THIS.cmd_4c_Cancelar
304:             .Top             = 3
305:             .Left            = 922
306:             .Height          = 75
307:             .Width           = 75
308:             .FontBold        = .T.
309:             .FontItalic      = .T.
310:             .FontName        = "Comic Sans MS"
311:             .FontSize        = 8
312:             .WordWrap        = .T.
313:             .Caption         = "Encerrar"
314:             .Cancel          = .T.
315:             .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"
316:             .DisabledPicture = loc_lcIcones + "cadastro_sair_60.jpg"
317:             .Themes          = .T.
318:             .ForeColor       = RGB(90,90,90)

*-- Linhas 326 a 335:
326:     PROTECTED PROCEDURE ConfigurarGradeItens()
327:         THIS.AddObject("grd_4c_Itens", "Grid")
328:         WITH THIS.grd_4c_Itens
329:             .Top               = 125
330:             .Left              = 11
331:             .Height            = 224
332:             .Width             = 708
333:             .ColumnCount       = 9
334:             .FontSize          = 8
335:             .AllowHeaderSizing = .F.

*-- Linhas 345 a 353:
345:                 .Movable            = .F.
346:                 .Resizable          = .F.
347:                 .ReadOnly           = .T.
348:                 .Header1.Caption    = "Produto"
349:                 .Header1.FontName   = "Verdana"
350:                 .Header1.FontSize   = 8
351:                 .Header1.Alignment  = 2
352:                 .Header1.ForeColor  = RGB(36,84,155)
353:                 .Text1.FontSize     = 8

*-- Linhas 362 a 370:
362:                 .Movable            = .F.
363:                 .Resizable          = .F.
364:                 .ReadOnly           = .T.
365:                 .Header1.Caption    = "Cor"
366:                 .Header1.FontName   = "Verdana"
367:                 .Header1.FontSize   = 8
368:                 .Header1.Alignment  = 2
369:                 .Header1.ForeColor  = RGB(36,84,155)
370:                 .Text1.FontSize     = 8

*-- Linhas 379 a 387:
379:                 .Movable            = .F.
380:                 .Resizable          = .F.
381:                 .ReadOnly           = .T.
382:                 .Header1.Caption    = "Movimenta" + CHR(231) + CHR(227) + "o"
383:                 .Header1.FontName   = "Verdana"
384:                 .Header1.FontSize   = 8
385:                 .Header1.Alignment  = 2
386:                 .Header1.ForeColor  = RGB(36,84,155)
387:                 .Text1.FontSize     = 8

*-- Linhas 396 a 404:
396:                 .Movable            = .F.
397:                 .Resizable          = .F.
398:                 .ReadOnly           = .T.
399:                 .Header1.Caption    = "C" + CHR(243) + "digo"
400:                 .Header1.FontName   = "Verdana"
401:                 .Header1.FontSize   = 8
402:                 .Header1.Alignment  = 2
403:                 .Header1.ForeColor  = RGB(36,84,155)
404:                 .Text1.FontSize     = 8

*-- Linhas 413 a 421:
413:                 .Movable            = .F.
414:                 .Resizable          = .F.
415:                 .ReadOnly           = .T.
416:                 .Header1.Caption    = "Quantidade"
417:                 .Header1.FontName   = "Verdana"
418:                 .Header1.FontSize   = 8
419:                 .Header1.Alignment  = 2
420:                 .Header1.ForeColor  = RGB(36,84,155)
421:                 .Text1.FontBold     = .T.

*-- Linhas 432 a 440:
432:                 .Resizable          = .F.
433:                 .ReadOnly           = .F.
434:                 .BackColor          = RGB(221,252,255)
435:                 .Header1.Caption    = "Produzir"
436:                 .Header1.FontName   = "Verdana"
437:                 .Header1.FontSize   = 8
438:                 .Header1.Alignment  = 2
439:                 .Header1.ForeColor  = RGB(36,84,155)
440:                 .Text1.FontBold     = .T.

*-- Linhas 451 a 459:
451:                 .Resizable          = .F.
452:                 .ReadOnly           = .T.
453:                 .BackColor          = RGB(255,253,179)
454:                 .Header1.Caption    = "Estoque"
455:                 .Header1.FontName   = "Verdana"
456:                 .Header1.FontSize   = 8
457:                 .Header1.Alignment  = 2
458:                 .Header1.ForeColor  = RGB(36,84,155)
459:                 .Text1.FontBold     = .T.

*-- Linhas 470 a 478:
470:                 .Resizable          = .F.
471:                 .ReadOnly           = .T.
472:                 .Alignment          = 2
473:                 .Header1.Caption    = "Obs"
474:                 .Header1.FontName   = "Verdana"
475:                 .Header1.FontSize   = 8
476:                 .Header1.Alignment  = 2
477:                 .Header1.ForeColor  = RGB(36,84,155)
478:                 .Text1.FontBold     = .T.

*-- Linhas 489 a 497:
489:                 .Movable            = .F.
490:                 .Resizable          = .F.
491:                 .ReadOnly           = .T.
492:                 .Header1.Caption    = "Tam"
493:                 .Header1.FontName   = "Verdana"
494:                 .Header1.FontSize   = 8
495:                 .Header1.Alignment  = 2
496:                 .Header1.ForeColor  = RGB(36,84,155)
497:                 .Text1.FontSize     = 8

*-- Linhas 509 a 544:
509:     PROTECTED PROCEDURE ConfigurarContainerInfo()
510:         THIS.AddObject("cnt_4c_Info", "Container")
511:         WITH THIS.cnt_4c_Info
512:             .Top         = 373
513:             .Left        = 12
514:             .Width       = 708
515:             .Height      = 205
516:             .SpecialEffect = 0
517:             .BackStyle   = 1
518:             .BackColor   = RGB(255,255,255)
519:             .BorderWidth = 0
520: 
521:             .AddObject("lbl_4c_TituloInfo", "Label")
522:             WITH .lbl_4c_TituloInfo
523:                 .AutoSize  = .T.
524:                 .FontBold  = .T.
525:                 .FontName  = "Tahoma"
526:                 .FontSize  = 9
527:                 .BackStyle = 0
528:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
529:                 .Height    = 16
530:                 .Left      = 6
531:                 .Top       = 5
532:                 .Width     = 118
533:                 .ForeColor = RGB(90,90,90)
534:             ENDWITH
535: 
536:             .AddObject("grd_4c_DispInfo", "Grid")
537:             WITH .grd_4c_DispInfo
538:                 .Top               = 24
539:                 .Left              = 6
540:                 .Height            = 148
541:                 .Width             = 444
542:                 .ColumnCount       = 6
543:                 .FontSize          = 8
544:                 .AllowHeaderSizing = .F.

*-- Linhas 555 a 563:
555:                     .Movable            = .F.
556:                     .Resizable          = .F.
557:                     .ReadOnly           = .T.
558:                     .Header1.Caption    = "Grupo"
559:                     .Header1.FontName   = "Verdana"
560:                     .Header1.FontSize   = 8
561:                     .Header1.Alignment  = 2
562:                     .Header1.ForeColor  = RGB(36,84,155)
563:                     .Text1.FontSize     = 8

*-- Linhas 572 a 580:
572:                     .Movable            = .F.
573:                     .Resizable          = .F.
574:                     .ReadOnly           = .T.
575:                     .Header1.Caption    = "Conta"
576:                     .Header1.FontName   = "Verdana"
577:                     .Header1.FontSize   = 8
578:                     .Header1.Alignment  = 2
579:                     .Header1.ForeColor  = RGB(36,84,155)
580:                     .Text1.FontSize     = 8

*-- Linhas 589 a 597:
589:                     .Movable            = .F.
590:                     .Resizable          = .F.
591:                     .ReadOnly           = .T.
592:                     .Header1.Caption    = "Atual"
593:                     .Header1.FontName   = "Verdana"
594:                     .Header1.FontSize   = 8
595:                     .Header1.Alignment  = 2
596:                     .Header1.ForeColor  = RGB(36,84,155)
597:                     .Text1.FontSize     = 8

*-- Linhas 606 a 614:
606:                     .Movable            = .F.
607:                     .Resizable          = .F.
608:                     .ReadOnly           = .T.
609:                     .Header1.Caption    = "Utilizado"
610:                     .Header1.FontName   = "Verdana"
611:                     .Header1.FontSize   = 8
612:                     .Header1.Alignment  = 2
613:                     .Header1.ForeColor  = RGB(36,84,155)
614:                     .Text1.FontSize     = 8

*-- Linhas 624 a 632:
624:                     .Resizable          = .F.
625:                     .ReadOnly           = .F.
626:                     .BackColor          = RGB(255,253,179)
627:                     .Header1.Caption    = "Dispon" + CHR(237) + "vel"
628:                     .Header1.FontName   = "Verdana"
629:                     .Header1.FontSize   = 8
630:                     .Header1.Alignment  = 2
631:                     .Header1.ForeColor  = RGB(36,84,155)
632:                     .Text1.FontSize     = 8

*-- Linhas 642 a 650:
642:                     .Movable            = .F.
643:                     .Resizable          = .F.
644:                     .ReadOnly           = .T.
645:                     .Header1.Caption    = "Emp"
646:                     .Header1.FontName   = "Verdana"
647:                     .Header1.FontSize   = 8
648:                     .Header1.Alignment  = 2
649:                     .Header1.ForeColor  = RGB(36,84,155)
650:                     .Text1.FontSize     = 8

*-- Linhas 658 a 746:
658:             .AddObject("txt_4c_DGrupoInfo", "TextBox")
659:             WITH .txt_4c_DGrupoInfo
660:                 .Height        = 23
661:                 .Left          = 454
662:                 .SpecialEffect = 1
663:                 .Top           = 106
664:                 .Width         = 247
665:                 .ReadOnly      = .T.
666:                 .Value         = ""
667:             ENDWITH
668: 
669:             .AddObject("txt_4c_DContaInfo", "TextBox")
670:             WITH .txt_4c_DContaInfo
671:                 .Height        = 23
672:                 .Left          = 454
673:                 .SpecialEffect = 1
674:                 .Top           = 147
675:                 .Width         = 247
676:                 .ReadOnly      = .T.
677:                 .Value         = ""
678:             ENDWITH
679: 
680:             .AddObject("txt_4c_TotQtdInfo", "TextBox")
681:             WITH .txt_4c_TotQtdInfo
682:                 .Height        = 23
683:                 .InputMask     = "99,999.99"
684:                 .Left          = 188
685:                 .SpecialEffect = 1
686:                 .Top           = 173
687:                 .Width         = 80
688:                 .ReadOnly      = .T.
689:                 .Value         = 0
690:             ENDWITH
691: 
692:             .AddObject("txt_4c_TotEstInfo", "TextBox")
693:             WITH .txt_4c_TotEstInfo
694:                 .Height        = 23
695:                 .InputMask     = "99,999.99"
696:                 .Left          = 269
697:                 .SpecialEffect = 1
698:                 .Top           = 173
699:                 .Width         = 80
700:                 .ReadOnly      = .T.
701:                 .Value         = 0
702:             ENDWITH
703: 
704:             .AddObject("txt_4c_TotPrzInfo", "TextBox")
705:             WITH .txt_4c_TotPrzInfo
706:                 .Height        = 23
707:                 .InputMask     = "99,999.99"
708:                 .Left          = 350
709:                 .SpecialEffect = 1
710:                 .Top           = 173
711:                 .Width         = 80
712:                 .ReadOnly      = .T.
713:                 .Value         = 0
714:             ENDWITH
715: 
716:             .AddObject("lbl_4c_GrupoInfo", "Label")
717:             WITH .lbl_4c_GrupoInfo
718:                 .AutoSize  = .T.
719:                 .FontBold  = .T.
720:                 .FontName  = "Tahoma"
721:                 .FontSize  = 8
722:                 .BackStyle = 0
723:                 .Caption   = "Grupo"
724:                 .Height    = 15
725:                 .Left      = 454
726:                 .Top       = 90
727:                 .Width     = 36
728:                 .ForeColor = RGB(90,90,90)
729:             ENDWITH
730: 
731:             .AddObject("lbl_4c_ContaInfo", "Label")
732:             WITH .lbl_4c_ContaInfo
733:                 .AutoSize  = .T.
734:                 .FontBold  = .T.
735:                 .FontName  = "Tahoma"
736:                 .FontSize  = 8
737:                 .BackStyle = 0
738:                 .Caption   = "Conta"
739:                 .Height    = 15
740:                 .Left      = 454
741:                 .Top       = 131
742:                 .Width     = 35
743:                 .ForeColor = RGB(90,90,90)
744:             ENDWITH
745:         ENDWITH
746:     ENDPROC

*-- Linhas 753 a 806:
753:         loc_lcIcones = gc_4c_CaminhoIcones
754:         THIS.AddObject("cnt_4c_Disponivel", "Container")
755:         WITH THIS.cnt_4c_Disponivel
756:             .Top         = 125
757:             .Left        = 12
758:             .Width       = 708
759:             .Height      = 465
760:             .SpecialEffect = 0
761:             .Visible     = .F.
762:             .BackStyle   = 1
763:             .BackColor   = RGB(255,255,255)
764:             .BorderWidth = 0
765: 
766:             .AddObject("lbl_4c_TituloDisp", "Label")
767:             WITH .lbl_4c_TituloDisp
768:                 .AutoSize  = .T.
769:                 .FontBold  = .T.
770:                 .FontName  = "Tahoma"
771:                 .FontSize  = 10
772:                 .BackStyle = 0
773:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
774:                 .Height    = 18
775:                 .Left      = 610
776:                 .Top       = 10
777:                 .Width     = 123
778:                 .ForeColor = RGB(90,90,90)
779:             ENDWITH
780: 
781:             .AddObject("cmd_4c_SairDisp", "CommandButton")
782:             WITH .cmd_4c_SairDisp
783:                 .Top             = 10
784:                 .Left            = 620
785:                 .Height          = 75
786:                 .Width           = 75
787:                 .FontName        = "Comic Sans MS"
788:                 .FontSize        = 8
789:                 .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"
790:                 .DisabledPicture = loc_lcIcones + "cadastro_sair_60.jpg"
791:                 .Cancel          = .T.
792:                 .Caption         = "Sair"
793:                 .ForeColor       = RGB(90,90,90)
794:                 .BackColor       = RGB(255,255,255)
795:                 .Themes          = .T.
796:             ENDWITH
797: 
798:             .AddObject("grd_4c_DispProd", "Grid")
799:             WITH .grd_4c_DispProd
800:                 .Top               = 32
801:                 .Left              = 169
802:                 .Height            = 388
803:                 .Width             = 370
804:                 .ColumnCount       = 5
805:                 .FontSize          = 8
806:                 .AllowHeaderSizing = .F.

*-- Linhas 816 a 824:
816:                     .Movable            = .F.
817:                     .Resizable          = .F.
818:                     .ReadOnly           = .T.
819:                     .Header1.Caption    = "Produto"
820:                     .Header1.FontName   = "Verdana"
821:                     .Header1.FontSize   = 8
822:                     .Header1.Alignment  = 2
823:                     .Header1.ForeColor  = RGB(36,84,155)
824:                     .Text1.FontSize     = 8

*-- Linhas 833 a 841:
833:                     .Movable            = .F.
834:                     .Resizable          = .F.
835:                     .ReadOnly           = .T.
836:                     .Header1.Caption    = "Cor"
837:                     .Header1.FontName   = "Verdana"
838:                     .Header1.FontSize   = 8
839:                     .Header1.Alignment  = 2
840:                     .Header1.ForeColor  = RGB(36,84,155)
841:                     .Text1.FontBold     = .T.

*-- Linhas 851 a 859:
851:                     .Movable            = .F.
852:                     .Resizable          = .F.
853:                     .ReadOnly           = .T.
854:                     .Header1.Caption    = "Tam"
855:                     .Header1.FontName   = "Verdana"
856:                     .Header1.FontSize   = 8
857:                     .Header1.Alignment  = 2
858:                     .Header1.ForeColor  = RGB(36,84,155)
859:                     .Text1.FontBold     = .T.

*-- Linhas 869 a 877:
869:                     .Movable            = .F.
870:                     .Resizable          = .F.
871:                     .ReadOnly           = .T.
872:                     .Header1.Caption    = "Disponivel"
873:                     .Header1.FontName   = "Verdana"
874:                     .Header1.FontSize   = 8
875:                     .Header1.Alignment  = 2
876:                     .Header1.ForeColor  = RGB(36,84,155)
877:                     .Text1.FontSize     = 8

*-- Linhas 886 a 894:
886:                     .Movable            = .F.
887:                     .Resizable          = .F.
888:                     .ReadOnly           = .F.
889:                     .Header1.Caption    = "Utilizar"
890:                     .Header1.FontName   = "Verdana"
891:                     .Header1.FontSize   = 8
892:                     .Header1.Alignment  = 2
893:                     .Header1.ForeColor  = RGB(36,84,155)
894:                     .Text1.FontBold     = .T.

*-- Linhas 903 a 955:
903:                 ENDWITH
904:             ENDWITH
905: 
906:             .AddObject("lbl_4c_ProduzirDisp", "Label")
907:             WITH .lbl_4c_ProduzirDisp
908:                 .AutoSize  = .T.
909:                 .FontName  = "Tahoma"
910:                 .FontSize  = 8
911:                 .BackStyle = 0
912:                 .Caption   = "Qtde " + CHR(224) + " Produzir :"
913:                 .Height    = 15
914:                 .Left      = 168
915:                 .Top       = 432
916:                 .Width     = 84
917:                 .ForeColor = RGB(90,90,90)
918:             ENDWITH
919: 
920:             .AddObject("lbl_4c_UtilizarDisp", "Label")
921:             WITH .lbl_4c_UtilizarDisp
922:                 .AutoSize  = .T.
923:                 .FontName  = "Tahoma"
924:                 .FontSize  = 8
925:                 .BackStyle = 0
926:                 .Caption   = "Qtde " + CHR(224) + " Utilizar :"
927:                 .Height    = 17
928:                 .Left      = 365
929:                 .Top       = 431
930:                 .Width     = 109
931:                 .ForeColor = RGB(90,90,90)
932:             ENDWITH
933: 
934:             .AddObject("txt_4c_PedidaDisp", "TextBox")
935:             WITH .txt_4c_PedidaDisp
936:                 .Height        = 23
937:                 .Left          = 268
938:                 .SpecialEffect = 1
939:                 .Top           = 428
940:                 .Width         = 80
941:                 .ReadOnly      = .T.
942:                 .Value         = 0
943:             ENDWITH
944: 
945:             .AddObject("txt_4c_SelecDisp", "TextBox")
946:             WITH .txt_4c_SelecDisp
947:                 .Height        = 23
948:                 .Left          = 458
949:                 .SpecialEffect = 1
950:                 .Top           = 428
951:                 .Width         = 80
952:                 .ReadOnly      = .T.
953:                 .Value         = 0
954:             ENDWITH
955:         ENDWITH

*-- Linhas 963 a 1019:
963:         loc_lcIcones = gc_4c_CaminhoIcones
964:         THIS.AddObject("cnt_4c_Estoques", "Container")
965:         WITH THIS.cnt_4c_Estoques
966:             .Top         = 125
967:             .Left        = 12
968:             .Width       = 708
969:             .Height      = 465
970:             .SpecialEffect = 0
971:             .Visible     = .F.
972:             .BackStyle   = 1
973:             .BackColor   = RGB(255,255,255)
974:             .BorderWidth = 0
975: 
976:             .AddObject("lbl_4c_TituloEstq", "Label")
977:             WITH .lbl_4c_TituloEstq
978:                 .AutoSize  = .T.
979:                 .FontBold  = .T.
980:                 .FontName  = "Tahoma"
981:                 .FontSize  = 10
982:                 .BackStyle = 0
983:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
984:                 .Height    = 18
985:                 .Left      = 284
986:                 .Top       = 10
987:                 .Width     = 123
988:                 .ForeColor = RGB(90,90,90)
989:             ENDWITH
990: 
991:             .AddObject("cmd_4c_OkEstq", "CommandButton")
992:             WITH .cmd_4c_OkEstq
993:                 .Top             = 10
994:                 .Left            = 620
995:                 .Height          = 75
996:                 .Width           = 75
997:                 .FontBold        = .T.
998:                 .FontItalic      = .T.
999:                 .FontName        = "Comic Sans MS"
1000:                 .FontSize        = 8
1001:                 .WordWrap        = .T.
1002:                 .Picture         = loc_lcIcones + "cadastro_salvar_60.jpg"
1003:                 .DisabledPicture = loc_lcIcones + "cadastro_salvar_60.jpg"
1004:                 .Cancel          = .T.
1005:                 .Caption         = "OK"
1006:                 .ForeColor       = RGB(90,90,90)
1007:                 .BackColor       = RGB(255,255,255)
1008:                 .Themes          = .T.
1009:             ENDWITH
1010: 
1011:             .AddObject("grd_4c_DispEstq", "Grid")
1012:             WITH .grd_4c_DispEstq
1013:                 .Top               = 32
1014:                 .Left              = 141
1015:                 .Height            = 372
1016:                 .Width             = 425
1017:                 .ColumnCount       = 5
1018:                 .FontSize          = 8
1019:                 .AllowHeaderSizing = .F.

*-- Linhas 1029 a 1037:
1029:                     .Movable            = .F.
1030:                     .Resizable          = .F.
1031:                     .ReadOnly           = .T.
1032:                     .Header1.Caption    = "Grupo"
1033:                     .Header1.FontName   = "Verdana"
1034:                     .Header1.FontSize   = 8
1035:                     .Header1.Alignment  = 2
1036:                     .Header1.ForeColor  = RGB(36,84,155)
1037:                     .Text1.FontSize     = 8

*-- Linhas 1047 a 1055:
1047:                     .Movable            = .F.
1048:                     .Resizable          = .F.
1049:                     .ReadOnly           = .T.
1050:                     .Header1.Caption    = "Conta"
1051:                     .Header1.FontName   = "Verdana"
1052:                     .Header1.FontSize   = 8
1053:                     .Header1.Alignment  = 2
1054:                     .Header1.ForeColor  = RGB(36,84,155)
1055:                     .Text1.FontSize     = 8

*-- Linhas 1065 a 1073:
1065:                     .Movable            = .F.
1066:                     .Resizable          = .F.
1067:                     .ReadOnly           = .T.
1068:                     .Header1.Caption    = "Prioridade"
1069:                     .Header1.FontName   = "Verdana"
1070:                     .Header1.FontSize   = 8
1071:                     .Header1.Alignment  = 2
1072:                     .Header1.ForeColor  = RGB(36,84,155)
1073:                     .Text1.FontSize     = 8

*-- Linhas 1083 a 1091:
1083:                     .Movable            = .F.
1084:                     .Resizable          = .F.
1085:                     .ReadOnly           = .T.
1086:                     .Header1.Caption    = "Dispon" + CHR(237) + "vel"
1087:                     .Header1.FontName   = "Verdana"
1088:                     .Header1.FontSize   = 8
1089:                     .Header1.Alignment  = 2
1090:                     .Header1.ForeColor  = RGB(36,84,155)
1091:                     .Text1.FontSize     = 8

*-- Linhas 1101 a 1109:
1101:                     .Movable            = .F.
1102:                     .Resizable          = .F.
1103:                     .ReadOnly           = .F.
1104:                     .Header1.Caption    = "Utilizar"
1105:                     .Header1.FontName   = "Verdana"
1106:                     .Header1.FontSize   = 8
1107:                     .Header1.Alignment  = 2
1108:                     .Header1.ForeColor  = RGB(36,84,155)
1109:                     .Text1.FontBold     = .T.

*-- Linhas 1118 a 1220:
1118:                 ENDWITH
1119:             ENDWITH
1120: 
1121:             .AddObject("lbl_4c_ProduzirEstq", "Label")
1122:             WITH .lbl_4c_ProduzirEstq
1123:                 .AutoSize  = .T.
1124:                 .FontName  = "Tahoma"
1125:                 .FontSize  = 8
1126:                 .BackStyle = 0
1127:                 .Caption   = "Produzir :"
1128:                 .Height    = 15
1129:                 .Left      = 428
1130:                 .Top       = 413
1131:                 .Width     = 48
1132:                 .ForeColor = RGB(90,90,90)
1133:             ENDWITH
1134: 
1135:             .AddObject("lbl_4c_UtilizarEstq", "Label")
1136:             WITH .lbl_4c_UtilizarEstq
1137:                 .AutoSize  = .T.
1138:                 .FontName  = "Tahoma"
1139:                 .FontSize  = 8
1140:                 .BackStyle = 0
1141:                 .Caption   = "Utilizar :"
1142:                 .Height    = 15
1143:                 .Left      = 435
1144:                 .Top       = 438
1145:                 .Width     = 41
1146:                 .ForeColor = RGB(90,90,90)
1147:             ENDWITH
1148: 
1149:             .AddObject("lbl_4c_GrupoEstq", "Label")
1150:             WITH .lbl_4c_GrupoEstq
1151:                 .AutoSize  = .T.
1152:                 .FontName  = "Tahoma"
1153:                 .FontSize  = 8
1154:                 .BackStyle = 0
1155:                 .Caption   = "Grupo :"
1156:                 .Height    = 15
1157:                 .Left      = 93
1158:                 .Top       = 413
1159:                 .Width     = 38
1160:                 .ForeColor = RGB(90,90,90)
1161:             ENDWITH
1162: 
1163:             .AddObject("lbl_4c_ContaEstq", "Label")
1164:             WITH .lbl_4c_ContaEstq
1165:                 .AutoSize  = .T.
1166:                 .FontName  = "Tahoma"
1167:                 .FontSize  = 8
1168:                 .BackStyle = 0
1169:                 .Caption   = "Conta :"
1170:                 .Height    = 15
1171:                 .Left      = 93
1172:                 .Top       = 438
1173:                 .Width     = 38
1174:                 .ForeColor = RGB(90,90,90)
1175:             ENDWITH
1176: 
1177:             .AddObject("txt_4c_DGrupoEstq", "TextBox")
1178:             WITH .txt_4c_DGrupoEstq
1179:                 .Height        = 23
1180:                 .Left          = 141
1181:                 .SpecialEffect = 1
1182:                 .Top           = 409
1183:                 .Width         = 277
1184:                 .ReadOnly      = .T.
1185:                 .Value         = ""
1186:             ENDWITH
1187: 
1188:             .AddObject("txt_4c_DContaEstq", "TextBox")
1189:             WITH .txt_4c_DContaEstq
1190:                 .Height        = 23
1191:                 .Left          = 141
1192:                 .SpecialEffect = 1
1193:                 .Top           = 434
1194:                 .Width         = 277
1195:                 .ReadOnly      = .T.
1196:                 .Value         = ""
1197:             ENDWITH
1198: 
1199:             .AddObject("txt_4c_PedidaEstq", "TextBox")
1200:             WITH .txt_4c_PedidaEstq
1201:                 .Height        = 23
1202:                 .Left          = 486
1203:                 .SpecialEffect = 1
1204:                 .Top           = 409
1205:                 .Width         = 80
1206:                 .ReadOnly      = .T.
1207:                 .Value         = 0
1208:             ENDWITH
1209: 
1210:             .AddObject("txt_4c_SelecEstq", "TextBox")
1211:             WITH .txt_4c_SelecEstq
1212:                 .Height        = 23
1213:                 .Left          = 486
1214:                 .SpecialEffect = 1
1215:                 .Top           = 434
1216:                 .Width         = 80
1217:                 .ReadOnly      = .T.
1218:                 .Value         = 0
1219:             ENDWITH
1220:         ENDWITH

*-- Linhas 1228 a 1284:
1228:         loc_lcIcones = gc_4c_CaminhoIcones
1229:         THIS.AddObject("cnt_4c_Linhas", "Container")
1230:         WITH THIS.cnt_4c_Linhas
1231:             .Top         = 125
1232:             .Left        = 12
1233:             .Width       = 708
1234:             .Height      = 465
1235:             .SpecialEffect = 0
1236:             .Visible     = .F.
1237:             .BackStyle   = 1
1238:             .BackColor   = RGB(255,255,255)
1239:             .BorderWidth = 0
1240: 
1241:             .AddObject("lbl_4c_TituloLin", "Label")
1242:             WITH .lbl_4c_TituloLin
1243:                 .AutoSize  = .T.
1244:                 .FontBold  = .T.
1245:                 .FontName  = "Tahoma"
1246:                 .FontSize  = 10
1247:                 .BackStyle = 0
1248:                 .Caption   = "Pe" + CHR(231) + "as a produzir por linha"
1249:                 .Height    = 18
1250:                 .Left      = 259
1251:                 .Top       = 10
1252:                 .Width     = 170
1253:                 .ForeColor = RGB(90,90,90)
1254:             ENDWITH
1255: 
1256:             .AddObject("cmd_4c_OkLinhas", "CommandButton")
1257:             WITH .cmd_4c_OkLinhas
1258:                 .Top             = 10
1259:                 .Left            = 620
1260:                 .Height          = 75
1261:                 .Width           = 75
1262:                 .FontBold        = .T.
1263:                 .FontItalic      = .T.
1264:                 .FontName        = "Comic Sans MS"
1265:                 .FontSize        = 8
1266:                 .WordWrap        = .T.
1267:                 .Picture         = loc_lcIcones + "cadastro_salvar_60.jpg"
1268:                 .DisabledPicture = loc_lcIcones + "cadastro_salvar_60.jpg"
1269:                 .Cancel          = .T.
1270:                 .Caption         = "OK"
1271:                 .ForeColor       = RGB(90,90,90)
1272:                 .BackColor       = RGB(255,255,255)
1273:                 .Themes          = .T.
1274:             ENDWITH
1275: 
1276:             .AddObject("grd_4c_LinhasAgg", "Grid")
1277:             WITH .grd_4c_LinhasAgg
1278:                 .Top               = 32
1279:                 .Left              = 174
1280:                 .Height            = 420
1281:                 .Width             = 359
1282:                 .ColumnCount       = 4
1283:                 .FontSize          = 8
1284:                 .AllowHeaderSizing = .F.

*-- Linhas 1295 a 1303:
1295:                     .Resizable          = .F.
1296:                     .ReadOnly           = .T.
1297:                     .Sparse             = .F.
1298:                     .Header1.Caption    = "Linha"
1299:                     .Header1.FontName   = "Verdana"
1300:                     .Header1.FontSize   = 8
1301:                     .Header1.Alignment  = 2
1302:                     .Header1.ForeColor  = RGB(36,84,155)
1303:                     .Text1.FontName     = "Arial"

*-- Linhas 1313 a 1321:
1313:                     .Resizable          = .F.
1314:                     .ReadOnly           = .T.
1315:                     .Sparse             = .F.
1316:                     .Header1.Caption    = "Quantidade"
1317:                     .Header1.FontName   = "Verdana"
1318:                     .Header1.FontSize   = 8
1319:                     .Header1.Alignment  = 2
1320:                     .Header1.ForeColor  = RGB(36,84,155)
1321:                     .Text1.FontSize     = 8

*-- Linhas 1331 a 1339:
1331:                     .Resizable          = .F.
1332:                     .ReadOnly           = .T.
1333:                     .Sparse             = .F.
1334:                     .Header1.Caption    = "Estoque"
1335:                     .Header1.FontName   = "Verdana"
1336:                     .Header1.FontSize   = 8
1337:                     .Header1.Alignment  = 2
1338:                     .Header1.ForeColor  = RGB(36,84,155)
1339:                     .Text1.FontName     = "Arial"

*-- Linhas 1350 a 1358:
1350:                     .Resizable          = .F.
1351:                     .ReadOnly           = .T.
1352:                     .Sparse             = .F.
1353:                     .Header1.Caption    = "Produzir"
1354:                     .Header1.FontName   = "Verdana"
1355:                     .Header1.FontSize   = 8
1356:                     .Header1.Alignment  = 2
1357:                     .Header1.ForeColor  = RGB(36,84,155)
1358:                     .Text1.FontName     = "Arial"

*-- Linhas 1375 a 1430:
1375:         loc_lcIcones = gc_4c_CaminhoIcones
1376:         THIS.AddObject("cnt_4c_Requisicoes", "Container")
1377:         WITH THIS.cnt_4c_Requisicoes
1378:             .Top         = 125
1379:             .Left        = 12
1380:             .Width       = 708
1381:             .Height      = 465
1382:             .SpecialEffect = 0
1383:             .Visible     = .F.
1384:             .BackStyle   = 1
1385:             .BackColor   = RGB(255,255,255)
1386:             .BorderWidth = 0
1387: 
1388:             .AddObject("lbl_4c_TituloReq", "Label")
1389:             WITH .lbl_4c_TituloReq
1390:                 .AutoSize  = .T.
1391:                 .FontBold  = .T.
1392:                 .FontName  = "Tahoma"
1393:                 .FontSize  = 10
1394:                 .BackStyle = 0
1395:                 .Caption   = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
1396:                 .Height    = 18
1397:                 .Left      = 229
1398:                 .Top       = 8
1399:                 .Width     = 249
1400:                 .ForeColor = RGB(90,90,90)
1401:             ENDWITH
1402: 
1403:             .AddObject("cmd_4c_SairReq", "CommandButton")
1404:             WITH .cmd_4c_SairReq
1405:                 .Top             = 10
1406:                 .Left            = 620
1407:                 .Height          = 75
1408:                 .Width           = 75
1409:                 .FontBold        = .T.
1410:                 .FontItalic      = .T.
1411:                 .FontName        = "Comic Sans MS"
1412:                 .FontSize        = 8
1413:                 .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"
1414:                 .DisabledPicture = loc_lcIcones + "cadastro_sair_60.jpg"
1415:                 .Cancel          = .T.
1416:                 .Caption         = "Sair"
1417:                 .ForeColor       = RGB(90,90,90)
1418:                 .BackColor       = RGB(255,255,255)
1419:                 .Themes          = .T.
1420:             ENDWITH
1421: 
1422:             .AddObject("grd_4c_PedraReq", "Grid")
1423:             WITH .grd_4c_PedraReq
1424:                 .Top               = 32
1425:                 .Left              = 9
1426:                 .Height            = 420
1427:                 .Width             = 605
1428:                 .ColumnCount       = 5
1429:                 .FontSize          = 8
1430:                 .DeleteMark        = .F.

*-- Linhas 1436 a 1444:
1436:                     .Width              = 108
1437:                     .Movable            = .F.
1438:                     .Resizable          = .F.
1439:                     .Header1.Caption    = "Produto"
1440:                     .Header1.FontName   = "Verdana"
1441:                     .Header1.FontSize   = 8
1442:                     .Header1.Alignment  = 2
1443:                     .Header1.ForeColor  = RGB(36,84,155)
1444:                     .Text1.FontSize     = 8

*-- Linhas 1453 a 1461:
1453:                     .Movable            = .F.
1454:                     .Resizable          = .F.
1455:                     .ReadOnly           = .T.
1456:                     .Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
1457:                     .Header1.FontName   = "Verdana"
1458:                     .Header1.FontSize   = 8
1459:                     .Header1.Alignment  = 2
1460:                     .Header1.ForeColor  = RGB(36,84,155)
1461:                     .Text1.FontBold     = .T.

*-- Linhas 1472 a 1480:
1472:                     .Movable            = .F.
1473:                     .Resizable          = .F.
1474:                     .ReadOnly           = .T.
1475:                     .Header1.Caption    = "Uni"
1476:                     .Header1.FontName   = "Verdana"
1477:                     .Header1.FontSize   = 8
1478:                     .Header1.Alignment  = 2
1479:                     .Header1.ForeColor  = RGB(36,84,155)
1480:                     .Text1.FontBold     = .T.

*-- Linhas 1491 a 1499:
1491:                     .Movable            = .F.
1492:                     .Resizable          = .F.
1493:                     .ReadOnly           = .F.
1494:                     .Header1.Caption    = "Qtde"
1495:                     .Header1.FontName   = "Verdana"
1496:                     .Header1.FontSize   = 8
1497:                     .Header1.Alignment  = 2
1498:                     .Header1.ForeColor  = RGB(36,84,155)
1499:                     .Text1.FontSize     = 8

*-- Linhas 1507 a 1515:
1507:                     .Width              = 108
1508:                     .Movable            = .F.
1509:                     .Resizable          = .F.
1510:                     .Header1.Caption    = "Produto"
1511:                     .Header1.FontName   = "Verdana"
1512:                     .Header1.FontSize   = 8
1513:                     .Header1.Alignment  = 2
1514:                     .Header1.ForeColor  = RGB(36,84,155)
1515:                     .Text1.FontSize     = 8

*-- Linhas 1530 a 1564:
1530:         WITH THIS.txt_4c_TotQtd
1531:             .Height        = 23
1532:             .InputMask     = "999,999.99"
1533:             .Left          = 417
1534:             .SpecialEffect = 1
1535:             .Top           = 349
1536:             .Width         = 80
1537:             .ReadOnly      = .T.
1538:             .Value         = 0
1539:         ENDWITH
1540: 
1541:         THIS.AddObject("txt_4c_TotEst", "TextBox")
1542:         WITH THIS.txt_4c_TotEst
1543:             .Height        = 23
1544:             .InputMask     = "999,999.99"
1545:             .Left          = 498
1546:             .SpecialEffect = 1
1547:             .Top           = 349
1548:             .Width         = 81
1549:             .ReadOnly      = .T.
1550:             .Value         = 0
1551:         ENDWITH
1552: 
1553:         THIS.AddObject("txt_4c_TotPrz", "TextBox")
1554:         WITH THIS.txt_4c_TotPrz
1555:             .Height        = 23
1556:             .InputMask     = "999,999.99"
1557:             .Left          = 580
1558:             .SpecialEffect = 1
1559:             .Top           = 349
1560:             .Width         = 82
1561:             .ReadOnly      = .T.
1562:             .Value         = 0
1563:         ENDWITH
1564:     ENDPROC

*-- Linhas 1571 a 1604:
1571:         WITH THIS.img_4c_Figura
1572:             .Stretch = 1
1573:             .Height  = 204
1574:             .Left    = 726
1575:             .Top     = 125
1576:             .Visible = .F.
1577:             .Width   = 266
1578:         ENDWITH
1579: 
1580:         THIS.AddObject("lbl_4c_ObsItens", "Label")
1581:         WITH THIS.lbl_4c_ObsItens
1582:             .AutoSize  = .T.
1583:             .FontBold  = .T.
1584:             .FontName  = "Verdana"
1585:             .FontSize  = 8
1586:             .BackStyle = 0
1587:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
1588:             .Height    = 15
1589:             .Left      = 726
1590:             .Top       = 369
1591:             .Width     = 134
1592:             .ForeColor = RGB(255,255,255)
1593:         ENDWITH
1594: 
1595:         THIS.AddObject("edt_4c_Obs", "EditBox")
1596:         WITH THIS.edt_4c_Obs
1597:             .Height = 205
1598:             .Left   = 732
1599:             .Top    = 361
1600:             .Width  = 266
1601:         ENDWITH
1602:     ENDPROC
1603: 
1604:     *==========================================================================

*-- Linhas 1616 a 1625:
1616:         TRY
1617:             THIS.AddObject("shp_4c_Shape2", "Shape")
1618:             WITH THIS.shp_4c_Shape2
1619:                 .Top           = 9
1620:                 .Left          = 9
1621:                 .Height        = 51
1622:                 .Width         = 279
1623:                 .SpecialEffect = 0
1624:                 .BorderStyle   = 1
1625:                 .BorderWidth   = 1

*-- Linhas 1632 a 1641:
1632: 
1633:             THIS.AddObject("shp_4c_Shape3", "Shape")
1634:             WITH THIS.shp_4c_Shape3
1635:                 .Top           = 10
1636:                 .Left          = 820
1637:                 .Height        = 38
1638:                 .Width         = 116
1639:                 .SpecialEffect = 0
1640:                 .BorderStyle   = 1
1641:                 .BorderWidth   = 1

*-- Linhas 1785 a 1800:
1785:     * AjustarBotaoPedras - habilitar apenas se parametros completos
1786:     *==========================================================================
1787:     PROTECTED PROCEDURE AjustarBotaoPedras()
1788:         THIS.cmd_4c_Requisicoes.Enabled = .F.
1789:         IF USED("crSigCdPam") .AND. NOT EOF("crSigCdPam")
1790:             IF NOT EMPTY(ALLTRIM(crSigCdPam.DopEmphs)) .AND. ;
1791:                NOT EMPTY(ALLTRIM(crSigCdPam.DopReqcs)) .AND. ;
1792:                NOT EMPTY(ALLTRIM(crSigCdPam.DopPedcs)) .AND. ;
1793:                NOT EMPTY(ALLTRIM(crSigCdPam.DopComps)) .AND. ;
1794:                NOT THIS.this_lReserva
1795:                 THIS.cmd_4c_Requisicoes.Enabled = .T.
1796:             ENDIF
1797:         ENDIF
1798:     ENDPROC
1799: 
1800:     *==========================================================================

*-- Linhas 1821 a 1855:
1821:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column2.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1822:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column3.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1823:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column4.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1824:         BINDEVENT(THIS.cmd_4c_Disponiveis,                                "Click",             THIS, "CmdDisponiveisClick")
1825:         BINDEVENT(THIS.cmd_4c_LinhasTot,                                  "Click",             THIS, "CmdLinhasTotClick")
1826:         BINDEVENT(THIS.cmd_4c_Requisicoes,                                "Click",             THIS, "CmdRequisoesClick")
1827:         BINDEVENT(THIS.cmd_4c_Estoques,                                   "Click",             THIS, "CmdEstoquesClick")
1828:         BINDEVENT(THIS.cmd_4c_Relatorio,                                  "Click",             THIS, "CmdRelatorioClick")
1829:         BINDEVENT(THIS.cmd_4c_Processar,                                  "Click",             THIS, "CmdProcessarClick")
1830:         BINDEVENT(THIS.cmd_4c_Cancelar,                                   "Click",             THIS, "CmdCancelarClick")
1831:         BINDEVENT(THIS.cnt_4c_Estoques.cmd_4c_OkEstq,                    "Click",             THIS, "CancelarC5Click")
1832:         BINDEVENT(THIS.cnt_4c_Disponivel.cmd_4c_SairDisp,                "Click",             THIS, "CancelarC2Click")
1833:         BINDEVENT(THIS.cnt_4c_Requisicoes.cmd_4c_SairReq,                "Click",             THIS, "CancelarC4Click")
1834:         BINDEVENT(THIS.cnt_4c_Linhas.cmd_4c_OkLinhas,                    "Click",             THIS, "CancelarC1Click")
1835:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1, "Valid",             THIS, "GradePedra1Valid")
1836:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "When",              THIS, "GradePedra5When")
1837:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "Valid",             THIS, "GradePedra5Valid")
1838:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "KeyPress",         THIS, "GradePedra5LostFocus")
1839:         BINDEVENT(THIS.img_4c_Figura,                                     "DblClick",          THIS, "ImgFiguraDblClick")
1840:     ENDPROC
1841: 
1842:     *==========================================================================
1843:     * HANDLERS DE EVENTOS
1844:     *==========================================================================
1845: 
1846:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
1847:         LOCAL loc_lcArquivo, loc_lcFoto, loc_oErro
1848:         TRY
1849:             THIS.edt_4c_Obs.Refresh
1850:             THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
1851: 
1852:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1853: 
1854:             IF USED("TmpSaldG")
1855:                 SELECT TmpSaldG

*-- Linhas 1862 a 1870:
1862:                 .txt_4c_TotQtdInfo.Value = TmpSaldo.Saldo
1863:                 .txt_4c_TotEstInfo.Value = TmpSaldo.Saldo - TmpSaldo.Disps
1864:                 .txt_4c_TotPrzInfo.Value = TmpSaldo.Disps
1865:                 .lbl_4c_TituloInfo.Caption = TmpFinal.Cpros + ;
1866:                     IIF(NOT EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
1867:                     IIF(NOT EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
1868: 
1869:                 IF THIS.this_oBusinessObject.AtualizarInfoItem(par_nColIndex)
1870:                     .txt_4c_DGrupoInfo.Value = THIS.this_oBusinessObject.this_cDscGrupo

*-- Linhas 1919 a 1927:
1919:                         IF SQLEXEC(gnConnHandle, "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crTmpPro.CGrus)), "crTmpGru") > 0
1920:                             IF NOT EOF("crTmpGru")
1921:                                 IF INLIST(crTmpGru.TipoEstos, 3, 4)
1922:                                     THIS.cmd_4c_Disponiveis.Enabled = .T.
1923:                                 ENDIF
1924:                             ENDIF
1925:                             USE IN crTmpGru
1926:                         ENDIF
1927:                     ENDIF

*-- Linhas 2135 a 2159:
2135:                     .Column3.Width           = 24
2136:                     .Column4.Width           = 75
2137:                     .Column5.Width           = 75
2138:                     .Column1.Header1.Caption = "Produto"
2139:                     .Column2.Header1.Caption = "Cor"
2140:                     .Column3.Header1.Caption = "Tam"
2141:                     .Column4.Header1.Caption = "Disponivel"
2142:                     .Column5.Header1.Caption = "Utilizar"
2143:                     .Column1.ControlSource   = "TmpDisp.Cpros"
2144:                     .Column2.ControlSource   = "TmpDisp.CodCors"
2145:                     .Column3.ControlSource   = "TmpDisp.CodTams"
2146:                     .Column4.ControlSource   = "TmpDisp.Disps"
2147:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2148:                 ENDWITH
2149:                 THIS.cnt_4c_Disponivel.txt_4c_PedidaDisp.Value = TmpFinal.Saldo
2150:                 THIS.grd_4c_Itens.Enabled        = .F.
2151:                 THIS.cmd_4c_Processar.Enabled    = .F.
2152:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2153:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2154:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2155:                 THIS.cnt_4c_Info.Enabled         = .F.
2156:                 THIS.cnt_4c_Disponivel.Visible   = .T.
2157:                 THIS.cnt_4c_Disponivel.ZOrder(0)
2158:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
2159:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.SetFocus

*-- Linhas 2179 a 2191:
2179:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas=[TOTAIS]",                              "Column")
2180:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas=[TOTAIS],RGB(0,0,255),RGB(0,0,0))", "Column")
2181:             ENDWITH
2182:             THIS.cmd_4c_Processar.Enabled   = .F.
2183:             THIS.cmd_4c_Cancelar.Enabled    = .F.
2184:             THIS.cmd_4c_LinhasTot.Enabled   = .F.
2185:             THIS.cmd_4c_Requisicoes.Enabled = .F.
2186:             THIS.cmd_4c_Disponiveis.Enabled = .F.
2187:             THIS.grd_4c_Itens.Enabled       = .F.
2188:             THIS.cnt_4c_Info.Enabled        = .F.
2189:             THIS.cnt_4c_Linhas.Visible      = .T.
2190:             THIS.cnt_4c_Linhas.ZOrder(0)
2191:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Refresh

*-- Linhas 2208 a 2220:
2208:                 .Column4.ControlSource = "SelPedra.Qtds"
2209:                 .Column5.ControlSource = "SelPedra.Cpro2s"
2210:             ENDWITH
2211:             THIS.cmd_4c_Processar.Enabled    = .F.
2212:             THIS.cmd_4c_Cancelar.Enabled     = .F.
2213:             THIS.cmd_4c_LinhasTot.Enabled    = .F.
2214:             THIS.cmd_4c_Requisicoes.Enabled  = .F.
2215:             THIS.cmd_4c_Disponiveis.Enabled  = .F.
2216:             THIS.grd_4c_Itens.Enabled        = .F.
2217:             THIS.cnt_4c_Info.Enabled         = .F.
2218:             THIS.cnt_4c_Requisicoes.Visible  = .T.
2219:             THIS.cnt_4c_Requisicoes.ZOrder(0)
2220:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh

*-- Linhas 2241 a 2269:
2241:                     .Column3.Width           = 24
2242:                     .Column4.Width           = 75
2243:                     .Column5.Width           = 75
2244:                     .Column1.Header1.Caption = "Grupo"
2245:                     .Column2.Header1.Caption = "Conta"
2246:                     .Column3.Header1.Caption = "Prioridade"
2247:                     .Column4.Header1.Caption = "Disponivel"
2248:                     .Column5.Header1.Caption = "Utilizar"
2249:                     .Column1.ControlSource   = "TmpDisp.Grupos"
2250:                     .Column2.ControlSource   = "TmpDisp.Estos"
2251:                     .Column3.ControlSource   = "TmpDisp.Priors"
2252:                     .Column4.ControlSource   = "TmpDisp.Disps"
2253:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2254:                 ENDWITH
2255:                 THIS.cnt_4c_Estoques.lbl_4c_TituloEstq.Caption = ;
2256:                     "Estoque Dispon" + CHR(237) + "vel (" + TmpFinal.Cpros + " " + TmpFinal.CodCors + "/" + TmpFinal.CodTams + ")"
2257:                 THIS.cnt_4c_Estoques.txt_4c_PedidaEstq.Value = TmpFinal.Saldo - TmpFinal.Estoque
2258:                 THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Value  = 0
2259:                 THIS.cmd_4c_Processar.Enabled    = .F.
2260:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2261:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2262:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2263:                 THIS.cmd_4c_Estoques.Enabled     = .F.
2264:                 THIS.cmd_4c_Requisicoes.Enabled  = .F.
2265:                 THIS.cnt_4c_Info.Enabled         = .F.
2266:                 THIS.cnt_4c_Estoques.Visible     = .T.
2267:                 THIS.cnt_4c_Estoques.ZOrder(0)
2268:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Refresh
2269:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.SetFocus

*-- Linhas 2350 a 2362:
2350:         CATCH TO loc_oErro
2351:             MsgErro(loc_oErro.Message, "Erro")
2352:         ENDTRY
2353:         THIS.cmd_4c_Processar.Enabled    = .T.
2354:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2355:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2356:         THIS.cmd_4c_Estoques.Enabled     = .T.
2357:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2358:         THIS.cnt_4c_Info.Enabled         = .T.
2359:         THIS.cnt_4c_Estoques.Visible     = .F.
2360:         THIS.grd_4c_Itens.Enabled        = .T.
2361:         THIS.grd_4c_Itens.ZOrder(0)
2362:         THIS.grd_4c_Itens.Refresh

*-- Linhas 2371 a 2413:
2371:         CATCH TO loc_oErro
2372:             MsgErro(loc_oErro.Message, "Erro")
2373:         ENDTRY
2374:         THIS.cmd_4c_Processar.Enabled    = .T.
2375:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2376:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2377:         THIS.cmd_4c_Requisicoes.Enabled  = .T.
2378:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2379:         THIS.cnt_4c_Info.Enabled         = .T.
2380:         THIS.cnt_4c_Disponivel.Visible   = .F.
2381:         THIS.grd_4c_Itens.Enabled        = .T.
2382:         THIS.grd_4c_Itens.ZOrder(0)
2383:         THIS.grd_4c_Itens.Refresh
2384:         THIS.grd_4c_Itens.Column6.SetFocus
2385:     ENDPROC
2386: 
2387:     *-- Container4 Sair: fechar painel de requisicoes
2388:     PROCEDURE CancelarC4Click()
2389:         THIS.cmd_4c_Processar.Enabled    = .T.
2390:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2391:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2392:         THIS.cmd_4c_Requisicoes.Enabled  = .T.
2393:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2394:         THIS.cnt_4c_Info.Enabled         = .T.
2395:         THIS.cnt_4c_Requisicoes.Visible  = .F.
2396:         THIS.grd_4c_Itens.Enabled        = .T.
2397:         THIS.grd_4c_Itens.ZOrder(0)
2398:         THIS.grd_4c_Itens.Refresh
2399:         THIS.grd_4c_Itens.Column6.SetFocus
2400:     ENDPROC
2401: 
2402:     *-- Container1 OK: fechar painel de linhas
2403:     PROCEDURE CancelarC1Click()
2404:         THIS.cmd_4c_Processar.Enabled    = .T.
2405:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2406:         THIS.cmd_4c_Requisicoes.Enabled  = .T.
2407:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2408:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2409:         THIS.cnt_4c_Linhas.Visible       = .F.
2410:         THIS.cnt_4c_Info.Enabled         = .T.
2411:         THIS.grd_4c_Itens.Enabled        = .T.
2412:         THIS.grd_4c_Itens.ZOrder(0)
2413:         THIS.grd_4c_Itens.Refresh

*-- Linhas 2546 a 2554:
2546:         loc_lSucesso = .F.
2547:         TRY
2548:             *-- Barra de botoes principais (equivalente a cnt_4c_Botoes do CRUD)
2549:             IF NOT PEMSTATUS(THIS, "cmd_4c_Processar", 5)
2550:                 THIS.ConfigurarBotoesPrincipais()
2551:             ENDIF
2552:             *-- Grade principal (equivalente ao grid da Page1 do CRUD)
2553:             IF NOT PEMSTATUS(THIS, "grd_4c_Itens", 5)
2554:                 THIS.ConfigurarGradeItens()

*-- Linhas 2605 a 2629:
2605:             DO CASE
2606:                 CASE par_nPagina = 1
2607:                     *-- Retorno a visao principal: reabilitar botoes e grade
2608:                     IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
2609:                         THIS.cmd_4c_Processar.Enabled   = .T.
2610:                     ENDIF
2611:                     IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
2612:                         THIS.cmd_4c_Cancelar.Enabled    = .T.
2613:                     ENDIF
2614:                     IF PEMSTATUS(THIS, "cmd_4c_LinhasTot", 5)
2615:                         THIS.cmd_4c_LinhasTot.Enabled   = .T.
2616:                     ENDIF
2617:                     IF PEMSTATUS(THIS, "cmd_4c_Requisicoes", 5)
2618:                         THIS.cmd_4c_Requisicoes.Enabled = .T.
2619:                     ENDIF
2620:                     IF PEMSTATUS(THIS, "cmd_4c_Disponiveis", 5)
2621:                         THIS.cmd_4c_Disponiveis.Enabled = .T.
2622:                     ENDIF
2623:                     IF PEMSTATUS(THIS, "cmd_4c_Estoques", 5)
2624:                         THIS.cmd_4c_Estoques.Enabled    = .T.
2625:                     ENDIF
2626:                     IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2627:                         THIS.cnt_4c_Info.Enabled        = .T.
2628:                     ENDIF
2629:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)

*-- Linhas 2662 a 2670:
2662:     PROCEDURE BtnIncluirClick()
2663:         LOCAL loc_oErro
2664:         TRY
2665:             IF PEMSTATUS(THIS, "cmd_4c_Processar", 5) AND !THIS.cmd_4c_Processar.Enabled
2666:                 MsgAviso("Processamento indispon" + CHR(237) + "vel no momento.", "Aviso")
2667:                 loc_lResultado = .F.
2668:             ENDIF
2669:             THIS.CmdProcessarClick()
2670:         CATCH TO loc_oErro

*-- Linhas 2765 a 2773:
2765:     PROCEDURE BtnSalvarClick()
2766:         LOCAL loc_oErro
2767:         TRY
2768:             IF PEMSTATUS(THIS, "cmd_4c_Processar", 5) AND NOT THIS.cmd_4c_Processar.Enabled
2769:                 MsgAviso("Processamento indispon" + CHR(237) + "vel no momento.", "Aviso")
2770:                 loc_lResultado = .F.
2771:             ENDIF
2772:             THIS.CmdProcessarClick()
2773:         CATCH TO loc_oErro

*-- Linhas 2847 a 2871:
2847:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2848:             THIS.grd_4c_Itens.Enabled      = loc_lHab
2849:         ENDIF
2850:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
2851:             THIS.cmd_4c_Processar.Enabled  = loc_lHab
2852:         ENDIF
2853:         IF PEMSTATUS(THIS, "cmd_4c_LinhasTot", 5)
2854:             THIS.cmd_4c_LinhasTot.Enabled  = loc_lHab
2855:         ENDIF
2856:         IF PEMSTATUS(THIS, "cmd_4c_Disponiveis", 5)
2857:             THIS.cmd_4c_Disponiveis.Enabled = loc_lHab
2858:         ENDIF
2859:         IF PEMSTATUS(THIS, "cmd_4c_Estoques", 5)
2860:             THIS.cmd_4c_Estoques.Enabled   = loc_lHab
2861:         ENDIF
2862:         IF loc_lHab
2863:             THIS.AjustarBotaoPedras()
2864:         ELSE
2865:             IF PEMSTATUS(THIS, "cmd_4c_Requisicoes", 5)
2866:                 THIS.cmd_4c_Requisicoes.Enabled = .F.
2867:             ENDIF
2868:         ENDIF
2869:     ENDPROC
2870: 
2871:     *==========================================================================

*-- Linhas 2879 a 2888:
2879:             THIS.txt_4c_TotEst.Value = 0
2880:             THIS.txt_4c_TotPrz.Value = 0
2881:         ENDIF
2882:         IF PEMSTATUS(THIS, "lbl_4c_ObsItens", 5)
2883:             THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
2884:         ENDIF
2885:         IF PEMSTATUS(THIS, "edt_4c_Obs", 5)
2886:             THIS.edt_4c_Obs.ControlSource = ""
2887:         ENDIF
2888:         IF PEMSTATUS(THIS, "img_4c_Figura", 5)

*-- Linhas 2962 a 2978:
2962:         ENDIF
2963:         THIS.HabilitarCampos(loc_lModoPrincipal)
2964:         IF loc_lModoPrincipal
2965:             IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
2966:                 THIS.cmd_4c_Cancelar.Enabled = .T.
2967:             ENDIF
2968:             IF PEMSTATUS(THIS, "cmd_4c_Relatorio", 5)
2969:                 THIS.cmd_4c_Relatorio.Enabled = .T.
2970:             ENDIF
2971:         ELSE
2972:             IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
2973:                 THIS.cmd_4c_Cancelar.Enabled = .F.
2974:             ENDIF
2975:         ENDIF
2976:     ENDPROC
2977: 
2978: ENDDEFINE

