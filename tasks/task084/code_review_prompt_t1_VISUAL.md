# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 531: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 553: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 575: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReEch.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1562 linhas total):

*-- Linhas 89 a 97:
89: 
90:             *-- Titulo e imagem de fundo (exatos do original)
91:             THIS.this_cTituloForm = "Emiss" + CHR(227) + "o de Cheque"
92:             THIS.Caption          = "Emiss" + CHR(227) + "o de Cheque"
93:             THIS.Picture          = gc_4c_CaminhoIcones + "new_background.jpg"
94: 
95:             *-- Cria container do cabecalho cinza (cntSombra do original)
96:             THIS.ConfigurarPageFrame()
97: 

*-- Linhas 130 a 178:
130:         TRY
131:             THIS.AddObject("cnt_4c_Sombra", "Container")
132:             WITH THIS.cnt_4c_Sombra
133:                 .Top         = 0
134:                 .Left        = 0
135:                 .Width       = THIS.Width
136:                 .Height      = 80
137:                 .BorderWidth = 0
138:                 .BackStyle   = 1
139:                 .BackColor   = RGB(100, 100, 100)
140:                 .Visible     = .T.
141: 
142:                 *-- Label sombra (preto, deslocado 1px para efeito 3D)
143:                 .AddObject("lbl_4c_LblSombra", "Label")
144:                 WITH .lbl_4c_LblSombra
145:                     .FontBold      = .T.
146:                     .FontName      = "Tahoma"
147:                     .FontSize      = 18
148:                     .FontUnderline = .F.
149:                     .WordWrap      = .T.
150:                     .Alignment     = 0
151:                     .BackStyle     = 0
152:                     .Caption       = "Emiss" + CHR(227) + "o de Cheque"
153:                     .Height        = 40
154:                     .Left          = 10
155:                     .Top           = 25
156:                     .Width         = THIS.Width
157:                     .ForeColor     = RGB(0, 0, 0)
158:                     .Visible       = .T.
159:                 ENDWITH
160: 
161:                 *-- Label titulo (branco sobre cinza)
162:                 .AddObject("lbl_4c_LblTitulo", "Label")
163:                 WITH .lbl_4c_LblTitulo
164:                     .FontBold  = .T.
165:                     .FontName  = "Tahoma"
166:                     .FontSize  = 18
167:                     .WordWrap  = .T.
168:                     .Alignment = 0
169:                     .BackStyle = 0
170:                     .Caption   = "Emiss" + CHR(227) + "o de Cheque"
171:                     .Height    = 46
172:                     .Left      = 10
173:                     .Top       = 24
174:                     .Width     = THIS.Width
175:                     .ForeColor = RGB(255, 255, 255)
176:                     .Visible   = .T.
177:                 ENDWITH
178:             ENDWITH

