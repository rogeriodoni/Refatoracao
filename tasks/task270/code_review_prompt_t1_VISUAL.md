# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 441: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1092 linhas total):

*-- Linhas 145 a 187:
145:         *-- Propriedades originais: Top=1, Left=1, Width=800, Height=80
146:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
147:         WITH THIS.cnt_4c_Cabecalho
148:             .Top        = 1
149:             .Left       = 1
150:             .Width      = loc_nW - 2
151:             .Height     = 80
152:             .BackStyle  = 1
153:             .BackColor  = RGB(100, 100, 100)
154:             .BorderWidth = 0
155: 
156:             *-- Label sombra (texto escuro, deslocado 1px para efeito profundidade)
157:             .AddObject("lbl_4c_Sombra", "Label")
158:             WITH .lbl_4c_Sombra
159:                 .AutoSize  = .F.
160:                 .Width     = loc_nW - 2
161:                 .Height    = 40
162:                 .Top       = 18
163:                 .Left      = 10
164:                 .Caption   = "Capacidade Produtiva"
165:                 .FontName  = "Tahoma"
166:                 .FontSize  = 18
167:                 .FontBold  = .T.
168:                 .BackStyle = 0
169:                 .ForeColor = RGB(0, 0, 0)
170:                 .WordWrap  = .T.
171:                 .Alignment = 0
172:             ENDWITH
173: 
174:             *-- Label titulo (branco sobre cinza)
175:             .AddObject("lbl_4c_Titulo", "Label")
176:             WITH .lbl_4c_Titulo
177:                 .AutoSize  = .F.
178:                 .Width     = loc_nW - 2
179:                 .Height    = 46
180:                 .Top       = 17
181:                 .Left      = 10
182:                 .Caption   = "Capacidade Produtiva"
183:                 .FontName  = "Tahoma"
184:                 .FontSize  = 18
185:                 .FontBold  = .T.
186:                 .BackStyle = 0
187:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 199 a 268:
199:         *-- Propriedades originais: Top=104, Left=8, Width=278, Height=36
200:         THIS.AddObject("cnt_4c_Container1", "Container")
201:         WITH THIS.cnt_4c_Container1
202:             .Top          = 104
203:             .Left         = 8
204:             .Width        = 278
205:             .Height       = 36
206:             .BackStyle    = 0
207:             .BorderWidth  = 0
208:             .SpecialEffect = 0
209: 
210:             *-- Label "Fase :"
211:             .AddObject("lbl_4c_Fase", "Label")
212:             WITH .lbl_4c_Fase
213:                 .FontBold  = .T.
214:                 .FontName  = "Tahoma"
215:                 .FontSize  = 8
216:                 .BackStyle = 0
217:                 .Caption   = "Fase :"
218:                 .Height    = 17
219:                 .Left      = 2
220:                 .Top       = 8
221:                 .Width     = 40
222:                 .ForeColor = RGB(90, 90, 90)
223:             ENDWITH
224: 
225:             *-- TextBox Fase (somente leitura, preenche em CarregarDados)
226:             .AddObject("txt_4c_Fase", "TextBox")
227:             WITH .txt_4c_Fase
228:                 .FontBold  = .T.
229:                 .FontName  = "Tahoma"
230:                 .FontSize  = 8
231:                 .Height    = 23
232:                 .Left      = 44
233:                 .Top       = 5
234:                 .Width     = 100
235:                 .BackColor = RGB(255, 198, 140)
236:                 .ReadOnly  = .T.
237:                 .Value     = ""
238:             ENDWITH
239: 
240:             *-- Label "Data :"
241:             .AddObject("lbl_4c_Data", "Label")
242:             WITH .lbl_4c_Data
243:                 .FontBold  = .T.
244:                 .FontName  = "Tahoma"
245:                 .FontSize  = 8
246:                 .BackStyle = 0
247:                 .Caption   = "Data :"
248:                 .Height    = 17
249:                 .Left      = 147
250:                 .Top       = 9
251:                 .Width     = 40
252:                 .ForeColor = RGB(90, 90, 90)
253:             ENDWITH
254: 
255:             *-- TextBox Data (somente leitura, preenche em CarregarDados)
256:             .AddObject("txt_4c_Data", "TextBox")
257:             WITH .txt_4c_Data
258:                 .FontBold  = .T.
259:                 .FontName  = "Tahoma"
260:                 .FontSize  = 8
261:                 .Height    = 23
262:                 .Left      = 189
263:                 .Top       = 5
264:                 .Width     = 72
265:                 .BackColor = RGB(255, 198, 140)
266:                 .ReadOnly  = .T.
267:                 .Value     = {}
268:             ENDWITH

