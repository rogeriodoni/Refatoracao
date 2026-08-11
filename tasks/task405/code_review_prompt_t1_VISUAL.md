# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 225: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 245: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 265: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 285: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 318: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 338: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 358: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormEnd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2039 linhas total):

*-- Linhas 106 a 114:
106:                     VARTYPE(THIS.this_oBusinessObject), "FormEnd.InicializarForm")
107:             ELSE
108:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
109:                 THIS.Caption = "Cadastro de Endere" + CHR(231) + "os"
110: 
111:                 *-- Carregar flags de configuracao do grupo
112:                 THIS.this_oBusinessObject.CarregarConfigGrupo(THIS.this_cGrupo)
113:                 THIS.this_nCepObris = THIS.this_oBusinessObject.this_nCepObris
114:                 THIS.this_nChkEndDs = THIS.this_oBusinessObject.this_nChkEndDs

*-- Linhas 143 a 194:
143:     *==================================================================
144:     * ConfigurarCabecalho - Container cinza escuro com titulo do form
145:     *==================================================================
146:     PROTECTED PROCEDURE ConfigurarCabecalho()
147:         LOCAL loc_oCnt
148:         THIS.AddObject("cnt_4c_Sombra", "Container")
149:         loc_oCnt = THIS.cnt_4c_Sombra
150:         WITH loc_oCnt
151:             .Top         = -1
152:             .Left        = 0
153:             .Width       = THIS.Width
154:             .Height      = 80
155:             .BorderWidth = 0
156:             .BackColor   = RGB(100, 100, 100)
157:             .Visible     = .T.
158:         ENDWITH
159:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
160:         WITH loc_oCnt.lbl_4c_Sombra
161:             .FontBold      = .T.
162:             .FontName      = "Tahoma"
163:             .FontSize      = 18
164:             .FontUnderline = .F.
165:             .WordWrap      = .T.
166:             .Alignment     = 0
167:             .BackStyle     = 0
168:             .AutoSize      = .F.
169:             .Caption       = "Cadastro de Endere" + CHR(231) + "os"
170:             .Height        = 40
171:             .Left          = 10
172:             .Top           = 18
173:             .Width         = 769
174:             .ForeColor     = RGB(0, 0, 0)
175:             .Visible       = .T.
176:         ENDWITH
177:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
178:         WITH loc_oCnt.lbl_4c_Titulo
179:             .FontBold   = .T.
180:             .FontName   = "Tahoma"
181:             .FontSize   = 18
182:             .WordWrap   = .T.
183:             .Alignment  = 0
184:             .BackStyle  = 0
185:             .AutoSize   = .F.
186:             .Caption    = "Cadastro de Endere" + CHR(231) + "os"
187:             .Height     = 46
188:             .Left       = 10
189:             .Top        = 17
190:             .Width      = 769
191:             .ForeColor  = RGB(255, 255, 255)
192:             .Visible    = .T.
193:         ENDWITH
194:     ENDPROC

*-- Linhas 203 a 385:
203:         THIS.AddObject("cnt_4c_Escolha", "Container")
204:         loc_oCnt = THIS.cnt_4c_Escolha
205:         WITH loc_oCnt
206:             .Top         = -3
207:             .Left        = 270
208:             .Width       = 310
209:             .Height      = 85
210:             .BackStyle   = 0
211:             .BorderWidth = 0
212:             .Visible     = .T.
213:         ENDWITH
214: 
215:         loc_oCnt.AddObject("btn_4c_Inserir", "CommandButton")
216:         WITH loc_oCnt.btn_4c_Inserir
217:             .Top         = 5
218:             .Left        = 5
219:             .Width       = 75
220:             .Height      = 75
221:             .Caption     = "\<Inserir"
222:             .Picture     = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
223:             .FontBold    = .T.
224:             .FontItalic  = .T.
225:             .FontName    = "Comic Sans MS"
226:             .FontSize    = 8
227:             .WordWrap    = .T.
228:             .ForeColor   = RGB(90, 90, 90)
229:             .BackColor   = RGB(255, 255, 255)
230:             .Themes      = .F.
231:             .ToolTipText = "Inserir Um Novo Local de Entrega"
232:             .Visible     = .T.
233:         ENDWITH
234: 
235:         loc_oCnt.AddObject("btn_4c_Alterar", "CommandButton")
236:         WITH loc_oCnt.btn_4c_Alterar
237:             .Top         = 5
238:             .Left        = 80
239:             .Width       = 75
240:             .Height      = 75
241:             .Caption     = "\<Alterar"
242:             .Picture     = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
243:             .FontBold    = .T.
244:             .FontItalic  = .T.
245:             .FontName    = "Comic Sans MS"
246:             .FontSize    = 8
247:             .WordWrap    = .T.
248:             .ForeColor   = RGB(90, 90, 90)
249:             .BackColor   = RGB(255, 255, 255)
250:             .Themes      = .F.
251:             .ToolTipText = "Alterar o Local de Entrega"
252:             .Visible     = .T.
253:         ENDWITH
254: 
255:         loc_oCnt.AddObject("btn_4c_Excluir", "CommandButton")
256:         WITH loc_oCnt.btn_4c_Excluir
257:             .Top         = 5
258:             .Left        = 155
259:             .Width       = 75
260:             .Height      = 75
261:             .Caption     = "\<Excluir"
262:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
263:             .FontBold    = .T.
264:             .FontItalic  = .T.
265:             .FontName    = "Comic Sans MS"
266:             .FontSize    = 8
267:             .WordWrap    = .T.
268:             .ForeColor   = RGB(90, 90, 90)
269:             .BackColor   = RGB(255, 255, 255)
270:             .Themes      = .F.
271:             .ToolTipText = "Excluir o Local de Entrega"
272:             .Visible     = .T.
273:         ENDWITH
274: 
275:         loc_oCnt.AddObject("btn_4c_Copiar", "CommandButton")
276:         WITH loc_oCnt.btn_4c_Copiar
277:             .Top         = 5
278:             .Left        = 230
279:             .Width       = 75
280:             .Height      = 75
281:             .Caption     = "C\<opiar"
282:             .Picture     = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
283:             .FontBold    = .T.
284:             .FontItalic  = .T.
285:             .FontName    = "Comic Sans MS"
286:             .FontSize    = 8
287:             .WordWrap    = .T.
288:             .ForeColor   = RGB(90, 90, 90)
289:             .BackColor   = RGB(255, 255, 255)
290:             .Themes      = .F.
291:             .ToolTipText = "Copiar o Endere" + CHR(231) + "o Principal"
292:             .Visible     = .T.
293:         ENDWITH
294: 
295:         *-- cnt_4c_Salva: Salvar / Cancelar / Encerrar
296:         THIS.AddObject("cnt_4c_Salva", "Container")
297:         loc_oCnt = THIS.cnt_4c_Salva
298:         WITH loc_oCnt
299:             .Top         = -3
300:             .Left        = 571
301:             .Width       = 234
302:             .Height      = 85
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         loc_oCnt.AddObject("btn_4c_Salvar", "CommandButton")
309:         WITH loc_oCnt.btn_4c_Salvar
310:             .Top         = 5
311:             .Left        = 5
312:             .Width       = 75
313:             .Height      = 75
314:             .Caption     = "\<Salvar"
315:             .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
316:             .FontBold    = .T.
317:             .FontItalic  = .T.
318:             .FontName    = "Comic Sans MS"
319:             .FontSize    = 8
320:             .WordWrap    = .T.
321:             .ForeColor   = RGB(90, 90, 90)
322:             .BackColor   = RGB(255, 255, 255)
323:             .Themes      = .F.
324:             .ToolTipText = "Gravar os Dados"
325:             .Visible     = .T.
326:         ENDWITH
327: 
328:         loc_oCnt.AddObject("btn_4c_Cancelar", "CommandButton")
329:         WITH loc_oCnt.btn_4c_Cancelar
330:             .Top         = 5
331:             .Left        = 79
332:             .Width       = 75
333:             .Height      = 75
334:             .Caption     = "\<Cancelar"
335:             .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
336:             .FontBold    = .T.
337:             .FontItalic  = .T.
338:             .FontName    = "Comic Sans MS"
339:             .FontSize    = 8
340:             .WordWrap    = .T.
341:             .ForeColor   = RGB(90, 90, 90)
342:             .BackColor   = RGB(255, 255, 255)
343:             .Themes      = .F.
344:             .ToolTipText = "Cancelar os Dados"
345:             .Visible     = .T.
346:         ENDWITH
347: 
348:         loc_oCnt.AddObject("btn_4c_Encerrar", "CommandButton")
349:         WITH loc_oCnt.btn_4c_Encerrar
350:             .Top         = 5
351:             .Left        = 154
352:             .Width       = 75
353:             .Height      = 75
354:             .Caption     = "Encerrar"
355:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
356:             .FontBold    = .T.
357:             .FontItalic  = .T.
358:             .FontName    = "Comic Sans MS"
359:             .FontSize    = 8
360:             .WordWrap    = .T.
361:             .ForeColor   = RGB(90, 90, 90)
362:             .BackColor   = RGB(255, 255, 255)
363:             .Themes      = .F.
364:             .ToolTipText = "Sair do Cadastro"
365:             .Visible     = .T.
366:         ENDWITH
367:     ENDPROC
368: 
369:     *==================================================================
370:     * ConfigurarGrid - grd_4c_Locais com Column1=CheckBox e Column2=Descrs
371:     *==================================================================
372:     PROTECTED PROCEDURE ConfigurarGrid()
373:         LOCAL loc_oGrid
374: 
375:         THIS.AddObject("grd_4c_Locais", "Grid")
376:         loc_oGrid = THIS.grd_4c_Locais
377: 
378:         WITH loc_oGrid
379:             .Top               = 143
380:             .Left              = 149
381:             .Width             = 541
382:             .Height            = 148
383:             .ColumnCount       = 2
384:             .FontName          = "Tahoma"
385:             .FontSize          = 8