*-- Linhas 196 a 450:
196:             *-- Container cheque (Cheque do original: Top=83, Left=134, W=487, H=51)
197:             THIS.AddObject("cnt_4c_Cheque", "Container")
198:             WITH THIS.cnt_4c_Cheque
199:                 .Top           = 83
200:                 .Left          = 134
201:                 .Width         = 487
202:                 .Height        = 51
203:                 .BackStyle     = 0
204:                 .BorderWidth   = 1
205:                 .SpecialEffect = 2
206:                 .BackColor     = RGB(255, 255, 255)
207:                 .Visible       = .T.
208: 
209:                 *-- Labels de cabecalho dos campos do cheque
210:                 .AddObject("lbl_4c_Say2", "Label")
211:                 WITH .lbl_4c_Say2
212:                     .FontName  = "Tahoma"
213:                     .FontSize  = 8
214:                     .BackStyle = 0
215:                     .Caption   = "Bco"
216:                     .Left      = 12
217:                     .Top       = 3
218:                     .ForeColor = RGB(90, 90, 90)
219:                     .Visible   = .T.
220:                 ENDWITH
221: 
222:                 .AddObject("lbl_4c_Say3", "Label")
223:                 WITH .lbl_4c_Say3
224:                     .FontName  = "Tahoma"
225:                     .FontSize  = 8
226:                     .BackStyle = 0
227:                     .Caption   = "Ag" + CHR(234) + "ncia"
228:                     .Left      = 57
229:                     .Top       = 3
230:                     .ForeColor = RGB(90, 90, 90)
231:                     .Visible   = .T.
232:                 ENDWITH
233: 
234:                 .AddObject("lbl_4c_Say5", "Label")
235:                 WITH .lbl_4c_Say5
236:                     .FontName  = "Tahoma"
237:                     .FontSize  = 8
238:                     .BackStyle = 0
239:                     .Caption   = "Conta"
240:                     .Left      = 107
241:                     .Top       = 3
242:                     .ForeColor = RGB(90, 90, 90)
243:                     .Visible   = .T.
244:                 ENDWITH
245: 
246:                 .AddObject("lbl_4c_Say4", "Label")
247:                 WITH .lbl_4c_Say4
248:                     .FontName  = "Tahoma"
249:                     .FontSize  = 8
250:                     .BackStyle = 0
251:                     .Caption   = "N" + CHR(250) + "mero"
252:                     .Left      = 196
253:                     .Top       = 3
254:                     .ForeColor = RGB(90, 90, 90)
255:                     .Visible   = .T.
256:                 ENDWITH
257: 
258:                 .AddObject("lbl_4c_SayValor", "Label")
259:                 WITH .lbl_4c_SayValor
260:                     .FontName  = "Tahoma"
261:                     .FontSize  = 8
262:                     .BackStyle = 0
263:                     .Caption   = "Valor"
264:                     .Left      = 259
265:                     .Top       = 3
266:                     .ForeColor = RGB(90, 90, 90)
267:                     .Visible   = .T.
268:                 ENDWITH
269: 
270:                 .AddObject("lbl_4c_SayVenc", "Label")
271:                 WITH .lbl_4c_SayVenc
272:                     .FontName  = "Tahoma"
273:                     .FontSize  = 8
274:                     .BackStyle = 0
275:                     .Caption   = "Vencimento"
276:                     .Left      = 390
277:                     .Top       = 3
278:                     .ForeColor = RGB(90, 90, 90)
279:                     .Visible   = .T.
280:                 ENDWITH
281: 
282:                 *-- TextBoxes somente leitura (dados carregados via BOParaForm)
283:                 .AddObject("txt_4c_Bco", "TextBox")
284:                 WITH .txt_4c_Bco
285:                     .Left      = 12
286:                     .Top       = 17
287:                     .Width     = 36
288:                     .Height    = 23
289:                     .ReadOnly  = .T.
290:                     .FontName  = "Tahoma"
291:                     .FontSize  = 8
292:                     .BackColor = RGB(240, 240, 240)
293:                     .Visible   = .T.
294:                 ENDWITH
295: 
296:                 .AddObject("txt_4c_Age", "TextBox")
297:                 WITH .txt_4c_Age
298:                     .Left      = 58
299:                     .Top       = 17
300:                     .Width     = 38
301:                     .Height    = 23
302:                     .ReadOnly  = .T.
303:                     .FontName  = "Tahoma"
304:                     .FontSize  = 8
305:                     .BackColor = RGB(240, 240, 240)
306:                     .Visible   = .T.
307:                 ENDWITH
308: 
309:                 .AddObject("txt_4c_Conta", "TextBox")
310:                 WITH .txt_4c_Conta
311:                     .Left      = 106
312:                     .Top       = 17
313:                     .Width     = 80
314:                     .Height    = 23
315:                     .ReadOnly  = .T.
316:                     .FontName  = "Tahoma"
317:                     .FontSize  = 8
318:                     .BackColor = RGB(240, 240, 240)
319:                     .Visible   = .T.
320:                 ENDWITH
321: 
322:                 .AddObject("txt_4c_Num", "TextBox")
323:                 WITH .txt_4c_Num
324:                     .Left      = 196
325:                     .Top       = 17
326:                     .Width     = 52
327:                     .Height    = 23
328:                     .ReadOnly  = .T.
329:                     .FontName  = "Tahoma"
330:                     .FontSize  = 8
331:                     .BackColor = RGB(240, 240, 240)
332:                     .Visible   = .T.
333:                 ENDWITH
334: 
335:                 .AddObject("txt_4c_Valor", "TextBox")
336:                 WITH .txt_4c_Valor
337:                     .Left      = 258
338:                     .Top       = 17
339:                     .Width     = 121
340:                     .Height    = 23
341:                     .ReadOnly  = .T.
342:                     .InputMask = "999,999,999.99"
343:                     .FontName  = "Tahoma"
344:                     .FontSize  = 8
345:                     .BackColor = RGB(240, 240, 240)
346:                     .Visible   = .T.
347:                 ENDWITH
348: 
349:                 .AddObject("txt_4c_Vencimento", "TextBox")
350:                 WITH .txt_4c_Vencimento
351:                     .Left      = 389
352:                     .Top       = 17
353:                     .Width     = 83
354:                     .Height    = 23
355:                     .ReadOnly  = .T.
356:                     .FontName  = "Tahoma"
357:                     .FontSize  = 8
358:                     .BackColor = RGB(240, 240, 240)
359:                     .Visible   = .T.
360:                 ENDWITH
361:             ENDWITH
362: 
363:             *-- Label e campo Favorecido (editavel em INSERIR/ALTERAR)
364:             THIS.AddObject("lbl_4c_Label6", "Label")
365:             WITH THIS.lbl_4c_Label6
366:                 .FontName  = "Tahoma"
367:                 .FontSize  = 8
368:                 .BackStyle = 0
369:                 .Caption   = "Favorecido"
370:                 .Left      = 134
371:                 .Top       = 136
372:                 .ForeColor = RGB(90, 90, 90)
373:                 .Visible   = .T.
374:             ENDWITH
375: 
376:             THIS.AddObject("txt_4c_Favorecido", "TextBox")
377:             WITH THIS.txt_4c_Favorecido
378:                 .Left      = 134
379:                 .Top       = 151
380:                 .Width     = 338
381:                 .Height    = 23
382:                 .MaxLength = 40
383:                 .FontName  = "Tahoma"
384:                 .FontSize  = 8
385:                 .Visible   = .T.
386:             ENDWITH
387: 
388:             *-- Label e campo N Copia (somente leitura)
389:             THIS.AddObject("lbl_4c_Label4", "Label")
390:             WITH THIS.lbl_4c_Label4
391:                 .FontName  = "Tahoma"
392:                 .FontSize  = 8
393:                 .BackStyle = 0
394:                 .Caption   = "N" + CHR(186) + " C" + CHR(243) + "pia"
395:                 .Left      = 474
396:                 .Top       = 136
397:                 .ForeColor = RGB(90, 90, 90)
398:                 .Visible   = .T.
399:             ENDWITH
400: 
401:             THIS.AddObject("txt_4c_Copia", "TextBox")
402:             WITH THIS.txt_4c_Copia
403:                 .Left      = 474
404:                 .Top       = 151
405:                 .Width     = 63
406:                 .Height    = 23
407:                 .ReadOnly  = .T.
408:                 .FontName  = "Tahoma"
409:                 .FontSize  = 8
410:                 .BackColor = RGB(240, 240, 240)
411:                 .Visible   = .T.
412:             ENDWITH
413: 
414:             *-- Label Verso e EditBox para texto do verso
415:             THIS.AddObject("lbl_4c_Label1", "Label")
416:             WITH THIS.lbl_4c_Label1
417:                 .FontName  = "Tahoma"
418:                 .FontSize  = 8
419:                 .BackStyle = 0
420:                 .Caption   = "Verso"
421:                 .Left      = 134
422:                 .Top       = 177
423:                 .Height    = 15
424:                 .Width     = 29
425:                 .ForeColor = RGB(90, 90, 90)
426:                 .Visible   = .T.
427:             ENDWITH
428: 
429:             THIS.AddObject("obj_4c_Get_Verso", "EditBox")
430:             WITH THIS.obj_4c_Get_Verso
431:                 .Left      = 134
432:                 .Top       = 192
433:                 .Width     = 404
434:                 .Height    = 120
435:                 .FontName  = "Tahoma"
436:                 .FontSize  = 8
437:                 .Visible   = .T.
438:             ENDWITH
439: 
440:             *-- OLE MSComm para comunicacao serial com impressora de cheque
441:             TRY
442:                 THIS.AddObject("obj_4c_OModem", "OLEControl", "MSCommLib.MSComm")
443:                 WITH THIS.obj_4c_OModem
444:                     .Top     = 12
445:                     .Left    = 504
446:                     .Height  = 100
447:                     .Width   = 100
448:                     .Visible = .F.
449:                 ENDWITH
450:             CATCH TO loc_oErrOle