*-- Linhas 276 a 459:
276:         *-- Propriedades originais: Top=104, Left=288, Width=504, Height=36
277:         THIS.AddObject("cnt_4c_Container2", "Container")
278:         WITH THIS.cnt_4c_Container2
279:             .Top          = 104
280:             .Left         = 288
281:             .Width        = 504
282:             .Height       = 36
283:             .BackStyle    = 0
284:             .BorderWidth  = 0
285:             .SpecialEffect = 0
286: 
287:             *-- Label "Capacidade:"
288:             .AddObject("lbl_4c_Capacidade", "Label")
289:             WITH .lbl_4c_Capacidade
290:                 .FontBold  = .T.
291:                 .FontName  = "Tahoma"
292:                 .FontSize  = 8
293:                 .BackStyle = 0
294:                 .Caption   = "Capacidade:"
295:                 .Height    = 15
296:                 .Left      = 9
297:                 .Top       = 10
298:                 .Width     = 70
299:                 .ForeColor = RGB(90, 90, 90)
300:             ENDWITH
301: 
302:             *-- TextBox Capacidade (somente leitura)
303:             .AddObject("txt_4c_Cap", "TextBox")
304:             WITH .txt_4c_Cap
305:                 .FontBold  = .T.
306:                 .FontName  = "Tahoma"
307:                 .FontSize  = 8
308:                 .Height    = 23
309:                 .InputMask = "99999"
310:                 .Left      = 81
311:                 .Top       = 5
312:                 .Width     = 63
313:                 .BackColor = RGB(255, 216, 176)
314:                 .ReadOnly  = .T.
315:                 .Value     = 0
316:             ENDWITH
317: 
318:             *-- Label "Min" (apos Capacidade)
319:             .AddObject("lbl_4c_MinCap", "Label")
320:             WITH .lbl_4c_MinCap
321:                 .FontBold  = .T.
322:                 .FontName  = "Tahoma"
323:                 .FontSize  = 8
324:                 .BackStyle = 0
325:                 .Caption   = "Min"
326:                 .Height    = 15
327:                 .Left      = 147
328:                 .Top       = 10
329:                 .Width     = 22
330:                 .ForeColor = RGB(90, 90, 90)
331:             ENDWITH
332: 
333:             *-- Label "Utilizado:"
334:             .AddObject("lbl_4c_Utilizado", "Label")
335:             WITH .lbl_4c_Utilizado
336:                 .FontBold  = .T.
337:                 .FontName  = "Tahoma"
338:                 .FontSize  = 8
339:                 .BackStyle = 0
340:                 .Caption   = "Utilizado:"
341:                 .Height    = 15
342:                 .Left      = 194
343:                 .Top       = 10
344:                 .Width     = 54
345:                 .ForeColor = RGB(90, 90, 90)
346:             ENDWITH
347: 
348:             *-- TextBox Utilizado (somente leitura)
349:             .AddObject("txt_4c_Utz", "TextBox")
350:             WITH .txt_4c_Utz
351:                 .FontBold  = .T.
352:                 .FontName  = "Tahoma"
353:                 .FontSize  = 8
354:                 .Height    = 23
355:                 .InputMask = "99999"
356:                 .Left      = 250
357:                 .Top       = 5
358:                 .Width     = 63
359:                 .BackColor = RGB(255, 216, 176)
360:                 .ReadOnly  = .T.
361:                 .Value     = 0
362:             ENDWITH
363: 
364:             *-- Label "Min" (apos Utilizado)
365:             .AddObject("lbl_4c_MinUtz", "Label")
366:             WITH .lbl_4c_MinUtz
367:                 .FontBold  = .T.
368:                 .FontName  = "Tahoma"
369:                 .FontSize  = 8
370:                 .BackStyle = 0
371:                 .Caption   = "Min"
372:                 .Height    = 15
373:                 .Left      = 316
374:                 .Top       = 9
375:                 .Width     = 22
376:                 .ForeColor = RGB(90, 90, 90)
377:             ENDWITH
378: 
379:             *-- Label "Saldo : "
380:             .AddObject("lbl_4c_Saldo", "Label")
381:             WITH .lbl_4c_Saldo
382:                 .FontBold  = .T.
383:                 .FontName  = "Tahoma"
384:                 .FontSize  = 8
385:                 .BackStyle = 0
386:                 .Caption   = "Saldo : "
387:                 .Height    = 15
388:                 .Left      = 366
389:                 .Top       = 10
390:                 .Width     = 42
391:                 .ForeColor = RGB(90, 90, 90)
392:             ENDWITH
393: 
394:             *-- TextBox Saldo (somente leitura)
395:             .AddObject("txt_4c_Sld", "TextBox")
396:             WITH .txt_4c_Sld
397:                 .FontBold  = .T.
398:                 .FontName  = "Tahoma"
399:                 .FontSize  = 8
400:                 .Height    = 23
401:                 .InputMask = "99999"
402:                 .Left      = 410
403:                 .Top       = 5
404:                 .Width     = 63
405:                 .BackColor = RGB(255, 216, 176)
406:                 .ReadOnly  = .T.
407:                 .Value     = 0
408:             ENDWITH
409: 
410:             *-- Label "Min" (apos Saldo)
411:             .AddObject("lbl_4c_MinSld", "Label")
412:             WITH .lbl_4c_MinSld
413:                 .FontBold  = .T.
414:                 .FontName  = "Tahoma"
415:                 .FontSize  = 8
416:                 .BackStyle = 0
417:                 .Caption   = "Min"
418:                 .Height    = 15
419:                 .Left      = 476
420:                 .Top       = 9
421:                 .Width     = 22
422:                 .ForeColor = RGB(90, 90, 90)
423:             ENDWITH
424:         ENDWITH
425:     ENDPROC
426: 
427:     *==========================================================================
428:     PROTECTED PROCEDURE ConfigurarBotaoEncerrar
429:     *==========================================================================
430:         *-- Botao Encerrar (Sair do legado: Top=4, Left=725, Cancel=.T.)
431:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
432:         WITH THIS.cmd_4c_Encerrar
433:             .Top            = 4
434:             .Left           = 725
435:             .Width          = 75
436:             .Height         = 75
437:             .Caption        = "Encerrar"
438:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
439:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
440:             .Cancel         = .T.
441:             .FontName       = "Comic Sans MS"
442:             .FontSize       = 8
443:             .FontBold       = .T.
444:             .FontItalic     = .T.
445:             .ForeColor      = RGB(90, 90, 90)
446:             .BackColor      = RGB(255, 255, 255)
447:             .Themes         = .T.
448:             .SpecialEffect  = 0
449:             .PicturePosition = 13
450:             .WordWrap       = .T.
451:             .AutoSize       = .F.
452:             .MousePointer   = 15
453:         ENDWITH
454:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
455:     ENDPROC
456: 
457:     *==========================================================================
458:     PROTECTED PROCEDURE TornarControlesVisiveis
459:     *==========================================================================