*-- Linhas 394 a 425:
394:             .Visible           = .T.
395:         ENDWITH
396: 
397:         *-- Column1: CheckBox para campo Atuals (marcacao do endereco ativo)
398:         WITH loc_oGrid.Column1
399:             .Width     = 15
400:             .ReadOnly  = .F.
401:             .Sparse    = .F.
402:             .Movable   = .F.
403:             .Resizable = .F.
404:             .AddObject("Check1", "CheckBox")
405:             .Check1.Top       = 9
406:             .Check1.Left      = 2
407:             .Check1.Height    = 17
408:             .Check1.Width     = 22
409:             .Check1.Alignment = 0
410:             .Check1.Caption   = ""
411:             .Check1.Alignment = 0
412:             .Check1.Top       = 9
413:             .Check1.Left      = 2
414:             .Check1.Height    = 17
415:             .Check1.Width     = 22
416:             .Check1.ReadOnly  = .F.
417:             .Check1.Visible   = .T.
418:             .Check1.Value     = 0
419:             .CurrentControl   = "Check1"
420:             .Header1.Caption  = ""
421:             .Header1.Alignment = 2
422:             .Header1.FontName = "Tahoma"
423:             .Header1.FontSize = 8
424:             .ControlSource    = "crGrade.Atuals"
425:         ENDWITH

*-- Linhas 431 a 439:
431:             .Sparse    = .F.
432:             .Movable   = .F.
433:             .Resizable = .F.
434:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
435:             .Header1.Alignment = 2
436:             .Header1.FontName  = "Tahoma"
437:             .Header1.FontSize  = 8
438:             .ControlSource     = "crGrade.Descrs"
439:         ENDWITH

*-- Linhas 461 a 470:
461:         THIS.AddObject("txt_4c_Codigos", "TextBox")
462:         WITH THIS.txt_4c_Codigos
463:             .Enabled           = .F.
464:             .Left              = 148
465:             .Top               = 97
466:             .Width             = 80
467:             .Height            = 23
468:             .SpecialEffect     = 1
469:             .DisabledBackColor = RGB(255, 255, 230)
470:             .DisabledForeColor = RGB(0, 0, 0)

*-- Linhas 476 a 499:
476:         THIS.AddObject("txt_4c_Nomes", "TextBox")
477:         WITH THIS.txt_4c_Nomes
478:             .Enabled           = .F.
479:             .Left              = 323
480:             .Top               = 97
481:             .Width             = 367
482:             .Height            = 23
483:             .Format            = "K!"
484:             .DisabledBackColor = RGB(255, 255, 230)
485:             .DisabledForeColor = RGB(0, 0, 0)
486:             .Visible           = .T.
487:             .Value             = ALLTRIM(THIS.this_cNome)
488:         ENDWITH
489: 
490:         *-- txt_4c_Paises: pais (ControlSource = crCursorCliEE.Paises)
491:         THIS.AddObject("txt_4c_Paises", "TextBox")
492:         WITH THIS.txt_4c_Paises
493:             .Left              = 148
494:             .Top               = 312
495:             .Width             = 175
496:             .Height            = 23
497:             .Format            = "K!"
498:             .SpecialEffect     = 1
499:             .TabIndex          = 8