*-- Linhas 514 a 537:
514:     ENDPROC
515: 
516:     *==========================================================================
517:     * ConfigurarPaginaLista - Cria botoes operacionais, OptionGroup e lbl_4c_LbNimp
518:     * Fase 4: cmd_4c_Visualizar, cmd_4c_Imprimir, cmd_4c_Encerrar,
519:     *          opt_4c_Imprime, lbl_4c_LbNimp
520:     *==========================================================================
521:     PROTECTED PROCEDURE ConfigurarPaginaLista()
522:         LOCAL loc_oErro
523:         TRY
524:             THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
525:             WITH THIS.cmd_4c_Visualizar
526:                 .Top             = 2
527:                 .Left            = 573
528:                 .Height          = 75
529:                 .Width           = 75
530:                 .Caption         = "V" + CHR(237) + "deo"
531:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
532:                 .PicturePosition = 13
533:                 .FontName        = "Comic Sans MS"
534:                 .FontSize        = 8
535:                 .FontBold        = .T.
536:                 .FontItalic      = .T.
537:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 543 a 559:
543:                 .Visible         = .T.
544:             ENDWITH
545: 
546:             THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
547:             WITH THIS.cmd_4c_Imprimir
548:                 .Top             = 2
549:                 .Left            = 648
550:                 .Height          = 75
551:                 .Width           = 75
552:                 .Caption         = "Impressora"
553:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
554:                 .PicturePosition = 13
555:                 .FontName        = "Comic Sans MS"
556:                 .FontSize        = 8
557:                 .FontBold        = .T.
558:                 .FontItalic      = .T.
559:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 565 a 581:
565:                 .Visible         = .T.
566:             ENDWITH
567: 
568:             THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
569:             WITH THIS.cmd_4c_Encerrar
570:                 .Top             = 2
571:                 .Left            = 723
572:                 .Height          = 75
573:                 .Width           = 75
574:                 .Caption         = "Encerrar"
575:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
576:                 .PicturePosition = 13
577:                 .FontName        = "Comic Sans MS"
578:                 .FontSize        = 8
579:                 .FontBold        = .T.
580:                 .FontItalic      = .T.
581:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 593 a 677:
593:                 .BackStyle     = 0
594:                 .Value         = 1
595:                 .Height        = 73
596:                 .Left          = 543
597:                 .SpecialEffect = 1
598:                 .Top           = 192
599:                 .Width         = 79
600:                 .BorderColor   = RGB(36, 84, 155)
601:                 .Visible       = .T.
602:                 WITH .Buttons(1)
603:                     .BackStyle = 0
604:                     .Caption   = "Cheque"
605:                     .Value     = 1
606:                     .Height    = 15
607:                     .Left      = 7
608:                     .Top       = 7
609:                     .Width     = 55
610:                     .AutoSize  = .T.
611:                     .ForeColor = RGB(90, 90, 90)
612:                     .Themes    = .F.
613:                 ENDWITH
614:                 WITH .Buttons(2)
615:                     .FontName  = "Tahoma"
616:                     .FontSize  = 8
617:                     .BackStyle = 0
618:                     .Caption   = "Verso"
619:                     .Height    = 15
620:                     .Left      = 7
621:                     .Top       = 28
622:                     .Width     = 45
623:                     .AutoSize  = .T.
624:                     .ForeColor = RGB(90, 90, 90)
625:                     .Themes    = .F.
626:                 ENDWITH
627:                 WITH .Buttons(3)
628:                     .FontName  = "Tahoma"
629:                     .FontSize  = 8
630:                     .BackStyle = 0
631:                     .Caption   = "C" + CHR(243) + "pia"
632:                     .Height    = 15
633:                     .Left      = 7
634:                     .Top       = 49
635:                     .Width     = 45
636:                     .AutoSize  = .T.
637:                     .ForeColor = RGB(90, 90, 90)
638:                     .Themes    = .F.
639:                 ENDWITH
640:             ENDWITH
641: 
642:             THIS.AddObject("lbl_4c_LbNimp", "Label")
643:             WITH THIS.lbl_4c_LbNimp
644:                 .AutoSize  = .T.
645:                 .FontName  = "Tahoma"
646:                 .FontSize  = 8
647:                 .BackStyle = 0
648:                 .Caption   = "( N" + CHR(227) + "o Impresso )"
649:                 .Height    = 15
650:                 .Left      = 173
651:                 .Top       = 177
652:                 .Width     = 82
653:                 .ForeColor = RGB(128, 64, 64)
654:                 .Visible   = .F.
655:             ENDWITH
656: 
657:             BINDEVENT(THIS.cmd_4c_Visualizar, "Click",             THIS, "BtnVisualizarClick")
658:             BINDEVENT(THIS.cmd_4c_Imprimir,   "Click",             THIS, "BtnImprimirClick")
659:             BINDEVENT(THIS.cmd_4c_Encerrar,   "Click",             THIS, "BtnEncerrarClick")
660:             BINDEVENT(THIS.opt_4c_Imprime,    "InteractiveChange", THIS, "OptImprimicChange")
661: 
662:         CATCH TO loc_oErro
663:             MsgErro(loc_oErro.Message, "Erro")
664:         ENDTRY
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * AlternarPagina - Sincroniza estado do botao Video com a opcao selecionada
669:     *==========================================================================
670:     PROCEDURE AlternarPagina()
671:         IF VARTYPE(THIS.cmd_4c_Visualizar) = "O" AND VARTYPE(THIS.opt_4c_Imprime) = "O"
672:             THIS.cmd_4c_Visualizar.Enabled = INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
673:         ENDIF
674:     ENDPROC
675: 
676:     *==========================================================================
677:     * InicializarEstadoBotoes - Define estado inicial dos botoes apos carregar dados