*-- Linhas 523 a 557:
523:                         .Resizable     = .F.
524:                         .ReadOnly      = .T.
525:                         .ControlSource = "cursor_4c_Dados.Nenvs"
526:                         .Header1.Caption   = "Envelope"
527:                         .Header1.FontName  = "Tahoma"
528:                         .Header1.FontSize  = 8
529:                         .Header1.Alignment = 2
530:                         .Header1.ForeColor = RGB(0, 0, 0)
531:                     ENDWITH
532:                     WITH .Column2
533:                         .ColumnOrder   = 3
534:                         .Width         = 100
535:                         .Movable       = .F.
536:                         .Resizable     = .F.
537:                         .ReadOnly      = .T.
538:                         .ControlSource = "cursor_4c_Dados.Nops"
539:                         .Header1.Caption   = "O.P."
540:                         .Header1.FontName  = "Tahoma"
541:                         .Header1.FontSize  = 8
542:                         .Header1.Alignment = 2
543:                     ENDWITH
544:                     WITH .Column3
545:                         .ColumnOrder   = 4
546:                         .Width         = 24
547:                         .Alignment     = 2
548:                         .Movable       = .F.
549:                         .Resizable     = .F.
550:                         .ReadOnly      = .T.
551:                         .ControlSource = "cursor_4c_Dados.Seqs"
552:                         .Header1.Caption   = "Seq"
553:                         .Header1.FontName  = "Tahoma"
554:                         .Header1.FontSize  = 8
555:                         .Header1.Alignment = 2
556:                     ENDWITH
557:                     WITH .Column4