*-- Linhas 506 a 515:
506:         *-- txt_4c_Ceps: CEP (InputMask padrao CEP)
507:         THIS.AddObject("txt_4c_Ceps", "TextBox")
508:         WITH THIS.txt_4c_Ceps
509:             .Left              = 396
510:             .Top               = 312
511:             .Width             = 80
512:             .Height            = 23
513:             .InputMask         = "99999-999"
514:             .SpecialEffect     = 1
515:             .TabIndex          = 10

*-- Linhas 522 a 531:
522:         *-- txt_4c_Endes: logradouro
523:         THIS.AddObject("txt_4c_Endes", "TextBox")
524:         WITH THIS.txt_4c_Endes
525:             .Left              = 148
526:             .Top               = 337
527:             .Width             = 430
528:             .Height            = 23
529:             .Format            = "K!"
530:             .SpecialEffect     = 1
531:             .TabIndex          = 12

*-- Linhas 538 a 547:
538:         *-- txt_4c_Nums: numero
539:         THIS.AddObject("txt_4c_Nums", "TextBox")
540:         WITH THIS.txt_4c_Nums
541:             .Left              = 606
542:             .Top               = 337
543:             .Width             = 80
544:             .Height            = 23
545:             .SpecialEffect     = 1
546:             .TabIndex          = 14
547:             .DisabledBackColor = RGB(255, 255, 230)

*-- Linhas 553 a 562:
553:         *-- txt_4c_Compls: complemento
554:         THIS.AddObject("txt_4c_Compls", "TextBox")
555:         WITH THIS.txt_4c_Compls
556:             .Left              = 148
557:             .Top               = 362
558:             .Width             = 185
559:             .Height            = 23
560:             .Format            = "K!"
561:             .SpecialEffect     = 1
562:             .TabIndex          = 16

*-- Linhas 569 a 578:
569:         *-- txt_4c_Bairs: bairro
570:         THIS.AddObject("txt_4c_Bairs", "TextBox")
571:         WITH THIS.txt_4c_Bairs
572:             .Left              = 396
573:             .Top               = 362
574:             .Width             = 290
575:             .Height            = 23
576:             .Format            = "K!"
577:             .SpecialEffect     = 1
578:             .TabIndex          = 18

*-- Linhas 585 a 594:
585:         *-- txt_4c_Cidas: cidade
586:         THIS.AddObject("txt_4c_Cidas", "TextBox")
587:         WITH THIS.txt_4c_Cidas
588:             .Left              = 148
589:             .Top               = 387
590:             .Width             = 224
591:             .Height            = 23
592:             .Format            = "K!"
593:             .SpecialEffect     = 1
594:             .TabIndex          = 20

*-- Linhas 601 a 610:
601:         *-- txt_4c_Estas: UF (2 chars, caixa alta, Valid abre picker)
602:         THIS.AddObject("txt_4c_Estas", "TextBox")
603:         WITH THIS.txt_4c_Estas
604:             .Left              = 444
605:             .Top               = 387
606:             .Width             = 24
607:             .Height            = 23
608:             .Format            = "K!"
609:             .MaxLength         = 2
610:             .SpecialEffect     = 1

*-- Linhas 618 a 627:
618:         *-- txt_4c_Contatos: contato
619:         THIS.AddObject("txt_4c_Contatos", "TextBox")
620:         WITH THIS.txt_4c_Contatos
621:             .Left              = 536
622:             .Top               = 387
623:             .Width             = 150
624:             .Height            = 23
625:             .Format            = "K!"
626:             .SpecialEffect     = 1
627:             .TabIndex          = 24

*-- Linhas 634 a 643:
634:         *-- txt_4c_Ddds: DDD
635:         THIS.AddObject("txt_4c_Ddds", "TextBox")
636:         WITH THIS.txt_4c_Ddds
637:             .Left              = 148
638:             .Top               = 412
639:             .Width             = 38
640:             .Height            = 23
641:             .Format            = "K!"
642:             .SpecialEffect     = 1
643:             .TabIndex          = 26

*-- Linhas 650 a 659:
650:         *-- txt_4c_Tel1s: telefone 1
651:         THIS.AddObject("txt_4c_Tel1s", "TextBox")
652:         WITH THIS.txt_4c_Tel1s
653:             .Left              = 282
654:             .Top               = 412
655:             .Width             = 150
656:             .Height            = 23
657:             .Format            = "K!"
658:             .MaxLength         = 20
659:             .SpecialEffect     = 1

*-- Linhas 667 a 676:
667:         *-- txt_4c_Tel2s: telefone 2
668:         THIS.AddObject("txt_4c_Tel2s", "TextBox")
669:         WITH THIS.txt_4c_Tel2s
670:             .Left              = 536
671:             .Top               = 412
672:             .Width             = 150
673:             .Height            = 23
674:             .Format            = "K!"
675:             .MaxLength         = 20
676:             .SpecialEffect     = 1

*-- Linhas 684 a 693:
684:         *-- edt_4c_Refers: observacoes / referencias (EditBox para campo Memo)
685:         THIS.AddObject("edt_4c_Refers", "EditBox")
686:         WITH THIS.edt_4c_Refers
687:             .Left              = 148
688:             .Top               = 437
689:             .Width             = 538
690:             .Height            = 58
691:             .SpecialEffect     = 1
692:             .TabIndex          = 32
693:             .DisabledBackColor = RGB(255, 255, 230)