*-- Linhas 687 a 696:
687:                 IF loc_oBO.this_lEmitidos
688:                     THIS.opt_4c_Imprime.Buttons(3).SetFocus
689:                 ENDIF
690:                 THIS.cmd_4c_Visualizar.Enabled  = loc_oBO.this_lEmitidos
691:                 THIS.lbl_4c_LbNimp.Visible      = (loc_oBO.this_nImpVersos = 0)
692:                 IF VARTYPE(THIS.obj_4c_Get_Verso) = "O"
693:                     THIS.obj_4c_Get_Verso.ReadOnly = !(INLIST(THIS.op_escolha, "INSERIR", "ALTERAR") AND loc_oBO.this_nImpVersos = 0)
694:                     IF THIS.obj_4c_Get_Verso.ReadOnly
695:                         THIS.obj_4c_Get_Verso.BackColor = RGB(240, 240, 240)
696:                     ENDIF

*-- Linhas 711 a 719:
711:     * OptImprimicChange - Atualiza Visualizar.Enabled conforme opcao selecionada
712:     *==========================================================================
713:     PROCEDURE OptImprimicChange()
714:         THIS.cmd_4c_Visualizar.Enabled = INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
715:     ENDPROC
716: 
717:     *==========================================================================
718:     * BtnVisualizarClick - Exibe copia do cheque em preview (Video)
719:     *==========================================================================