*-- Linhas 563 a 620:
563:                         .ReadOnly      = .T.
564:                         .InputMask     = "9999.99"
565:                         .ControlSource = "cursor_4c_Dados.TempoReal"
566:                         .Header1.Caption   = "Minutos"
567:                         .Header1.FontName  = "Tahoma"
568:                         .Header1.FontSize  = 8
569:                         .Header1.Alignment = 2
570:                     ENDWITH
571:                     WITH .Column5
572:                         .ColumnOrder   = 6
573:                         .Width         = 95
574:                         .Movable       = .F.
575:                         .Resizable     = .F.
576:                         .ReadOnly      = .T.
577:                         .ControlSource = "cursor_4c_Dados.Cpros"
578:                         .Header1.Caption   = "Produto"
579:                         .Header1.FontName  = "Tahoma"
580:                         .Header1.FontSize  = 8
581:                         .Header1.Alignment = 2
582:                     ENDWITH
583:                     WITH .Column6
584:                         .ColumnOrder   = 7
585:                         .Width         = 190
586:                         .Movable       = .F.
587:                         .Resizable     = .F.
588:                         .ReadOnly      = .T.
589:                         .ControlSource = "cursor_4c_Dados.Pedido"
590:                         .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
591:                         .Header1.FontName  = "Tahoma"
592:                         .Header1.FontSize  = 8
593:                         .Header1.Alignment = 2
594:                     ENDWITH
595:                     WITH .Column7
596:                         .ColumnOrder   = 8
597:                         .Width         = 165
598:                         .Movable       = .F.
599:                         .Resizable     = .F.
600:                         .ReadOnly      = .T.
601:                         .ControlSource = "cursor_4c_Dados.cliente"
602:                         .Header1.Caption   = "Cliente"
603:                         .Header1.FontName  = "Tahoma"
604:                         .Header1.FontSize  = 8
605:                         .Header1.Alignment = 2
606:                     ENDWITH
607:                     WITH .Column8
608:                         .ColumnOrder   = 1
609:                         .Width         = 80
610:                         .Alignment     = 3
611:                         .Movable       = .F.
612:                         .Resizable     = .F.
613:                         .ReadOnly      = .T.
614:                         .ControlSource = "cursor_4c_Dados.UniPrdts"
615:                         .Header1.Caption   = "Unidade Prod."
616:                         .Header1.FontName  = "Tahoma"
617:                         .Header1.FontSize  = 8
618:                         .Header1.Alignment = 2
619:                     ENDWITH
620: 

*-- Linhas 733 a 742:
733:         *-- Top=139, Left=0, Width=801, Height=310, ColumnCount=8
734:         THIS.AddObject("grd_4c_Dados", "Grid")
735:         WITH THIS.grd_4c_Dados
736:             .Top              = 139
737:             .Left             = 0
738:             .Width            = 801
739:             .Height           = 310
740:             .ColumnCount      = 8
741:             .FontName         = "Arial"
742:             .FontSize         = 8

*-- Linhas 761 a 798:
761:         *-- Shape4: borda ao redor da foto do produto (inicialmente oculto)
762:         THIS.AddObject("shp_4c_Shape4", "Shape")
763:         WITH THIS.shp_4c_Shape4
764:             .Top       = 455
765:             .Left      = 456
766:             .Width     = 148
767:             .Height    = 109
768:             .BackStyle = 1
769:             .BackColor = RGB(200, 200, 200)
770:             .Visible   = .F.
771:         ENDWITH
772: 
773:         *-- FigJpg: imagem do produto decodificada de base64 (inicialmente oculta)
774:         THIS.AddObject("img_4c_FigJpg", "Image")
775:         WITH THIS.img_4c_FigJpg
776:             .Top     = 457
777:             .Left    = 459
778:             .Width   = 143
779:             .Height  = 105
780:             .Stretch = 1
781:             .Visible = .F.
782:         ENDWITH
783: 
784:         *-- Label "Quantidade" (Say1 do legado)
785:         THIS.AddObject("lbl_4c_LblQtde", "Label")
786:         WITH THIS.lbl_4c_LblQtde
787:             .AutoSize  = .F.
788:             .FontName  = "Tahoma"
789:             .FontSize  = 8
790:             .BackStyle = 0
791:             .Caption   = "Quantidade"
792:             .Top       = 455
793:             .Left      = 11
794:             .Width     = 74
795:             .Height    = 15
796:             .ForeColor = RGB(90, 90, 90)
797:         ENDWITH
798: 