*-- Linhas 702 a 880:
702:     *==================================================================
703:     PROTECTED PROCEDURE ConfigurarLabels()
704:         *-- "Codigo :" (Say1) - IClis
705:         THIS.AddObject("lbl_4c_Codigo", "Label")
706:         WITH THIS.lbl_4c_Codigo
707:             .FontName = "Verdana"
708:             .Caption  = "C" + CHR(243) + "digo :"
709:             .Left     = 92
710:             .Top      = 101
711:             .AutoSize = .T.
712:             .Visible  = .T.
713:         ENDWITH
714: 
715:         *-- "Local :" (Say3) - acima do grid
716:         THIS.AddObject("lbl_4c_Local", "Label")
717:         WITH THIS.lbl_4c_Local
718:             .FontName = "Verdana"
719:             .Caption  = "Local :"
720:             .Left     = 103
721:             .Top      = 146
722:             .AutoSize = .T.
723:             .Visible  = .T.
724:         ENDWITH
725: 
726:         *-- "Nome :" (Say2) - nome do cliente
727:         THIS.AddObject("lbl_4c_Nome", "Label")
728:         WITH THIS.lbl_4c_Nome
729:             .FontName = "Verdana"
730:             .Caption  = "Nome :"
731:             .Left     = 277
732:             .Top      = 98
733:             .AutoSize = .T.
734:             .Visible  = .T.
735:         ENDWITH
736: 
737:         *-- "Pais :" (Say15)
738:         THIS.AddObject("lbl_4c_Pais", "Label")
739:         WITH THIS.lbl_4c_Pais
740:             .FontName = "Verdana"
741:             .Caption  = "Pa" + CHR(237) + "s :"
742:             .Left     = 109
743:             .Top      = 316
744:             .AutoSize = .T.
745:             .Visible  = .T.
746:         ENDWITH
747: 
748:         *-- "CEP : " (Say6)
749:         THIS.AddObject("lbl_4c_Cep", "Label")
750:         WITH THIS.lbl_4c_Cep
751:             .FontName = "Verdana"
752:             .Caption  = "CEP : "
753:             .Left     = 361
754:             .Top      = 316
755:             .AutoSize = .T.
756:             .Visible  = .T.
757:         ENDWITH
758: 
759:         *-- "Endereco :" (Say4)
760:         THIS.AddObject("lbl_4c_Endereco", "Label")
761:         WITH THIS.lbl_4c_Endereco
762:             .FontName = "Verdana"
763:             .Caption  = "Endere" + CHR(231) + "o :"
764:             .Left     = 79
765:             .Top      = 341
766:             .AutoSize = .T.
767:             .Visible  = .T.
768:         ENDWITH
769: 
770:         *-- "n? :" (Say10)
771:         THIS.AddObject("lbl_4c_Num", "Label")
772:         WITH THIS.lbl_4c_Num
773:             .Caption  = "n" + CHR(186) + " :"
774:             .Left     = 583
775:             .Top      = 341
776:             .AutoSize = .T.
777:             .Visible  = .T.
778:         ENDWITH
779: 
780:         *-- "Complemento :" (Say18)
781:         THIS.AddObject("lbl_4c_Compl", "Label")
782:         WITH THIS.lbl_4c_Compl
783:             .FontName = "Verdana"
784:             .Caption  = "Complemento :"
785:             .Left     = 52
786:             .Top      = 366
787:             .AutoSize = .T.
788:             .Visible  = .T.
789:         ENDWITH
790: 
791:         *-- "Bairro : " (Say5)
792:         THIS.AddObject("lbl_4c_Bairro", "Label")
793:         WITH THIS.lbl_4c_Bairro
794:             .FontName = "Verdana"
795:             .Caption  = "Bairro : "
796:             .Left     = 350
797:             .Top      = 366
798:             .AutoSize = .T.
799:             .Visible  = .T.
800:         ENDWITH
801: 
802:         *-- "Cidade :" (Say7)
803:         THIS.AddObject("lbl_4c_Cidade", "Label")
804:         WITH THIS.lbl_4c_Cidade
805:             .FontName = "Verdana"
806:             .Caption  = "Cidade :"
807:             .Left     = 92
808:             .Top      = 391
809:             .AutoSize = .T.
810:             .Visible  = .T.
811:         ENDWITH
812: 
813:         *-- "Estado : " (Say8)
814:         THIS.AddObject("lbl_4c_Estado", "Label")
815:         WITH THIS.lbl_4c_Estado
816:             .FontName = "Verdana"
817:             .Caption  = "Estado : "
818:             .Left     = 393
819:             .Top      = 391
820:             .AutoSize = .T.
821:             .Visible  = .T.
822:         ENDWITH
823: 
824:         *-- "Contato :" (Say11)
825:         THIS.AddObject("lbl_4c_Contato", "Label")
826:         WITH THIS.lbl_4c_Contato
827:             .FontName = "Verdana"
828:             .Caption  = "Contato :"
829:             .Left     = 479
830:             .Top      = 391
831:             .AutoSize = .T.
832:             .Visible  = .T.
833:         ENDWITH
834: 
835:         *-- "DDD :" (Say13)
836:         THIS.AddObject("lbl_4c_Ddd", "Label")
837:         WITH THIS.lbl_4c_Ddd
838:             .FontName = "Verdana"
839:             .Caption  = "DDD :"
840:             .Left     = 105
841:             .Top      = 416
842:             .AutoSize = .T.
843:             .Visible  = .T.
844:         ENDWITH
845: 
846:         *-- "Telefone (1) :" (Say9)
847:         THIS.AddObject("lbl_4c_Tel1", "Label")
848:         WITH THIS.lbl_4c_Tel1
849:             .FontName = "Verdana"
850:             .Caption  = "Telefone (1) :"
851:             .Left     = 202
852:             .Top      = 416
853:             .AutoSize = .T.
854:             .Visible  = .T.
855:         ENDWITH
856: 
857:         *-- "Telefone (2) :" (Say12)
858:         THIS.AddObject("lbl_4c_Tel2", "Label")
859:         WITH THIS.lbl_4c_Tel2
860:             .FontName = "Verdana"
861:             .Caption  = "Telefone (2) :"
862:             .Left     = 456
863:             .Top      = 416
864:             .AutoSize = .T.
865:             .Visible  = .T.
866:         ENDWITH
867: 
868:         *-- "Observacao :" (Say14)
869:         THIS.AddObject("lbl_4c_Observ", "Label")
870:         WITH THIS.lbl_4c_Observ
871:             .FontName = "Tahoma"
872:             .Caption  = "Observa" + CHR(231) + CHR(227) + "o :"
873:             .Height   = 15
874:             .Left     = 76
875:             .Top      = 437
876:             .Width    = 67
877:             .AutoSize = .F.
878:             .ForeColor = RGB(90, 90, 90)
879:             .Visible  = .T.
880:         ENDWITH

*-- Linhas 898 a 906:
898:         *-- Grid: AfterRowColChange para sincronizar campos com linha corrente
899:         BINDEVENT(THIS.grd_4c_Locais, "AfterRowColChange", THIS, "GrdLocaisAfterRowColChange")
900: 
901:         *-- Checkbox Column1: controle manual do toggle Atuals
902:         BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "Click",     THIS, "GrdChkClick")
903:         BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "KeyPress",  THIS, "GrdChkKeyPress")
904:         BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "MouseDown", THIS, "GrdChkMouseDown")
905:         BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "MouseUp",   THIS, "GrdChkMouseUp")
906:         BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "KeyPress", THIS, "GrdChkLostFocus")

*-- Linhas 1114 a 1122:
1114:     ENDPROC
1115: 
1116:     *==================================================================
1117:     * AlternarAtual - Logica compartilhada para toggle do checkbox Atuals
1118:     * Chamado por GrdChkClick, GrdChkKeyPress, GrdChkMouseDown
1119:     *==================================================================
1120:     PROTECTED PROCEDURE AlternarAtual()
1121:         LOCAL loc_lAtuals, loc_lnCnt, loc_llMar
1122:         TRY