*-- Linhas 1024 a 1032:
1024: 
1025:                     loc_oBO.this_nImpVersos = 1
1026:                     loc_oBO.MarcarVersoImpresso(loc_oBO.this_cCidChaves)
1027:                     THIS.lbl_4c_LbNimp.Visible = (loc_oBO.this_nImpVersos = 0)
1028:                 ELSE
1029:                     MsgErro("Configura" + CHR(231) + CHR(227) + "o da impressora de cheque n" + ;
1030:                             CHR(227) + "o encontrada.", "Erro")
1031:                 ENDIF
1032:                 ENDIF && IF PEMSTATUS(THIS, "obj_4c_OModem", 5)

*-- Linhas 1446 a 1459:
1446:                     THIS.opt_4c_Imprime.Buttons(2).Enabled = loc_oBO.this_lEmitidos
1447:                     THIS.opt_4c_Imprime.Buttons(3).Enabled = loc_oBO.this_lEmitidos
1448:                 ENDIF
1449:                 IF VARTYPE(THIS.cmd_4c_Visualizar) = "O"
1450:                     THIS.cmd_4c_Visualizar.Enabled = VARTYPE(THIS.opt_4c_Imprime) = "O" AND ;
1451:                                                      INLIST(THIS.opt_4c_Imprime.Value, 3, 4)
1452:                 ENDIF
1453:                 IF VARTYPE(THIS.lbl_4c_LbNimp) = "O"
1454:                     THIS.lbl_4c_LbNimp.Visible = (loc_oBO.this_nImpVersos = 0)
1455:                 ENDIF
1456:                 THIS.HabilitarCampos(THIS.op_escolha)
1457:             ENDIF
1458:         CATCH TO loc_oErro
1459:             MsgErro(loc_oErro.Message, "Erro")