*-- Linhas 804 a 891:
804:             .FontBold  = .T.
805:             .Height    = 23
806:             .InputMask = "99999.999"
807:             .Left      = 9
808:             .Top       = 468
809:             .Width     = 74
810:             .BackColor = RGB(255, 255, 198)
811:             .ReadOnly  = .T.
812:             .Value     = 0
813:         ENDWITH
814: 
815:         *-- Label "Descricao Produto" (Say2 do legado)
816:         THIS.AddObject("lbl_4c_LblDescr", "Label")
817:         WITH THIS.lbl_4c_LblDescr
818:             .AutoSize  = .F.
819:             .FontName  = "Tahoma"
820:             .FontSize  = 8
821:             .BackStyle = 0
822:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
823:             .Top       = 455
824:             .Left      = 92
825:             .Width     = 120
826:             .Height    = 15
827:             .ForeColor = RGB(90, 90, 90)
828:         ENDWITH
829: 
830:         *-- TextBox Descricao Produto (Get_descr do legado) - populado por CarregarFotoProduto
831:         THIS.AddObject("txt_4c_Descr", "TextBox")
832:         WITH THIS.txt_4c_Descr
833:             .FontName  = "Tahoma"
834:             .FontSize  = 8
835:             .FontBold  = .T.
836:             .Height    = 23
837:             .Left      = 90
838:             .Top       = 468
839:             .Width     = 345
840:             .BackColor = RGB(255, 255, 198)
841:             .ForeColor = RGB(0, 0, 0)
842:             .ReadOnly  = .T.
843:             .Value     = ""
844:         ENDWITH
845: 
846:         *-- Label "Cliente" (Say3 do legado)
847:         THIS.AddObject("lbl_4c_LblCliente", "Label")
848:         WITH THIS.lbl_4c_LblCliente
849:             .AutoSize  = .F.
850:             .FontName  = "Tahoma"
851:             .FontSize  = 8
852:             .BackStyle = 0
853:             .Caption   = "Cliente"
854:             .Top       = 494
855:             .Left      = 11
856:             .Width     = 50
857:             .Height    = 15
858:             .ForeColor = RGB(90, 90, 90)
859:         ENDWITH
860: 
861:         *-- TextBox Cliente (Get_Cliente do legado) - cursor_4c_Dados.Rclis
862:         THIS.AddObject("txt_4c_Cliente", "TextBox")
863:         WITH THIS.txt_4c_Cliente
864:             .FontName  = "Tahoma"
865:             .FontSize  = 8
866:             .FontBold  = .T.
867:             .Height    = 23
868:             .Left      = 9
869:             .Top       = 507
870:             .Width     = 425
871:             .BackColor = RGB(255, 255, 221)
872:             .ForeColor = RGB(0, 0, 0)
873:             .ReadOnly  = .T.
874:             .Value     = ""
875:         ENDWITH
876: 
877:         *-- Label "Tempo Total do Envelope" (Say4 do legado)
878:         THIS.AddObject("lbl_4c_LblTEnv", "Label")
879:         WITH THIS.lbl_4c_LblTEnv
880:             .AutoSize  = .F.
881:             .FontName  = "Tahoma"
882:             .FontSize  = 8
883:             .BackStyle = 0
884:             .Caption   = "Tempo Total do Envelope"
885:             .Top       = 532
886:             .Left      = 11
887:             .Width     = 130
888:             .Height    = 15
889:             .ForeColor = RGB(90, 90, 90)
890:         ENDWITH
891: 