### BO (C:\4c\projeto\app\classes\EndBO.prg):
*==============================================================================
* EndBO.prg
*
* Business Object para Cadastro de Enderecos de Entrega (SIGCDCEE)
* Tabela: SIGCDCEE
* Herda de: BusinessBase
*
* Form OPERACIONAL: gerencia enderecos de entrega de clientes
* Chamado por: FormCliente (e outros forms de cadastro de clientes)
* Parametros: grupo, IClis, nome, modo, codigos
*==============================================================================

DEFINE CLASS EndBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para SIGCDCEE)
    this_lAtuals    = .F.   && atuals   bit          - endereco ativo/atual
    this_cBairs     = ""    && bairs    char(40)     - bairro
    this_cCeps      = ""    && ceps     char(9)      - CEP
    this_cCidas     = ""    && cidas    char(30)     - cidade
    this_nCodigos   = 0     && codigos  numeric(10,0) - codigo (PK)
    this_cCompls    = ""    && compls   char(50)     - complemento
    this_cContatos  = ""    && contatos char(20)     - contato
    this_cDdds      = ""    && ddds     char(4)      - DDD
    this_cDescrs    = ""    && descrs   char(50)     - descricao do local
    this_cEndes     = ""    && endes    char(60)     - endereco
    this_cEstas     = ""    && estas    char(2)      - estado (UF)
    this_cIClis     = ""    && iclis    char(10)     - codigo do cliente
    this_cNums      = ""    && nums     char(10)     - numero
    this_cPaises    = ""    && paises   char(30)     - pais
    this_cRefers    = ""    && refers   text         - observacoes
    this_cTel1s     = ""    && tel1s    char(20)     - telefone 1
    this_cTel2s     = ""    && tel2s    char(20)     - telefone 2
    this_cIdentrega = ""    && identrega char(50)    - identificador de entrega

    *-- Propriedades operacionais (nao persistidas - contexto do form)
    this_cNome           = ""    && nome do cliente (parametro pDes)
    this_cGrupo          = ""    && grupo do cliente (parametro pGru - para SigCdGcr)
    this_cModo           = ""    && modo: CONSULTAR/INSERIR/ALTERAR
    this_nCodigosBusca   = 0     && codigo do local a localizar (pCod)
    this_nCepObris       = 0     && flag CEP obrigatorio (SigCdGcr.cepobris)
    this_nChkEndDs       = 0     && flag verifica endereco duplicado (SigCdGcr.chkendds)
    this_nChkEndRs       = 0     && flag verifica bairro restrito (SigCdGcr.chkendrs)
    this_lTipoPais       = .F.   && .T. quando pais != BRASIL
    this_cTipoCep        = "1"   && tipo CEP
    this_lEntraInserindo = .F.   && flag: entrou em modo inserir automaticamente

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SIGCDCEE"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Mapeia registro do cursor para propriedades do BO
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos  = NVL(Codigos, 0)
                THIS.this_cIClis    = NVL(ALLTRIM(Iclis), "")
                THIS.this_lAtuals   = IIF(VARTYPE(Atuals) = "L", ;
                                        NVL(Atuals, .F.), NVL(Atuals, 0) <> 0)
                THIS.this_cDescrs   = NVL(ALLTRIM(Descrs), "")
                THIS.this_cCeps     = NVL(ALLTRIM(Ceps), "")
                THIS.this_cPaises   = NVL(ALLTRIM(Paises), "")
                THIS.this_cEndes    = NVL(ALLTRIM(Endes), "")
                THIS.this_cNums     = NVL(ALLTRIM(Nums), "")
                THIS.this_cCompls   = NVL(ALLTRIM(Compls), "")
                THIS.this_cBairs    = NVL(ALLTRIM(Bairs), "")
                THIS.this_cCidas    = NVL(ALLTRIM(Cidas), "")
                THIS.this_cEstas    = NVL(ALLTRIM(Estas), "")
                THIS.this_cDdds     = NVL(ALLTRIM(Ddds), "")
                THIS.this_cTel1s    = NVL(ALLTRIM(Tel1s), "")
                THIS.this_cTel2s    = NVL(ALLTRIM(Tel2s), "")
                THIS.this_cContatos = NVL(ALLTRIM(Contatos), "")
                THIS.this_cRefers   = NVL(Refers, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GerarCodigoUnico - Gera codigo unico para Codigos (PK) em SigCdCeE
    * Substitui fGerUniqueKey('SigCdCeE') do legado
    *====================================================================
    FUNCTION GerarCodigoUnico()
        LOCAL loc_nCodigo, loc_nRet
        loc_nCodigo = 0
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(Codigos), 0) + 1 AS ProxCodigo FROM SigCdCeE", ;
                "cursor_4c_ProxCodigo")
            IF loc_nRet > 0 AND !EOF("cursor_4c_ProxCodigo")
                SELECT cursor_4c_ProxCodigo
                loc_nCodigo = NVL(ProxCodigo, 1)
            ENDIF
            IF USED("cursor_4c_ProxCodigo")
                USE IN cursor_4c_ProxCodigo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.GerarCodigoUnico")
        ENDTRY
        RETURN loc_nCodigo
    ENDFUNC

    *====================================================================
    * Inserir - INSERT INTO SigCdCeE com todos os campos
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nCodigos <= 0
                THIS.this_nCodigos = THIS.GerarCodigoUnico()
            ENDIF
            IF THIS.this_nCodigos <= 0
                MsgErro("Falha ao gerar c" + CHR(243) + "digo para endere" + ;
                    CHR(231) + "o.", "EndBO.Inserir")
            ELSE
                loc_cSQL = "INSERT INTO SigCdCeE " + ;
                    "(Codigos, IClis, Atuals, Descrs, Ceps, Paises," + ;
                    " Endes, Nums, Compls, Bairs, Cidas, Estas," + ;
                    " Ddds, Tel1s, Tel2s, Contatos, Refers) " + ;
                    "VALUES (" + ;
                    FormatarNumeroSQL(THIS.this_nCodigos, 0) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cIClis, 10)) + "," + ;
                    IIF(THIS.this_lAtuals, "1", "0") + "," + ;
                    EscaparSQL(LEFT(THIS.this_cDescrs, 50)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cCeps, 9)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cPaises, 30)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cEndes, 60)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cNums, 10)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cCompls, 50)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cBairs, 40)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cCidas, 30)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cEstas, 2)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cDdds, 4)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cTel1s, 20)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cTel2s, 20)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cContatos, 20)) + "," + ;
                    EscaparSQL(THIS.this_cRefers) + ")"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha ao inserir endere" + CHR(231) + "o: " + ;
                        ALLTRIM(THIS.this_cDescrs), "EndBO.Inserir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE SigCdCeE com todos os campos
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdCeE SET " + ;
                "Atuals = " + IIF(THIS.this_lAtuals, "1", "0") + "," + ;
                "Descrs = " + EscaparSQL(LEFT(THIS.this_cDescrs, 50)) + "," + ;
                "Ceps = " + EscaparSQL(LEFT(THIS.this_cCeps, 9)) + "," + ;
                "Paises = " + EscaparSQL(LEFT(THIS.this_cPaises, 30)) + "," + ;
                "Endes = " + EscaparSQL(LEFT(THIS.this_cEndes, 60)) + "," + ;
                "Nums = " + EscaparSQL(LEFT(THIS.this_cNums, 10)) + "," + ;
                "Compls = " + EscaparSQL(LEFT(THIS.this_cCompls, 50)) + "," + ;
                "Bairs = " + EscaparSQL(LEFT(THIS.this_cBairs, 40)) + "," + ;
                "Cidas = " + EscaparSQL(LEFT(THIS.this_cCidas, 30)) + "," + ;
                "Estas = " + EscaparSQL(LEFT(THIS.this_cEstas, 2)) + "," + ;
                "Ddds = " + EscaparSQL(LEFT(THIS.this_cDdds, 4)) + "," + ;
                "Tel1s = " + EscaparSQL(LEFT(THIS.this_cTel1s, 20)) + "," + ;
                "Tel2s = " + EscaparSQL(LEFT(THIS.this_cTel2s, 20)) + "," + ;
                "Contatos = " + EscaparSQL(LEFT(THIS.this_cContatos, 20)) + "," + ;
                "Refers = " + EscaparSQL(THIS.this_cRefers) + " " + ;
                "WHERE IClis = " + EscaparSQL(THIS.this_cIClis) + ;
                " AND Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar endere" + CHR(231) + "o: " + ;
                    ALLTRIM(THIS.this_cDescrs), "EndBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE FROM SigCdCeE (chamado por Excluir da BusinessBase)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdCeE " + ;
                "WHERE IClis = " + EscaparSQL(THIS.this_cIClis) + ;
                " AND Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao excluir endere" + CHR(231) + "o: " + ;
                    ALLTRIM(THIS.this_cDescrs), "EndBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarEnderecos - Carrega enderecos do cliente em cursor crCursorCliEE
    * Equivale ao SELECT * FROM SigCdCeE do Init legado
    *====================================================================
    FUNCTION CarregarEnderecos(par_cIClis, par_nCodigo)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("crCursorCliEE")
                USE IN crCursorCliEE
            ENDIF
            DO CASE
                CASE par_nCodigo = 0
                    loc_cSQL = "SELECT * FROM SigCdCeE " + ;
                        "WHERE IClis = " + EscaparSQL(par_cIClis)
                OTHERWISE
                    loc_cSQL = "SELECT * FROM SigCdCeE " + ;
                        "WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                        " AND Codigos = " + FormatarNumeroSQL(par_nCodigo, 0)
            ENDCASE
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crCursorCliEE")
            IF loc_nRet > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar endere" + CHR(231) + "os do cliente " + ;
                    ALLTRIM(par_cIClis), "EndBO.CarregarEnderecos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.CarregarEnderecos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarConfigGrupo - Carrega flags de CepObris/ChkEndDs/ChkEndRs de SigCdGcr
    * Equivale ao SqlExecute de SigCdGcr no Init legado
    *====================================================================
    FUNCTION CarregarConfigGrupo(par_cGrupo)
        LOCAL loc_lSucesso, loc_nRet
        loc_lSucesso = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT CepObris, ChkEndds, ChkEndrs FROM SigCdGcr " + ;
                "WHERE codigos = " + EscaparSQL(par_cGrupo), ;
                "cursor_4c_ConfigGrupo")
            IF loc_nRet > 0 AND !EOF("cursor_4c_ConfigGrupo")
                SELECT cursor_4c_ConfigGrupo
                THIS.this_nCepObris = NVL(CepObris, 2)
                THIS.this_nChkEndDs = IIF(VARTYPE(ChkEndds) = "L", ;
                    IIF(ChkEndds, 1, 0), NVL(ChkEndds, 0))
                THIS.this_nChkEndRs = IIF(VARTYPE(ChkEndrs) = "L", ;
                    IIF(ChkEndrs, 1, 0), NVL(ChkEndrs, 0))
            ELSE
                THIS.this_nCepObris = 2
                THIS.this_nChkEndDs = 0
                THIS.this_nChkEndRs = 0
            ENDIF
            IF USED("cursor_4c_ConfigGrupo")
                USE IN cursor_4c_ConfigGrupo
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.CarregarConfigGrupo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarDuplicidade - Verifica se descricao do local ja existe para o cliente
    * Equivale ao SELECT Descrs FROM SigCdCeE WHERE IClis=... AND Descrs=... do m_confirmar
    *====================================================================
    FUNCTION VerificarDuplicidade(par_cIClis, par_cDescrs, par_nCodigos)
        LOCAL loc_lDuplicado, loc_nRet
        loc_lDuplicado = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nQtd FROM SigCdCeE " + ;
                "WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                " AND RTRIM(Descrs) = " + EscaparSQL(ALLTRIM(par_cDescrs)) + ;
                " AND Codigos <> " + FormatarNumeroSQL(par_nCodigos, 0), ;
                "cursor_4c_DupVerif")
            IF loc_nRet > 0 AND !EOF("cursor_4c_DupVerif")
                SELECT cursor_4c_DupVerif
                loc_lDuplicado = (NVL(nQtd, 0) > 0)
            ENDIF
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarDuplicidade")
        ENDTRY
        RETURN loc_lDuplicado
    ENDFUNC

    *====================================================================
    * VerificarEnderecoDuplicado - Verifica endereco duplicado (usado quando chkendds=1)
    * Equivale ao SELECT iclis FROM SigCdCee WHERE ceps=... AND endes=... do m_confirmar
    * Retorna string com IClis dos clientes que tem mesmo endereco (separados por espaco)
    *====================================================================
    FUNCTION VerificarEnderecoDuplicado(par_cIClis, par_cCep, par_cEnde, par_cBairro, par_nCodigos)
        LOCAL loc_cContas, loc_nRet
        loc_cContas = ""
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT RTRIM(IClis) AS IClis FROM SigCdCeE " + ;
                "WHERE Ceps = " + EscaparSQL(par_cCep) + ;
                " AND RTRIM(Endes) = " + EscaparSQL(ALLTRIM(par_cEnde)) + ;
                " AND RTRIM(Bairs) = " + EscaparSQL(ALLTRIM(par_cBairro)) + ;
                " AND Codigos <> " + FormatarNumeroSQL(par_nCodigos, 0), ;
                "cursor_4c_EndDup")
            IF loc_nRet > 0 AND !EOF("cursor_4c_EndDup")
                SELECT cursor_4c_EndDup
                SCAN
                    loc_cContas = loc_cContas + ALLTRIM(cursor_4c_EndDup.IClis) + " "
                ENDSCAN
            ENDIF
            IF USED("cursor_4c_EndDup")
                USE IN cursor_4c_EndDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarEnderecoDuplicado")
        ENDTRY
        RETURN ALLTRIM(loc_cContas)
    ENDFUNC

    *====================================================================
    * SalvarEnderecos - Sincroniza cursor crCursorCliEE com SigCdCeE no SQL Server
    * Substitui poDataMgr.Update('crCursorCliEE') do m_confirmar legado
    *====================================================================
    FUNCTION SalvarEnderecos(par_cIClis)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        LOCAL loc_lAtuals, loc_nCodigos, loc_cDescrs
        LOCAL loc_cCeps, loc_cPaises, loc_cEndes, loc_cNums
        LOCAL loc_cCompls, loc_cBairs, loc_cCidas, loc_cEstas
        LOCAL loc_cDdds, loc_cTel1s, loc_cTel2s, loc_cContatos, loc_cRefers
        LOCAL loc_nQtdExiste
        loc_lSucesso = .F.
        TRY
            IF !USED("crCursorCliEE")
                MsgErro("Cursor crCursorCliEE n" + CHR(227) + "o est" + CHR(225) + ;
                    " aberto.", "EndBO.SalvarEnderecos")
            ELSE
                THIS.ExcluirSigCdClt(par_cIClis)
                SELECT crCursorCliEE
                SCAN
                    IF !DELETED() AND !EMPTY(RTRIM(crCursorCliEE.Descrs))
                        loc_lAtuals   = IIF(VARTYPE(crCursorCliEE.Atuals) = "L", ;
                            crCursorCliEE.Atuals, crCursorCliEE.Atuals <> 0)
                        loc_nCodigos  = NVL(crCursorCliEE.Codigos, 0)
                        loc_cDescrs   = NVL(ALLTRIM(crCursorCliEE.Descrs), "")
                        loc_cCeps     = NVL(ALLTRIM(crCursorCliEE.Ceps), "")
                        loc_cPaises   = NVL(ALLTRIM(crCursorCliEE.Paises), "")
                        loc_cEndes    = NVL(ALLTRIM(crCursorCliEE.Endes), "")
                        loc_cNums     = NVL(ALLTRIM(crCursorCliEE.Nums), "")
                        loc_cCompls   = NVL(ALLTRIM(crCursorCliEE.Compls), "")
                        loc_cBairs    = NVL(ALLTRIM(crCursorCliEE.Bairs), "")
                        loc_cCidas    = NVL(ALLTRIM(crCursorCliEE.Cidas), "")
                        loc_cEstas    = NVL(ALLTRIM(crCursorCliEE.Estas), "")
                        loc_cDdds     = NVL(ALLTRIM(crCursorCliEE.Ddds), "")
                        loc_cTel1s    = NVL(ALLTRIM(crCursorCliEE.Tel1s), "")
                        loc_cTel2s    = NVL(ALLTRIM(crCursorCliEE.Tel2s), "")
                        loc_cContatos = NVL(ALLTRIM(crCursorCliEE.Contatos), "")
                        loc_cRefers   = NVL(crCursorCliEE.Refers, "")
                        IF loc_nCodigos <= 0
                            loc_nCodigos = THIS.GerarCodigoUnico()
                        ENDIF
                        loc_nRet = SQLEXEC(gnConnHandle, ;
                            "SELECT COUNT(*) AS nQtd FROM SigCdCeE " + ;
                            "WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                            " AND Codigos = " + FormatarNumeroSQL(loc_nCodigos, 0), ;
                            "cursor_4c_ExisteVerif")
                        loc_nQtdExiste = 0
                        IF loc_nRet > 0 AND !EOF("cursor_4c_ExisteVerif")
                            SELECT cursor_4c_ExisteVerif
                            loc_nQtdExiste = NVL(nQtd, 0)
                        ENDIF
                        IF USED("cursor_4c_ExisteVerif")
                            USE IN cursor_4c_ExisteVerif
                        ENDIF
                        IF loc_nQtdExiste > 0
                            loc_cSQL = "UPDATE SigCdCeE SET " + ;
                                "Atuals = " + IIF(loc_lAtuals, "1", "0") + "," + ;
                                "Descrs = " + EscaparSQL(LEFT(loc_cDescrs, 50)) + "," + ;
                                "Ceps = " + EscaparSQL(LEFT(loc_cCeps, 9)) + "," + ;
                                "Paises = " + EscaparSQL(LEFT(loc_cPaises, 30)) + "," + ;
                                "Endes = " + EscaparSQL(LEFT(loc_cEndes, 60)) + "," + ;
                                "Nums = " + EscaparSQL(LEFT(loc_cNums, 10)) + "," + ;
                                "Compls = " + EscaparSQL(LEFT(loc_cCompls, 50)) + "," + ;
                                "Bairs = " + EscaparSQL(LEFT(loc_cBairs, 40)) + "," + ;
                                "Cidas = " + EscaparSQL(LEFT(loc_cCidas, 30)) + "," + ;
                                "Estas = " + EscaparSQL(LEFT(loc_cEstas, 2)) + "," + ;
                                "Ddds = " + EscaparSQL(LEFT(loc_cDdds, 4)) + "," + ;
                                "Tel1s = " + EscaparSQL(LEFT(loc_cTel1s, 20)) + "," + ;
                                "Tel2s = " + EscaparSQL(LEFT(loc_cTel2s, 20)) + "," + ;
                                "Contatos = " + EscaparSQL(LEFT(loc_cContatos, 20)) + "," + ;
                                "Refers = " + EscaparSQL(loc_cRefers) + " " + ;
                                "WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                                " AND Codigos = " + FormatarNumeroSQL(loc_nCodigos, 0)
                        ELSE
                            loc_cSQL = "INSERT INTO SigCdCeE " + ;
                                "(Codigos, IClis, Atuals, Descrs, Ceps, Paises," + ;
                                " Endes, Nums, Compls, Bairs, Cidas, Estas," + ;
                                " Ddds, Tel1s, Tel2s, Contatos, Refers) " + ;
                                "VALUES (" + ;
                                FormatarNumeroSQL(loc_nCodigos, 0) + "," + ;
                                EscaparSQL(LEFT(par_cIClis, 10)) + "," + ;
                                IIF(loc_lAtuals, "1", "0") + "," + ;
                                EscaparSQL(LEFT(loc_cDescrs, 50)) + "," + ;
                                EscaparSQL(LEFT(loc_cCeps, 9)) + "," + ;
                                EscaparSQL(LEFT(loc_cPaises, 30)) + "," + ;
                                EscaparSQL(LEFT(loc_cEndes, 60)) + "," + ;
                                EscaparSQL(LEFT(loc_cNums, 10)) + "," + ;
                                EscaparSQL(LEFT(loc_cCompls, 50)) + "," + ;
                                EscaparSQL(LEFT(loc_cBairs, 40)) + "," + ;
                                EscaparSQL(LEFT(loc_cCidas, 30)) + "," + ;
                                EscaparSQL(LEFT(loc_cEstas, 2)) + "," + ;
                                EscaparSQL(LEFT(loc_cDdds, 4)) + "," + ;
                                EscaparSQL(LEFT(loc_cTel1s, 20)) + "," + ;
                                EscaparSQL(LEFT(loc_cTel2s, 20)) + "," + ;
                                EscaparSQL(LEFT(loc_cContatos, 20)) + "," + ;
                                EscaparSQL(loc_cRefers) + ")"
                        ENDIF
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    SELECT crCursorCliEE
                ENDSCAN
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCeE WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                    " AND (Descrs IS NULL OR RTRIM(Descrs) = '')")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.SalvarEnderecos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExcluirSigCdClt - Limpa SigCdClt do cliente antes de salvar enderecos
    * Equivale ao DELETE FROM SigCdClt WHERE IClis=... do m_confirmar legado
    *====================================================================
    PROTECTED PROCEDURE ExcluirSigCdClt(par_cIClis)
        LOCAL loc_cSQL
        TRY
            loc_cSQL = "DELETE FROM SigCdClt WHERE IClis = " + EscaparSQL(par_cIClis)
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.ExcluirSigCdClt")
        ENDTRY
    ENDPROC

    *====================================================================
    * ObterEnderecoPrincipal - Busca endereco principal do cliente em SigCdCli
    * Usado por m_CopiarP para copiar endereco do cadastro do cliente
    * Cursor resultado: cursor_4c_EndPrincipal
    *====================================================================
    FUNCTION ObterEnderecoPrincipal(par_cIClis)
        LOCAL loc_lSucesso, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_EndPrincipal")
                USE IN cursor_4c_EndPrincipal
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT Ceps, Paises, Endes, Nums, Compls," + ;
                " Bairs, Cidas, Estas, Ddds, Tel1s, Tel2s, Contato" + ;
                " FROM SigCdCli" + ;
                " WHERE IClis = " + EscaparSQL(par_cIClis), ;
                "cursor_4c_EndPrincipal")
            IF loc_nRet > 0 AND !EOF("cursor_4c_EndPrincipal")
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_EndPrincipal")
                    USE IN cursor_4c_EndPrincipal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.ObterEnderecoPrincipal")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarCepRestrito - Verifica se CEP consta em SigCdEnr (chkendrs=1)
    * Equivale ao SELECT * FROM SigCdEnr WHERE Ceps=... do getCeps.LostFocus legado
    *====================================================================
    FUNCTION VerificarCepRestrito(par_cCep)
        LOCAL loc_lRestrito, loc_nRet
        loc_lRestrito = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nQtd FROM SigCdEnr " + ;
                "WHERE Ceps = " + EscaparSQL(par_cCep), ;
                "cursor_4c_CepRestr")
            IF loc_nRet > 0 AND !EOF("cursor_4c_CepRestr")
                SELECT cursor_4c_CepRestr
                loc_lRestrito = (NVL(nQtd, 0) > 0)
            ENDIF
            IF USED("cursor_4c_CepRestr")
                USE IN cursor_4c_CepRestr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarCepRestrito")
        ENDTRY
        RETURN loc_lRestrito
    ENDFUNC

    *====================================================================
    * VerificarBairroRestrito - Verifica se bairro consta em SigCdEnr (chkendrs=1)
    * Equivale ao SELECT * FROM SigCdEnr WHERE Bairs=... do getBairs.LostFocus legado
    *====================================================================
    FUNCTION VerificarBairroRestrito(par_cBairro)
        LOCAL loc_lRestrito, loc_nRet
        loc_lRestrito = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nQtd FROM SigCdEnr " + ;
                "WHERE Bairs = " + EscaparSQL(par_cBairro), ;
                "cursor_4c_BaiRestr")
            IF loc_nRet > 0 AND !EOF("cursor_4c_BaiRestr")
                SELECT cursor_4c_BaiRestr
                loc_lRestrito = (NVL(nQtd, 0) > 0)
            ENDIF
            IF USED("cursor_4c_BaiRestr")
                USE IN cursor_4c_BaiRestr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarBairroRestrito")
        ENDTRY
        RETURN loc_lRestrito
    ENDFUNC

    *====================================================================
    * VerificarEnderecoRestrito - Verifica se logradouro consta em SigCdEnr (chkendrs=1)
    * Equivale ao SELECT * FROM SigCdEnr WHERE Endes=... do getEndes.LostFocus legado
    *====================================================================
    FUNCTION VerificarEnderecoRestrito(par_cEnde)
        LOCAL loc_lRestrito, loc_nRet
        loc_lRestrito = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nQtd FROM SigCdEnr " + ;
                "WHERE Endes = " + EscaparSQL(par_cEnde), ;
                "cursor_4c_EndRestr")
            IF loc_nRet > 0 AND !EOF("cursor_4c_EndRestr")
                SELECT cursor_4c_EndRestr
                loc_lRestrito = (NVL(nQtd, 0) > 0)
            ENDIF
            IF USED("cursor_4c_EndRestr")
                USE IN cursor_4c_EndRestr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarEnderecoRestrito")
        ENDTRY
        RETURN loc_lRestrito
    ENDFUNC

    *====================================================================
    * ListarEstados - Lista UFs de SigCdUfs para picker do campo Estado
    * Equivale ao fwBuscaExt('SigCdUfs', ...) do getEstas.Valid legado
    * Cursor resultado: cursor_4c_ListaEstados
    *====================================================================
    FUNCTION ListarEstados(par_cFiltro)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT RTRIM(Estados) AS Estados, RTRIM(Descrs) AS Descrs " + ;
                    "FROM SigCdUfs ORDER BY Estados"
            ELSE
                loc_cSQL = "SELECT RTRIM(Estados) AS Estados, RTRIM(Descrs) AS Descrs " + ;
                    "FROM SigCdUfs " + ;
                    "WHERE RTRIM(Estados) LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY Estados"
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaEstados")
            IF loc_nRet > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.ListarEstados")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