### BO (C:\4c\projeto\app\classes\SigReEchBO.prg):
*------------------------------------------------------------------------------
* SigReEchBO.prg - Business Object para Emissao de Cheque
* Tabela principal: SIGCQCHI
* Herda de: BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS SigReEchBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela      = "SigCqChi"
    this_cCampoChave  = "cidchaves"

    *--------------------------------------------------------------------------
    *-- Propriedades de SIGCQCHI (cheque)
    *--------------------------------------------------------------------------
    this_cCidChaves   = ""    && cidchaves  char(20) - chave primaria
    this_cEmpDopNums  = ""    && empdopnums char(29) - chave composta emps+dopes+numes
    this_cEmps        = ""    && emps       char(3)  - empresa
    this_cDopes       = ""    && dopes      char(20) - documento operacao
    this_nNumes       = 0     && numes      numeric(6,0)
    this_cBancos      = ""    && bancos     char(3)
    this_cAgencias    = ""    && agencias   char(4)
    this_cContas      = ""    && contas     char(10)
    this_cNContas     = ""    && ncontas    char(10) - numero da conta
    this_cNCheques    = ""    && ncheques   char(6)  - numero do cheque
    this_cFavos       = ""    && favos      char(40) - favorecido
    this_nValors      = 0     && valors     numeric(11,2)
    this_dVencs       = {}    && vencs      datetime - vencimento
    this_cVersos      = ""    && versos     text     - verso do cheque
    this_lEmitidos    = .F.   && emitidos   bit      - se ja foi emitido
    this_nNEmissoes   = 0     && nemissoes  numeric(2,0) - numero de emissoes
    this_nNCopias     = 0     && ncopias    numeric(6,0) - numero de copias
    this_nImpVersos   = 0     && impversos  numeric(1,0) - se verso foi impresso
    this_lCancelas    = .F.   && cancelas   bit      - se cancelado
    this_cGrupos      = ""    && grupos     char(10)
    this_dDatas       = {}    && datas      datetime
    this_cJustCanc    = ""    && justcanc   text     - justificativa cancelamento

    *--------------------------------------------------------------------------
    *-- Propriedades de SigMvPar (parcela vinculada ao cheque - cursor CrPar)
    *--------------------------------------------------------------------------
    this_cParBancos   = ""    && bancos    char(3)
    this_cParAgencias = ""    && agencias  char(4)
    this_cParContas   = ""    && contas    char(10)
    this_cParNumeros  = ""    && numeros   char(6)
    this_nParValos    = 0     && valos     numeric(11,2) - valor da parcela
    this_dParVencs    = {}    && vencs     datetime      - vencimento da parcela
    this_cParFPags    = ""    && fpags     char(12)      - forma de pagamento

    *--------------------------------------------------------------------------
    *-- Propriedades de SigCdEmp (empresa - cursor CrSigCdEmp)
    *--------------------------------------------------------------------------
    this_cCidEmps     = ""    && cidas char(30) - cidade da empresa

    *--------------------------------------------------------------------------
    *-- Parametros e estado de execucao do formulario
    *--------------------------------------------------------------------------
    this_cOpEscolha    = ""   && INSERIR, ALTERAR - modo do form ao abrir
    this_cNchequeParam = ""   && _ncheque filtro inicial (opcional)
    this_lEnviaImp     = .F.  && .T.=imprimir fisicamente, .F.=preview em video
    this_cPeAntValue   = ""   && valor anterior do campo verso (para detectar mudanca)

    *--------------------------------------------------------------------------
    PROCEDURE Init
        THIS.this_cTabela     = "SigCqChi"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor SigCqChi para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
            THIS.this_cEmpDopNums = NVL(ALLTRIM(empdopnums), "")
            THIS.this_cEmps       = NVL(ALLTRIM(emps), "")
            THIS.this_cDopes      = NVL(ALLTRIM(dopes), "")
            THIS.this_nNumes      = NVL(numes, 0)
            THIS.this_cBancos     = NVL(ALLTRIM(bancos), "")
            THIS.this_cAgencias   = NVL(ALLTRIM(agencias), "")
            THIS.this_cContas     = NVL(ALLTRIM(contas), "")
            THIS.this_cNContas    = NVL(ALLTRIM(ncontas), "")
            THIS.this_cNCheques   = NVL(ALLTRIM(ncheques), "")
            THIS.this_cFavos      = NVL(ALLTRIM(favos), "")
            THIS.this_nValors     = NVL(valors, 0)
            THIS.this_dVencs      = NVL(vencs, {})
            THIS.this_cVersos     = NVL(versos, "")
            IF VARTYPE(emitidos) = "L"
                THIS.this_lEmitidos = emitidos
            ELSE
                THIS.this_lEmitidos = IIF(NVL(emitidos, 0) = 1, .T., .F.)
            ENDIF
            THIS.this_nNEmissoes  = NVL(nemissoes, 0)
            THIS.this_nNCopias    = NVL(ncopias, 0)
            THIS.this_nImpVersos  = NVL(impversos, 0)
            IF VARTYPE(cancelas) = "L"
                THIS.this_lCancelas = cancelas
            ELSE
                THIS.this_lCancelas = IIF(NVL(cancelas, 0) = 1, .T., .F.)
            ENDIF
            THIS.this_cGrupos     = NVL(ALLTRIM(grupos), "")
            THIS.this_dDatas      = NVL(datas, {})
            THIS.this_cJustCanc   = NVL(justcanc, "")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega cheque de SigCqChi por emps+dopes+numes
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_cEmps, par_cDopes, par_nNumes, par_cNcheque)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEDN, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cEDN = par_cEmps + PADR(par_cDopes, 20) + STR(par_nNumes, 6)
            loc_cSQL = "SELECT agencias, bancos, cancelas, contas, datas, " + ;
                       "dopes, emitidos, emps, favos, grupos, ncheques, " + ;
                       "ncontas, ncopias, nemissoes, numes, valors, vencs, " + ;
                       "versos, cidchaves, empdopnums, justcanc, impversos " + ;
                       "FROM SigCqChi " + ;
                       "WHERE empdopnums = " + EscaparSQL(loc_cEDN)
            IF !EMPTY(ALLTRIM(par_cNcheque))
                loc_cSQL = loc_cSQL + " AND ncheques = " + EscaparSQL(par_cNcheque)
            ENDIF

            IF USED("cursor_4c_ChiDados")
                TABLEREVERT(.T., "cursor_4c_ChiDados")
                USE IN cursor_4c_ChiDados
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChiDados") > 0
                SELECT cursor_4c_ChiDados
                GO TOP
                IF !EOF()
                    THIS.CarregarDoCursor("cursor_4c_ChiDados")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParcela - Carrega parcela vinculada ao cheque (SigMvPar)
    *--------------------------------------------------------------------------
    FUNCTION CarregarParcela(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT bancos, agencias, contas, numeros, valos, vencs, fpags " + ;
                       "FROM SigMvPar " + ;
                       "WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)

            IF USED("cursor_4c_Par")
                TABLEREVERT(.T., "cursor_4c_Par")
                USE IN cursor_4c_Par
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Par") > 0
                SELECT cursor_4c_Par
                GO TOP
                IF !EOF()
                    SELECT cursor_4c_Par
                    THIS.this_cParBancos   = NVL(ALLTRIM(bancos), "")
                    THIS.this_cParAgencias = NVL(ALLTRIM(agencias), "")
                    THIS.this_cParContas   = NVL(ALLTRIM(contas), "")
                    THIS.this_cParNumeros  = NVL(ALLTRIM(numeros), "")
                    THIS.this_nParValos    = NVL(valos, 0)
                    THIS.this_dParVencs    = NVL(vencs, {})
                    THIS.this_cParFPags    = NVL(ALLTRIM(fpags), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega dados da empresa (SigCdEmp)
    *--------------------------------------------------------------------------
    FUNCTION CarregarEmpresa(par_cEmps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cemps, cidas FROM SigCdEmp " + ;
                       "WHERE cemps = " + EscaparSQL(par_cEmps)

            IF USED("cursor_4c_Emp")
                TABLEREVERT(.T., "cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    SELECT cursor_4c_Emp
                    THIS.this_cCidEmps = NVL(ALLTRIM(cidas), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCqChi
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidChaves  = LEFT(THIS.this_cEmps + SYS(2015) + PADR(SYS(1), 7, "0"), 20)
            THIS.this_cEmpDopNums = THIS.this_cEmps + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            loc_cSQL = "INSERT INTO SigCqChi " + ;
                       "(cidchaves, empdopnums, emps, dopes, numes, " + ;
                       "agencias, bancos, contas, ncontas, ncheques, " + ;
                       "favos, valors, vencs, versos, emitidos, " + ;
                       "nemissoes, ncopias, impversos, cancelas, " + ;
                       "grupos, datas, justcanc) VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cAgencias, 4)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cBancos, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cContas, 10)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cNContas, 10)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cNCheques, 6)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cFavos, 40)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       EscaparSQL(THIS.this_cVersos) + ", " + ;
                       IIF(THIS.this_lEmitidos, "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNEmissoes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNCopias) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpVersos) + ", " + ;
                       IIF(THIS.this_lCancelas, "1", "0") + ", " + ;
                       EscaparSQL(PADR(THIS.this_cGrupos, 10)) + ", " + ;
                       IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       EscaparSQL(THIS.this_cJustCanc) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigCqChi
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi SET " + ;
                       "empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                       "dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       "numes = " + FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       "agencias = " + EscaparSQL(PADR(THIS.this_cAgencias, 4)) + ", " + ;
                       "bancos = " + EscaparSQL(PADR(THIS.this_cBancos, 3)) + ", " + ;
                       "contas = " + EscaparSQL(PADR(THIS.this_cContas, 10)) + ", " + ;
                       "ncontas = " + EscaparSQL(PADR(THIS.this_cNContas, 10)) + ", " + ;
                       "ncheques = " + EscaparSQL(PADR(THIS.this_cNCheques, 6)) + ", " + ;
                       "favos = " + EscaparSQL(PADR(THIS.this_cFavos, 40)) + ", " + ;
                       "valors = " + FormatarNumeroSQL(THIS.this_nValors) + ", " + ;
                       "vencs = " + IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       "versos = " + EscaparSQL(THIS.this_cVersos) + ", " + ;
                       "emitidos = " + IIF(THIS.this_lEmitidos, "1", "0") + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(THIS.this_nNEmissoes) + ", " + ;
                       "ncopias = " + FormatarNumeroSQL(THIS.this_nNCopias) + ", " + ;
                       "impversos = " + FormatarNumeroSQL(THIS.this_nImpVersos) + ", " + ;
                       "cancelas = " + IIF(THIS.this_lCancelas, "1", "0") + ", " + ;
                       "grupos = " + EscaparSQL(PADR(THIS.this_cGrupos, 10)) + ", " + ;
                       "datas = " + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       "justcanc = " + EscaparSQL(THIS.this_cJustCanc) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarEmitido - Marca cheque como emitido e incrementa emissoes
    *--------------------------------------------------------------------------
    FUNCTION MarcarEmitido(par_cCidChaves, par_cFavos, par_nNEmissoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET emitidos = 1, " + ;
                       "favos = " + EscaparSQL(PADR(par_cFavos, 40)) + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(par_nNEmissoes) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarVersoImpresso - Marca verso do cheque como impresso (impversos=1)
    *--------------------------------------------------------------------------
    FUNCTION MarcarVersoImpresso(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET impversos = 1 " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarVerso - Atualiza texto do verso do cheque
    *--------------------------------------------------------------------------
    FUNCTION AtualizarVerso(par_cCidChaves, par_cVerso)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET versos = " + EscaparSQL(par_cVerso) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarStatusSaida - Salva status ao sair sem emitir (emitidos=0)
    *--------------------------------------------------------------------------
    FUNCTION SalvarStatusSaida(par_cCidChaves, par_cFavos, par_nNEmissoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET emitidos = 0, " + ;
                       "favos = " + EscaparSQL(PADR(par_cFavos, 40)) + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(par_nNEmissoes) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