*-- Linhas 897 a 923:
897:             .FontBold  = .T.
898:             .Height    = 23
899:             .InputMask = "99999"
900:             .Left      = 9
901:             .Top       = 545
902:             .Width     = 74
903:             .BackColor = RGB(255, 255, 198)
904:             .ForeColor = RGB(0, 0, 0)
905:             .ReadOnly  = .T.
906:             .Value     = 0
907:         ENDWITH
908: 
909:         *-- Label "[ Operacao com Prioridade ]" (Label1 do legado)
910:         THIS.AddObject("lbl_4c_Prioridade", "Label")
911:         WITH THIS.lbl_4c_Prioridade
912:             .AutoSize  = .F.
913:             .FontName  = "Tahoma"
914:             .FontSize  = 8
915:             .BackStyle = 0
916:             .Caption   = "[ Opera" + CHR(231) + CHR(227) + "o com Prioridade ]"
917:             .Top       = 457
918:             .Left      = 617
919:             .Width     = 160
920:             .Height    = 15
921:             .ForeColor = RGB(90, 90, 90)
922:         ENDWITH
923:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigprcpdBO.prg):
*==============================================================================
* sigprcpdBO.prg - Business Object: Capacidade Produtiva
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Colunas da tabela SigCdPcz (mapeadas 1:1 com o schema)
    this_nCodigo    = 0    && codigos numeric(10,0) NOT NULL - PK
    this_cContas    = ""   && contas char(10) NOT NULL
    this_cCvens     = ""   && cvens char(10) NOT NULL
    this_dData      = {}   && datas datetime NULL
    this_cDopes     = ""   && dopes char(20) NOT NULL
    this_dDtLancs   = {}   && dtlancs datetime NULL
    this_dEmissaoF  = {}   && emissaof datetime NULL
    this_dEmissaoI  = {}   && emissaoi datetime NULL
    this_cEmps      = ""   && emps char(3) NOT NULL
    this_nNumeFs    = 0    && numefs numeric(6,0) NOT NULL
    this_nNumeIs    = 0    && numeis numeric(6,0) NOT NULL
    this_dPrevFs    = {}   && prevfs datetime NULL
    this_dPrevIs    = {}   && previs datetime NULL
    this_cTitulos   = ""   && titulos char(50) NOT NULL

    *-- Parametros de contexto recebidos pelo form chamador
    this_cSetor     = ""   && Fase/Setor (contexto do form)
    this_cUnidade   = ""   && Unidade de producao (vazio = todas)

    *-- Dados de capacidade agregados (SigCdPcP por data/fase/unidade)
    this_nCapacidade  = 0  && Capacidade total em minutos
    this_nUtilizado   = 0  && Minutos utilizados (minutos - saldos)
    this_nSaldo       = 0  && Saldo de minutos

    *-- Dados do produto da linha selecionada no grid
    this_cDescricaoProduto = ""   && Dpros de SigCdPro
    this_cFotoArquivo      = ""   && Caminho temporario do JPEG decodificado

    *-- Dados exibidos abaixo do grid (linha corrente de zTmpPcpOp)
    this_nQtde          = 0   && Qtds da ordem
    this_cClienteNome   = ""  && Rclis do cliente
    this_nTempoEnvelope = 0   && TempU (tempo total do envelope em minutos)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPcz"
        THIS.this_cCampoChave = "codigos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (SigCdPcz.codigos)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(TRANSFORM(THIS.this_nCodigo))
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas de SigCdPcz para as
    * propriedades do BO. Recebe o alias do cursor aberto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nCodigo   = NVL(codigos, 0)
            THIS.this_cContas   = NVL(contas, "")
            THIS.this_cCvens    = NVL(cvens, "")
            THIS.this_dData     = NVL(datas, {})
            THIS.this_cDopes    = NVL(dopes, "")
            THIS.this_dDtLancs  = NVL(dtlancs, {})
            THIS.this_dEmissaoF = NVL(emissaof, {})
            THIS.this_dEmissaoI = NVL(emissaoi, {})
            THIS.this_cEmps     = NVL(emps, "")
            THIS.this_nNumeFs   = NVL(numefs, 0)
            THIS.this_nNumeIs   = NVL(numeis, 0)
            THIS.this_dPrevFs   = NVL(prevfs, {})
            THIS.this_dPrevIs   = NVL(previs, {})
            THIS.this_cTitulos  = NVL(titulos, "")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um novo registro de processo em SigCdPcz.
    * Retorna .T. se sucesso, .F. em falha.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmpresa
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                        "Erro sigprcpdBO.Inserir")
            ELSE
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
                IF EMPTY(loc_cEmpresa)
                    loc_cEmpresa = ALLTRIM(THIS.this_cEmps)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdPcz (" + ;
                    "codigos, contas, cvens, datas, dopes, dtlancs, " + ;
                    "emissaof, emissaoi, emps, numefs, numeis, " + ;
                    "prevfs, previs, titulos" + ;
                    ") VALUES (" + ;
                    FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cCvens, 10)) + ", " + ;
                    FormatarDataSQL(THIS.this_dData) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                    FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                    FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                    FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                    EscaparSQL(LEFT(loc_cEmpresa, 3)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNumeFs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNumeIs, 0) + ", " + ;
                    FormatarDataSQL(THIS.this_dPrevFs) + ", " + ;
                    FormatarDataSQL(THIS.this_dPrevIs) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cTitulos, 50)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Falha ao inserir processo em SigCdPcz.", ;
                            "Erro sigprcpdBO.Inserir")
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro sigprcpdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o registro corrente em SigCdPcz (chave: codigos).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                        "Erro sigprcpdBO.Atualizar")
            ELSE
                IF THIS.this_nCodigo <= 0
                    MsgAviso("Processo sem c" + CHR(243) + "digo: use Inserir para gravar novo registro.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_cSQL = "UPDATE SigCdPcz SET " + ;
                        "contas = "   + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                        "cvens = "    + EscaparSQL(LEFT(THIS.this_cCvens, 10)) + ", " + ;
                        "datas = "    + FormatarDataSQL(THIS.this_dData) + ", " + ;
                        "dopes = "    + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                        "dtlancs = "  + FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                        "emissaof = " + FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                        "emissaoi = " + FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                        "numefs = "   + FormatarNumeroSQL(THIS.this_nNumeFs, 0) + ", " + ;
                        "numeis = "   + FormatarNumeroSQL(THIS.this_nNumeIs, 0) + ", " + ;
                        "prevfs = "   + FormatarDataSQL(THIS.this_dPrevFs) + ", " + ;
                        "previs = "   + FormatarDataSQL(THIS.this_dPrevIs) + ", " + ;
                        "titulos = "  + EscaparSQL(LEFT(THIS.this_cTitulos, 50)) + " " + ;
                        "WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        MsgErro("Falha ao atualizar processo em SigCdPcz.", ;
                                "Erro sigprcpdBO.Atualizar")
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro sigprcpdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_oErro, loc_cSQL, loc_cUsuario, loc_cChave

        TRY
            IF gnConnHandle > 0
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
                loc_cChave   = THIS.ObterChavePrimaria()

                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                    "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                    "VALUES (GETDATE(), " + ;
                    EscaparSQL(loc_cUsuario) + ", " + ;
                    EscaparSQL("SigCdPcz") + ", " + ;
                    EscaparSQL(par_cOperacao) + ", " + ;
                    EscaparSQL(loc_cChave) + ")"

                =SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper fluxo principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega todos os cursores de capacidade produtiva
    * Par?metros: par_nCodigo (SigCdPcz.codigos), par_cFase, par_cUnidade, par_dData
    * Retorna: .T. se sucesso, .F. se falha
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_nCodigo, par_cFase, par_cUnidade, par_dData)
        LOCAL loc_lSucesso, loc_lCont, loc_cSQL, loc_cFiltro, loc_cFiltroA
        loc_lSucesso = .F.
        loc_lCont    = .T.
        loc_cFiltro  = ""
        loc_cFiltroA = ""

        TRY
            THIS.this_nCodigo  = par_nCodigo
            THIS.this_cSetor   = par_cFase
            THIS.this_cUnidade = par_cUnidade
            THIS.this_dData    = par_dData

            IF !EMPTY(par_cUnidade)
                loc_cFiltro  = " AND UniPrdts = " + EscaparSQL(par_cUnidade)
                loc_cFiltroA = " AND a.UniPrdts = " + EscaparSQL(par_cUnidade)
            ENDIF

            *-- 1. Processo (SigCdPcz)
            IF loc_lCont
                loc_cSQL = "SELECT * FROM SigCdPcz WHERE codigos = " + ;
                           FormatarNumeroSQL(par_nCodigo, 0)

                IF USED("cursor_4c_Processo")
                    USE IN cursor_4c_Processo
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Processo") < 1
                    MsgErro("Falha ao carregar processo (SigCdPcz).", "Erro")
                    loc_lCont = .F.
                ENDIF
            ENDIF

            *-- 2. Capacidade agregada (SigCdPcP): minutos, utilizados, saldos
            IF loc_lCont
                loc_cSQL = "SELECT Codigos, " + ;
                           "SUM(minutos) AS Minutos, " + ;
                           "SUM(minutos - Saldos) AS Utilizados, " + ;
                           "SUM(saldos) AS Saldos " + ;
                           "FROM SigCdPcP " + ;
                           "WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
                           " AND Datas = " + FormatarDataSQL(par_dData) + ;
                           " AND Fases = " + EscaparSQL(par_cFase) + ;
                           loc_cFiltro + ;
                           " GROUP BY Codigos"

                IF USED("cursor_4c_Capacidade")
                    USE IN cursor_4c_Capacidade
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Capacidade") < 1
                    MsgErro("Falha ao carregar capacidade (SigCdPcP).", "Erro")
                    loc_lCont = .F.
                ELSE
                    SELECT cursor_4c_Capacidade
                    GO TOP
                    IF !EOF()
                        THIS.this_nCapacidade = NVL(Minutos, 0)
                        THIS.this_nUtilizado  = NVL(Utilizados, 0)
                        THIS.this_nSaldo      = NVL(Saldos, 0)
                    ENDIF
                ENDIF
            ENDIF

            *-- 3. Grade de sequ" + CHR(234) + "ncias (SigCdPcg)
            IF loc_lCont
                loc_cSQL = "SELECT * FROM SigCdPcg " + ;
                           "WHERE datas = " + FormatarDataSQL(par_dData) + ;
                           " AND Fases = " + EscaparSQL(par_cFase) + ;
                           " AND Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
                           loc_cFiltro + ;
                           " ORDER BY Cidchaves"

                IF USED("cursor_4c_Grade")
                    USE IN cursor_4c_Grade
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grade") < 1
                    MsgErro("Falha ao carregar grade (SigCdPcg).", "Erro")
                    loc_lCont = .F.
                ENDIF
            ENDIF

            *-- 4. Ordens com cliente (SigCdPco JOIN SigCdCli)
            IF loc_lCont
                loc_cSQL = "SELECT a.*, " + ;
                           "a.dopes + '-' + STR(a.numes, 6) AS Pedido, " + ;
                           "a.contas + '-' + b.rclis AS cliente, " + ;
                           "b.Rclis " + ;
                           "FROM SigCdPco a, SigCdCli b " + ;
                           "WHERE a.Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
                           " AND a.Fases = " + EscaparSQL(par_cFase) + ;
                           loc_cFiltroA + ;
                           " AND a.Contas = b.Iclis " + ;
                           "ORDER BY a.UniPrdts, a.Seqs, a.Nenvs"

                IF USED("cursor_4c_OrdensTemp")
                    USE IN cursor_4c_OrdensTemp
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OrdensTemp") < 1
                    MsgErro("Falha ao carregar ordens (SigCdPco).", "Erro")
                    loc_lCont = .F.
                ENDIF
            ENDIF

            *-- 5. Agrupamento por envelope/seq (SELECT VFP local)
            IF loc_lCont
                IF USED("cursor_4c_GrupoOp")
                    USE IN cursor_4c_GrupoOp
                ENDIF

                SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, ;
                       SUM(a.Minutos) AS Minutos ;
                FROM cursor_4c_OrdensTemp a, cursor_4c_Grade b ;
                WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                      b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
                GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs ;
                INTO CURSOR cursor_4c_GrupoOp READWRITE
            ENDIF

            *-- 6. Cursor final do grid com TempoReal proporcional (SELECT VFP local)
            IF loc_lCont
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                       IIF(c.Minutos = 0, 0, ;
                           (a.minutos * 60) / (c.Minutos * 60) * (b.Minutos * 60)) AS TempoReal ;
                FROM cursor_4c_OrdensTemp a, cursor_4c_Grade b, cursor_4c_GrupoOp c ;
                WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                      b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
                AND   a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                      c.Fases + c.UniPrdts + STR(c.Nenvs,10) + STR(c.Seqs,2) ;
                ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs ;
                INTO CURSOR cursor_4c_Dados READWRITE

                SELECT cursor_4c_Dados
                GO TOP

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarFotoProduto - Carrega foto e descri" + CHR(231) + CHR(227) + "o do produto selecionado no grid
    * Par?metro: par_cCpros - c?digo do produto (SigCdPro.Cpros)
    * Retorna: .T. se sucesso
    * Efeitos: popula this_cDescricaoProduto e this_cFotoArquivo
    *--------------------------------------------------------------------------
    FUNCTION CarregarFotoProduto(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_cArqTemp, loc_cFotoBase64
        loc_lSucesso = .F.
        THIS.this_cDescricaoProduto = ""
        THIS.this_cFotoArquivo      = ""

        TRY
            loc_cSQL = "SELECT FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + ;
                       EscaparSQL(ALLTRIM(par_cCpros))

            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto") >= 1
                SELECT cursor_4c_Produto
                GO TOP

                IF !EOF()
                    THIS.this_cDescricaoProduto = NVL(Dpros, "")

                    IF !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
                        loc_cArqTemp    = SYS(2023) + "\sigprcpd.jpg"
                        loc_cFotoBase64 = STRCONV(;
                            STRTRAN(;
                                STRTRAN(;
                                    STRTRAN(FigJpgs, "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)

                        IF STRTOFILE(loc_cFotoBase64, loc_cArqTemp) > 0
                            THIS.this_cFotoArquivo = loc_cArqTemp
                        ENDIF
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar foto do produto")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

