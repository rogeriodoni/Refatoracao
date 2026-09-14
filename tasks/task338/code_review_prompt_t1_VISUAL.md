# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 185: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTFH.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1013 linhas total):

*-- Linhas 119 a 216:
119:     * ConfigurarPageFrame
120:     * Form OPERACIONAL (SiTef Consulta Cheque) usa layout customizado 467x350
121:     * sem PageFrame - controles diretos no Form. Este metodo cria o cabecalho
122:     * cinza superior (cnt_4c_Cabecalho + lbl_4c_Sombra + lbl_4c_Titulo) que eh
123:     * a estrutura visual base do form.
124:     *==========================================================================
125:     PROTECTED PROCEDURE ConfigurarPageFrame
126:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
127:         WITH THIS.cnt_4c_Cabecalho
128:             .Top         = 1
129:             .Left        = 1
130:             .Width       = THIS.Width
131:             .Height      = 80
132:             .BackStyle   = 1
133:             .BackColor   = RGB(100,100,100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Top      = 18
141:             .Left     = 10
142:             .Width    = THIS.cnt_4c_Cabecalho.Width - 20
143:             .Height   = 40
144:             .AutoSize = .F.
145:             .BackStyle = 0
146:             .FontName  = "Tahoma"
147:             .FontSize  = 18
148:             .FontBold  = .T.
149:             .ForeColor = RGB(0,0,0)
150:             .WordWrap  = .T.
151:             .Caption   = "SiTef - Consulta de Cheque"
152:         ENDWITH
153: 
154:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Top      = 17
157:             .Left     = 10
158:             .Width    = THIS.cnt_4c_Cabecalho.Width - 20
159:             .Height   = 46
160:             .AutoSize = .F.
161:             .BackStyle = 0
162:             .FontName  = "Tahoma"
163:             .FontSize  = 18
164:             .FontBold  = .T.
165:             .ForeColor = RGB(255,255,255)
166:             .WordWrap  = .T.
167:             .Caption   = "SiTef - Consulta de Cheque"
168:         ENDWITH
169:     ENDPROC
170: 
171:     *==========================================================================
172:     * ConfigurarBotaoCancela
173:     * Botao CANCELA: unico controle focalizavel (todos os txt_ tem Enabled=.F.)
174:     * O GotFocus dispara automaticamente ao abrir o form e inicia o loop SiTef.
175:     *==========================================================================
176:     PROTECTED PROCEDURE ConfigurarBotaoCancela
177:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
178:         WITH THIS.cmd_4c_Cancela
179:             .Top           = -1
180:             .Left          = 387
181:             .Width         = 75
182:             .Height        = 75
183:             .FontBold      = .T.
184:             .FontItalic    = .T.
185:             .FontName      = "Comic Sans MS"
186:             .FontSize      = 8
187:             .ForeColor     = RGB(90,90,90)
188:             .BackColor     = RGB(255,255,255)
189:             .Picture       = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
190:             .Themes        = .T.
191:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
192:             .SpecialEffect = 0
193:             .PicturePosition = 13
194:             .WordWrap      = .T.
195:             .Cancel        = .T.
196:             .Caption       = "<Esc> \<Sair"
197:         ENDWITH
198: 
199:         BINDEVENT(THIS.cmd_4c_Cancela, "GotFocus", THIS, "CmdCancelaGotFocus")
200:         BINDEVENT(THIS.cmd_4c_Cancela, "Click",    THIS, "CmdCancelaClick")
201:     ENDPROC
202: 
203:     *==========================================================================
204:     * ConfigurarCorpoForm
205:     * Painel visual (Shape2) que delimita a area de dados do cheque
206:     *==========================================================================
207:     PROTECTED PROCEDURE ConfigurarCorpoForm
208:         THIS.AddObject("shp_4c_Painel", "Shape")
209:         WITH THIS.shp_4c_Painel
210:             .Top           = 84
211:             .Left          = 0
212:             .Width         = 466
213:             .Height        = 202
214:             .SpecialEffect = 0
215:         ENDWITH
216:     ENDPROC

*-- Linhas 222 a 301:
222:     PROTECTED PROCEDURE ConfigurarContainerStatus
223:         THIS.AddObject("cnt_4c_Status", "Container")
224:         WITH THIS.cnt_4c_Status
225:             .Top           = 288
226:             .Left          = 37
227:             .Width         = 393
228:             .Height        = 58
229:             .SpecialEffect = 0
230:             .BackStyle     = 1
231:             .BackColor     = RGB(255,255,255)
232:             .Visible     = .T.
233:         ENDWITH
234: 
235:         THIS.cnt_4c_Status.AddObject("lbl_4c_Status1", "Label")
236:         WITH THIS.cnt_4c_Status.lbl_4c_Status1
237:             .Top       = 8
238:             .Left      = 4
239:             .Width     = 383
240:             .Height    = 43
241:             .AutoSize  = .F.
242:             .Alignment = 2
243:             .FontBold  = .T.
244:             .FontName  = "Tahoma"
245:             .FontSize  = 8
246:             .ForeColor = RGB(90,90,90)
247:             .BackStyle = 0
248:             .Caption   = "Aguarde Consulta de Cheque"
249:         ENDWITH
250: 
251:         THIS.cnt_4c_Status.AddObject("lbl_4c_Status2", "Label")
252:         WITH THIS.cnt_4c_Status.lbl_4c_Status2
253:             .Top       = 3
254:             .Left      = 4
255:             .Width     = 383
256:             .Height    = 20
257:             .AutoSize  = .F.
258:             .Alignment = 2
259:             .FontBold  = .T.
260:             .FontName  = "Tahoma"
261:             .FontSize  = 8
262:             .ForeColor = RGB(90,90,90)
263:             .BackStyle = 0
264:             .Caption   = "Aguarde Consulta de Cheque"
265:         ENDWITH
266: 
267:         THIS.cnt_4c_Status.AddObject("lbl_4c_Status3", "Label")
268:         WITH THIS.cnt_4c_Status.lbl_4c_Status3
269:             .Top       = 21
270:             .Left      = 4
271:             .Width     = 383
272:             .Height    = 19
273:             .AutoSize  = .F.
274:             .Alignment = 2
275:             .FontBold  = .T.
276:             .FontName  = "Tahoma"
277:             .FontSize  = 8
278:             .ForeColor = RGB(90,90,90)
279:             .BackStyle = 0
280:             .Caption   = "Aguarde Consulta de Cheque"
281:         ENDWITH
282: 
283:         THIS.cnt_4c_Status.AddObject("lbl_4c_Status4", "Label")
284:         WITH THIS.cnt_4c_Status.lbl_4c_Status4
285:             .Top       = 39
286:             .Left      = 4
287:             .Width     = 383
288:             .Height    = 19
289:             .AutoSize  = .F.
290:             .Alignment = 2
291:             .FontBold  = .T.
292:             .FontName  = "Tahoma"
293:             .FontSize  = 8
294:             .ForeColor = RGB(90,90,90)
295:             .BackStyle = 0
296:             .Caption   = ""
297:         ENDWITH
298:     ENDPROC
299: 
300:     *==========================================================================
301:     * CmdCancelaGotFocus

*-- Linhas 348 a 627:
348:             RETURN
349:         ENDIF
350:         WITH THIS.cnt_4c_Status
351:             .lbl_4c_Status2.Caption = IIF(VARTYPE(par_cLinha1) = "C", par_cLinha1, "")
352:             .lbl_4c_Status3.Caption = IIF(VARTYPE(par_cLinha2) = "C", par_cLinha2, "")
353:             .lbl_4c_Status4.Caption = IIF(VARTYPE(par_cLinha3) = "C", par_cLinha3, "")
354:             .Visible     = .T.
355:         ENDWITH
356:         THIS.cnt_4c_Status.Refresh()
357:     ENDPROC
358: 
359:     *==========================================================================
360:     * ConfigurarCamposForm
361:     * Adiciona labels e textboxes de exibicao dos dados do cheque consultado.
362:     * Todos os TextBox sao Enabled=.F. (somente leitura; dados vem via parametro).
363:     *==========================================================================
364:     PROTECTED PROCEDURE ConfigurarCamposForm
365:         *-- Praca de Compensacao
366:         THIS.AddObject("lbl_4c_Label5", "Label")
367:         WITH THIS.lbl_4c_Label5
368:             .Top       = 97
369:             .Left      = 64
370:             .Width     = 132
371:             .Height    = 15
372:             .AutoSize  = .T.
373:             .FontBold  = .T.
374:             .FontName  = "Tahoma"
375:             .FontSize  = 8
376:             .ForeColor = RGB(90,90,90)
377:             .BackStyle = 0
378:             .Caption   = "Praca de Compesacao :"
379:         ENDWITH
380: 
381:         THIS.AddObject("txt_4c_Praca", "TextBox")
382:         WITH THIS.txt_4c_Praca
383:             .Top                = 94
384:             .Left               = 198
385:             .Width              = 32
386:             .Height             = 23
387:             .Alignment          = 3
388:             .FontBold           = .T.
389:             .FontName           = "Tahoma"
390:             .FontSize           = 8
391:             .Enabled            = .F.
392:             .DisabledForeColor  = RGB(0,0,0)
393:             .Value              = ""
394:         ENDWITH
395: 
396:         *-- Banco
397:         THIS.AddObject("lbl_4c_Label8", "Label")
398:         WITH THIS.lbl_4c_Label8
399:             .Top       = 129
400:             .Left      = 154
401:             .Width     = 42
402:             .Height    = 15
403:             .AutoSize  = .T.
404:             .FontBold  = .T.
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .ForeColor = RGB(90,90,90)
408:             .BackStyle = 0
409:             .Caption   = "Banco :"
410:         ENDWITH
411: 
412:         THIS.AddObject("txt_4c_Banco", "TextBox")
413:         WITH THIS.txt_4c_Banco
414:             .Top                = 126
415:             .Left               = 198
416:             .Width              = 32
417:             .Height             = 23
418:             .Alignment          = 3
419:             .FontBold           = .T.
420:             .FontName           = "Tahoma"
421:             .FontSize           = 8
422:             .Enabled            = .F.
423:             .DisabledForeColor  = RGB(0,0,0)
424:             .Value              = ""
425:         ENDWITH
426: 
427:         *-- Agencia + DV
428:         THIS.AddObject("lbl_4c_Label2", "Label")
429:         WITH THIS.lbl_4c_Label2
430:             .Top       = 161
431:             .Left      = 143
432:             .Width     = 53
433:             .Height    = 15
434:             .AutoSize  = .T.
435:             .FontBold  = .T.
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .ForeColor = RGB(90,90,90)
439:             .BackStyle = 0
440:             .Caption   = "Agencia :"
441:         ENDWITH
442: 
443:         THIS.AddObject("txt_4c_Agencia", "TextBox")
444:         WITH THIS.txt_4c_Agencia
445:             .Top       = 158
446:             .Left      = 198
447:             .Width     = 40
448:             .Height    = 23
449:             .FontBold  = .T.
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .BackColor = RGB(255,255,255)
453:             .Enabled   = .F.
454:             .Value     = ""
455:         ENDWITH
456: 
457:         THIS.AddObject("lbl_4c_Label9", "Label")
458:         WITH THIS.lbl_4c_Label9
459:             .Top       = 162
460:             .Left      = 288
461:             .Width     = 20
462:             .Height    = 15
463:             .AutoSize  = .T.
464:             .FontBold  = .T.
465:             .FontName  = "Tahoma"
466:             .FontSize  = 8
467:             .ForeColor = RGB(90,90,90)
468:             .BackStyle = 0
469:             .Caption   = "DV:"
470:         ENDWITH
471: 
472:         THIS.AddObject("txt_4c_DvAgencia", "TextBox")
473:         WITH THIS.txt_4c_DvAgencia
474:             .Top                = 158
475:             .Left               = 310
476:             .Width              = 19
477:             .Height             = 23
478:             .FontBold           = .T.
479:             .FontName           = "Tahoma"
480:             .FontSize           = 8
481:             .BackColor          = RGB(255,255,255)
482:             .DisabledForeColor  = RGB(64,0,64)
483:             .Enabled            = .F.
484:             .Value              = ""
485:         ENDWITH
486: 
487:         *-- Conta + DV
488:         THIS.AddObject("lbl_4c_Label7", "Label")
489:         WITH THIS.lbl_4c_Label7
490:             .Top       = 193
491:             .Left      = 155
492:             .Width     = 41
493:             .Height    = 15
494:             .AutoSize  = .T.
495:             .FontBold  = .T.
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .ForeColor = RGB(90,90,90)
499:             .BackStyle = 0
500:             .Caption   = "Conta :"
501:         ENDWITH
502: 
503:         THIS.AddObject("txt_4c_Conta", "TextBox")
504:         WITH THIS.txt_4c_Conta
505:             .Top      = 190
506:             .Left     = 198
507:             .Width    = 78
508:             .Height   = 23
509:             .FontBold = .T.
510:             .FontName = "Tahoma"
511:             .FontSize = 8
512:             .Enabled  = .F.
513:             .Value    = ""
514:         ENDWITH
515: 
516:         THIS.AddObject("lbl_4c_Label3", "Label")
517:         WITH THIS.lbl_4c_Label3
518:             .Top       = 194
519:             .Left      = 288
520:             .Width     = 20
521:             .Height    = 15
522:             .AutoSize  = .T.
523:             .FontBold  = .T.
524:             .FontName  = "Tahoma"
525:             .FontSize  = 8
526:             .ForeColor = RGB(90,90,90)
527:             .BackStyle = 0
528:             .Caption   = "DV:"
529:         ENDWITH
530: 
531:         THIS.AddObject("txt_4c_DvConta", "TextBox")
532:         WITH THIS.txt_4c_DvConta
533:             .Top      = 190
534:             .Left     = 310
535:             .Width    = 19
536:             .Height   = 23
537:             .FontBold = .T.
538:             .FontName = "Tahoma"
539:             .FontSize = 8
540:             .Enabled  = .F.
541:             .Value    = ""
542:         ENDWITH
543: 
544:         *-- Numero de Cheque + DV
545:         THIS.AddObject("lbl_4c_Label6", "Label")
546:         WITH THIS.lbl_4c_Label6
547:             .Top       = 225
548:             .Left      = 82
549:             .Width     = 114
550:             .Height    = 15
551:             .AutoSize  = .T.
552:             .FontBold  = .T.
553:             .FontName  = "Tahoma"
554:             .FontSize  = 8
555:             .ForeColor = RGB(90,90,90)
556:             .BackStyle = 0
557:             .Caption   = "Numero de Cheque :"
558:         ENDWITH
559: 
560:         THIS.AddObject("txt_4c_Cheque", "TextBox")
561:         WITH THIS.txt_4c_Cheque
562:             .Top                = 222
563:             .Left               = 198
564:             .Width              = 54
565:             .Height             = 23
566:             .FontBold           = .T.
567:             .FontName           = "Tahoma"
568:             .FontSize           = 8
569:             .Enabled            = .F.
570:             .DisabledForeColor  = RGB(0,0,0)
571:             .Value              = ""
572:         ENDWITH
573: 
574:         THIS.AddObject("lbl_4c_Label4", "Label")
575:         WITH THIS.lbl_4c_Label4
576:             .Top       = 226
577:             .Left      = 288
578:             .Width     = 20
579:             .Height    = 15
580:             .AutoSize  = .T.
581:             .FontBold  = .T.
582:             .FontName  = "Tahoma"
583:             .FontSize  = 8
584:             .ForeColor = RGB(90,90,90)
585:             .BackStyle = 0
586:             .Caption   = "DV:"
587:         ENDWITH
588: 
589:         THIS.AddObject("txt_4c_DvCheque", "TextBox")
590:         WITH THIS.txt_4c_DvCheque
591:             .Top                = 222
592:             .Left               = 310
593:             .Width              = 19
594:             .Height             = 23
595:             .FontBold           = .T.
596:             .FontName           = "Tahoma"
597:             .FontSize           = 8
598:             .Enabled            = .F.
599:             .DisabledForeColor  = RGB(0,0,0)
600:             .Value              = ""
601:         ENDWITH
602: 
603:         *-- CPF / CGC do portador (caption ajustado dinamicamente em PopularCamposDoBO)
604:         THIS.AddObject("lbl_4c_Label1", "Label")
605:         WITH THIS.lbl_4c_Label1
606:             .Top       = 257
607:             .Left      = 168
608:             .Width     = 28
609:             .Height    = 15
610:             .AutoSize  = .T.
611:             .FontBold  = .T.
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .ForeColor = RGB(90,90,90)
615:             .BackStyle = 0
616:             .Caption   = "CPF :"
617:         ENDWITH
618: 
619:         THIS.AddObject("txt_4c_Cpf", "TextBox")
620:         WITH THIS.txt_4c_Cpf
621:             .Top                = 254
622:             .Left               = 198
623:             .Width              = 132
624:             .Height             = 23
625:             .Alignment          = 3
626:             .FontBold           = .T.
627:             .FontName           = "Tahoma"

*-- Linhas 673 a 690:
673:         ENDIF
674: 
675:         *-- Caption do label CPF vs CGC baseado no tipo de pessoa
676:         IF VARTYPE(THIS.lbl_4c_Label1) = "O"
677:             THIS.lbl_4c_Label1.Caption = IIF(loc_oBo.this_cTipoPessoa = "F", "CPF :", "CGC :")
678:         ENDIF
679: 
680:         *-- Labels de status 2/3/4 iniciam ocultos (aparecem apenas em resultado Serasa multi-linha)
681:         IF VARTYPE(THIS.cnt_4c_Status) = "O"
682:             WITH THIS.cnt_4c_Status
683:                 .lbl_4c_Status2.Visible = .F.
684:                 .lbl_4c_Status3.Visible = .F.
685:                 .lbl_4c_Status4.Visible = .F.
686:             ENDWITH
687:         ENDIF
688:     ENDPROC
689: 
690:     *==========================================================================

*-- Linhas 710 a 724:
710:         IF par_lSucesso
711:             THIS.this_cRetValores = loc_cRetorno
712:             WITH THIS.cnt_4c_Status
713:                 .lbl_4c_Status1.Visible   = .T.
714:                 .lbl_4c_Status1.ForeColor = RGB(0,120,0)
715:                 .lbl_4c_Status1.FontSize  = 16
716:                 .lbl_4c_Status1.Caption   = loc_cRetorno
717:                 .lbl_4c_Status2.Visible   = .F.
718:                 .lbl_4c_Status3.Visible   = .F.
719:                 .lbl_4c_Status4.Visible   = .F.
720:             ENDWITH
721:         ELSE
722:             THIS.this_cRetValores = ""
723: 
724:             *-- Verificar se o retorno contem codigo Serasa (2 primeiros chars)

*-- Linhas 735 a 766:
735:             IF loc_lnSrIdx = 0
736:                 *-- Erro simples: exibe mensagem em Status1 (vermelho)
737:                 WITH THIS.cnt_4c_Status
738:                     .lbl_4c_Status1.Visible   = .T.
739:                     .lbl_4c_Status1.ForeColor = RGB(255,0,0)
740:                     .lbl_4c_Status1.Caption   = IIF(EMPTY(loc_cRetorno), ;
741:                         ALLTRIM(loc_oBo.this_cMensagemErro), loc_cRetorno)
742:                     .lbl_4c_Status2.Visible   = .F.
743:                     .lbl_4c_Status3.Visible   = .F.
744:                     .lbl_4c_Status4.Visible   = .F.
745:                 ENDWITH
746:             ELSE
747:                 *-- Resultado Serasa: oculta Status1, exibe 3 linhas em Status2/3/4
748:                 loc_cLinha1 = loc_oBo.ObterRetornoSerasa(loc_lnSrIdx, 1)
749:                 loc_cLinha2 = loc_oBo.ObterRetornoSerasa(loc_lnSrIdx, 2)
750:                 loc_cLinha3 = loc_oBo.ObterRetornoSerasa(loc_lnSrIdx, 3)
751:                 WITH THIS.cnt_4c_Status
752:                     .lbl_4c_Status1.Visible   = .F.
753:                     .lbl_4c_Status2.Visible   = .T.
754:                     .lbl_4c_Status3.Visible   = .T.
755:                     .lbl_4c_Status4.Visible   = .T.
756:                     .lbl_4c_Status2.ForeColor = RGB(255,0,0)
757:                     .lbl_4c_Status3.ForeColor = RGB(255,0,0)
758:                     .lbl_4c_Status4.ForeColor = RGB(255,0,0)
759:                     .lbl_4c_Status2.Caption   = loc_cLinha1
760:                     .lbl_4c_Status3.Caption   = loc_cLinha2
761:                     .lbl_4c_Status4.Caption   = loc_cLinha3
762:                 ENDWITH
763:             ENDIF
764:         ENDIF
765: 
766:         THIS.cnt_4c_Status.Refresh()

*-- Linhas 866 a 874:
866:     *==========================================================================
867:     * BtnBuscarClick - N/A (dialogo SiTef sem busca de registros)
868:     * A unica acao do dialogo e a consulta SiTef executada automaticamente
869:     * pelo GotFocus do cmd_4c_Cancela ao abrir o form.
870:     *==========================================================================
871:     PROCEDURE BtnBuscarClick()
872:         RETURN
873:     ENDPROC
874: 

*-- Linhas 883 a 891:
883: 
884:     *==========================================================================
885:     * BtnCancelarClick - Abandona a transacao SiTef e fecha o dialogo
886:     * Mesmo comportamento do cmd_4c_Cancela: sinaliza abandono ao BO e fecha.
887:     *==========================================================================
888:     PROCEDURE BtnCancelarClick()
889:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
890:             THIS.this_oBusinessObject.this_lAbandona = .T.
891:         ENDIF

*-- Linhas 963 a 983:
963:         ENDIF
964:         IF VARTYPE(THIS.cnt_4c_Status) = "O"
965:             WITH THIS.cnt_4c_Status
966:                 .lbl_4c_Status1.Caption = "Aguarde Consulta de Cheque"
967:                 .lbl_4c_Status2.Caption = ""
968:                 .lbl_4c_Status3.Caption = ""
969:                 .lbl_4c_Status4.Caption = ""
970:                 .Visible     = .T.
971:             ENDWITH
972:         ENDIF
973:     ENDPROC
974: 
975:     *==========================================================================
976:     * AjustarBotoesPorModo - N/A (dialogo SiTef sem modos CRUD)
977:     * FormSIGPRTFH tem apenas um modo operacional: consulta de cheque.
978:     * O unico botao focalizavel (cmd_4c_Cancela) permanece habilitado o tempo todo.
979:     *==========================================================================
980:     PROCEDURE AjustarBotoesPorModo()
981:         RETURN
982:     ENDPROC
983: 


### BO (C:\4c\projeto\app\classes\SIGPRTFHBO.prg):
*==============================================================================
* SIGPRTFHBO.prg - Business Object para Consulta de Cheque SiTef
* Legado: SIGPRTFH.SCX (SIGPRIFF)
* Tipo: OPERACIONAL - Integracao SiTef via CliSiTef32I.DLL
*==============================================================================

DEFINE CLASS SIGPRTFHBO AS BusinessBase

    *-- Parametros de configuracao SiTef
    this_cIP              = ""   && IP do servidor SiTef
    this_nInicio          = 0    && Modalidade SiTef (IniciaFuncaoSiTefInterativo)
    this_nIdent           = 0    && Identificador da transacao
    this_cPos             = ""   && Terminal POS
    this_cCaixa           = ""   && Operador/caixa

    *-- Dados do cheque
    this_cPraca           = ""   && Praca de compensacao
    this_cBanco           = ""   && Codigo do banco
    this_cAgencia         = ""   && Agencia
    this_cAgenciaDV       = ""   && Digito verificador da agencia
    this_cConta           = ""   && Conta corrente
    this_cContaDV         = ""   && Digito verificador da conta
    this_cNumeroCheque    = ""   && Numero do cheque
    this_cChequeDV        = ""   && Digito verificador do cheque
    this_cCMC7            = ""   && Codigo CMC7 do cheque

    *-- Dados do portador
    this_cCPF             = ""   && CPF ou CGC do portador
    this_cTipoPessoa      = ""   && Tipo de pessoa: 'F'=Fisica / 'J'=Juridica
    this_cDtCheque        = ""   && Data do cheque (string DDMMAAAA)

    *-- Dados da transacao
    this_nValor           = 0    && Valor do pagamento
    this_nParcelas        = 0    && Numero de parcelas
    this_cCupom           = ""   && Numero do cupom fiscal
    this_cCupomNV         = ""   && Cupom nao-eletronico
    this_cFuncoes         = ""   && Funcoes adicionais (lista separada por virgula)
    this_cPesquisa        = ""   && Tipo de pesquisa pre-definida

    *-- Retorno e controle
    this_cRetornoCheque   = ""   && Codigo/mensagem de retorno da consulta
    this_lAbandona        = .F.  && Indica se usuario cancelou a operacao

    *-- Dados internos da transacao SiTef (preenchidos durante ExecutarConsulta)
    this_cTipTransacao    = ""   && Tipo de transacao (TipoCampo 100)
    this_cDataHoraTEF     = ""   && Data/hora TEF (TipoCampo 105)
    this_cCupomTEF        = ""   && Cupom TEF (TipoCampo 121)
    this_cCartao          = ""   && Tipo de cartao (TipoCampo 132)
    this_cNSU             = ""   && NSU (TipoCampo 134)
    this_cAutorizacao     = ""   && Autorizacao (TipoCampo 135)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        this_cTabela      = ""
        this_cCampoChave  = ""
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        *-- Chave sintetica: identificador da transacao SiTef (nao ha tabela)
        IF THIS.this_nIdent > 0
            RETURN ALLTRIM(STR(THIS.this_nIdent, 10))
        ENDIF
        RETURN ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia dados de cursor para propriedades do BO
    * Form OPERACIONAL sem tabela persistente. Se um cursor for fornecido com
    * parametros de transacao, popula as propriedades correspondentes.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        IF VARTYPE(par_cAliasCursor) # "C" OR EMPTY(par_cAliasCursor)
            RETURN .F.
        ENDIF
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        *-- Parametros de configuracao SiTef
        IF TYPE(par_cAliasCursor + ".IP") # "U"
            THIS.this_cIP = TratarNulo(EVALUATE(par_cAliasCursor + ".IP"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Inicio") # "U"
            THIS.this_nInicio = TratarNulo(EVALUATE(par_cAliasCursor + ".Inicio"), "N")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Ident") # "U"
            THIS.this_nIdent = TratarNulo(EVALUATE(par_cAliasCursor + ".Ident"), "N")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Pos") # "U"
            THIS.this_cPos = TratarNulo(EVALUATE(par_cAliasCursor + ".Pos"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Caixa") # "U"
            THIS.this_cCaixa = TratarNulo(EVALUATE(par_cAliasCursor + ".Caixa"), "C")
        ENDIF

        *-- Dados do cheque
        IF TYPE(par_cAliasCursor + ".Praca") # "U"
            THIS.this_cPraca = TratarNulo(EVALUATE(par_cAliasCursor + ".Praca"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Banco") # "U"
            THIS.this_cBanco = TratarNulo(EVALUATE(par_cAliasCursor + ".Banco"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Agencia") # "U"
            THIS.this_cAgencia = TratarNulo(EVALUATE(par_cAliasCursor + ".Agencia"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".AgenciaDV") # "U"
            THIS.this_cAgenciaDV = TratarNulo(EVALUATE(par_cAliasCursor + ".AgenciaDV"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Conta") # "U"
            THIS.this_cConta = TratarNulo(EVALUATE(par_cAliasCursor + ".Conta"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".ContaDV") # "U"
            THIS.this_cContaDV = TratarNulo(EVALUATE(par_cAliasCursor + ".ContaDV"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".NumeroCheque") # "U"
            THIS.this_cNumeroCheque = TratarNulo(EVALUATE(par_cAliasCursor + ".NumeroCheque"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".ChequeDV") # "U"
            THIS.this_cChequeDV = TratarNulo(EVALUATE(par_cAliasCursor + ".ChequeDV"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".CMC7") # "U"
            THIS.this_cCMC7 = TratarNulo(EVALUATE(par_cAliasCursor + ".CMC7"), "C")
        ENDIF

        *-- Dados do portador
        IF TYPE(par_cAliasCursor + ".CPF") # "U"
            THIS.this_cCPF = TratarNulo(EVALUATE(par_cAliasCursor + ".CPF"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".TipoPessoa") # "U"
            THIS.this_cTipoPessoa = TratarNulo(EVALUATE(par_cAliasCursor + ".TipoPessoa"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".DtCheque") # "U"
            THIS.this_cDtCheque = TratarNulo(EVALUATE(par_cAliasCursor + ".DtCheque"), "C")
        ENDIF

        *-- Dados da transacao
        IF TYPE(par_cAliasCursor + ".Valor") # "U"
            THIS.this_nValor = TratarNulo(EVALUATE(par_cAliasCursor + ".Valor"), "N")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Parcelas") # "U"
            THIS.this_nParcelas = TratarNulo(EVALUATE(par_cAliasCursor + ".Parcelas"), "N")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Cupom") # "U"
            THIS.this_cCupom = TratarNulo(EVALUATE(par_cAliasCursor + ".Cupom"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".CupomNV") # "U"
            THIS.this_cCupomNV = TratarNulo(EVALUATE(par_cAliasCursor + ".CupomNV"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Funcoes") # "U"
            THIS.this_cFuncoes = TratarNulo(EVALUATE(par_cAliasCursor + ".Funcoes"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Pesquisa") # "U"
            THIS.this_cPesquisa = TratarNulo(EVALUATE(par_cAliasCursor + ".Pesquisa"), "C")
        ENDIF

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Executa consulta de cheque via SiTef (equivale a "gravar" no
    * fluxo do form OPERACIONAL). Sem tabela persistente: o "insert" e a
    * emissao dos arquivos de retorno IntPos.001 / IntPos.STS para o PDV.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = .T.
        THIS.this_cMensagemErro = ""

        TRY
            *-- Valida parametros minimos antes de disparar a transacao SiTef
            IF EMPTY(THIS.this_cIP)
                THIS.this_cMensagemErro = "IP do servidor SiTef nao informado."
                loc_lSucesso = .F.
            ENDIF
            IF loc_lSucesso AND EMPTY(THIS.this_cPos)
                THIS.this_cMensagemErro = "Terminal POS nao informado."
                loc_lSucesso = .F.
            ENDIF
            IF loc_lSucesso AND THIS.this_nIdent <= 0
                THIS.this_cMensagemErro = "Identificador de transa" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido."
                loc_lSucesso = .F.
            ENDIF
            IF loc_lSucesso AND THIS.this_nValor <= 0
                THIS.this_cMensagemErro = "Valor da transa" + CHR(231) + CHR(227) + "o deve ser maior que zero."
                loc_lSucesso = .F.
            ENDIF

            *-- Executa o loop SiTef
            IF loc_lSucesso
                loc_lSucesso = THIS.ExecutarConsulta()
                IF !loc_lSucesso
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Falha na consulta SiTef: " + ALLTRIM(THIS.this_cRetornoCheque)
                    ENDIF
                    *-- Emite arquivo de falha para o PDV
                    THIS.RetornoFalha(THIS.this_cMensagemErro, THIS.this_nValor)
                ELSE
                    *-- Emite arquivo de sucesso com dados retornados pelo SiTef
                    THIS.MontaRetorno(THIS.this_cTipTransacao, THIS.this_cDataHoraTEF, ;
                        THIS.this_cCupomTEF, THIS.this_cCartao, THIS.this_cNSU, ;
                        THIS.this_cAutorizacao, "0", THIS.this_nValor, ;
                        THIS.this_cRetornoCheque)
                    *-- Registra auditoria da consulta (ObterChavePrimaria usa this_nIdent)
                    THIS.RegistrarAuditoria("CONSULTA_CHEQUE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Inserir SiTef: " + loc_oErro.Message + ;
                " LN=" + TRANSFORM(loc_oErro.LineNo)
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Reexecuta a consulta SiTef mantendo o mesmo Ident
    * (permite ao PDV reprocessar uma transacao com dados atualizados).
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF THIS.this_nIdent <= 0
                THIS.this_cMensagemErro = "Identificador de transa" + CHR(231) + CHR(227) + ;
                    "o inv" + CHR(225) + "lido para reprocessamento."
                loc_lSucesso = .F.
            ENDIF

            IF loc_lSucesso
                loc_lSucesso = THIS.ExecutarConsulta()
                IF !loc_lSucesso
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Falha ao reprocessar consulta SiTef: " + ;
                            ALLTRIM(THIS.this_cRetornoCheque)
                    ENDIF
                    THIS.RetornoFalha(THIS.this_cMensagemErro, THIS.this_nValor)
                ELSE
                    THIS.MontaRetorno(THIS.this_cTipTransacao, THIS.this_cDataHoraTEF, ;
                        THIS.this_cCupomTEF, THIS.this_cCartao, THIS.this_cNSU, ;
                        THIS.this_cAutorizacao, "0", THIS.this_nValor, ;
                        THIS.this_cRetornoCheque)
                    THIS.RegistrarAuditoria("REPROCESSA_CHEQUE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Atualizar SiTef: " + loc_oErro.Message + ;
                " LN=" + TRANSFORM(loc_oErro.LineNo)
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ErroTef - Trata codigos de erro retornados pelo SiTef
    *==========================================================================
    PROCEDURE ErroTef(par_nRetornos)
        DO CASE
        CASE par_nRetornos = -1
            THIS.this_cRetornoCheque = "Modulo Nao Iniciado"
        CASE par_nRetornos = -2
            THIS.this_cRetornoCheque = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario"
        CASE par_nRetornos = -3
            THIS.this_cRetornoCheque = "Fornecida uma Modalidade Invalida"
        CASE par_nRetornos = -4
            THIS.this_cRetornoCheque = "Falta Memoria para Rodar a Fun" + CHR(231) + CHR(227) + "o"
        CASE par_nRetornos = -5
            THIS.this_cRetornoCheque = "Sem Comunica" + CHR(231) + CHR(227) + "o com o SiTef"
        ENDCASE
    ENDPROC

    *==========================================================================
    * RetornoFalha - Gera arquivo de retorno de falha para o PDV integrador
    * par_lcMensagem - Mensagem de erro
    * par_lnValPago  - Valor pago (0 em caso de falha)
    *==========================================================================
    PROCEDURE RetornoFalha(par_lcMensagem, par_lnValPago)
        LOCAL loc_lcMensagem, loc_lsValPago, loc_lSucesso

        loc_lSucesso = .T.
        TRY
            loc_lcMensagem = IIF(EMPTY(par_lcMensagem), ;
                "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", ;
                par_lcMensagem)

            loc_lsValPago = STRTRAN(ALLTRIM(TRANSFORM(par_lnValPago, "99999999999.99")), ".", ",")

            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + ALLTRIM(STR(THIS.this_nIdent, 10)))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_lsValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + loc_lcMensagem)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            IF FILE("C:\client\Resp\IntPos.001")
                COPY TO "C:\client\Resp\IntPos.001" SDF
            ENDIF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + ALLTRIM(STR(THIS.this_nIdent, 10)))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            IF FILE("C:\client\Resp\IntPos.STS")
                COPY TO "C:\client\Resp\IntPos.STS" SDF
            ENDIF

            USE IN crSiTef

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro SiTef RetornoFalha")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontaRetorno - Gera arquivos de retorno para o PDV integrador
    * par_lsTipTran  - Tipo de transacao
    * par_lsDataHora - Data/hora da transacao
    * par_lsCupom    - Cupom TEF
    * par_lsCartao   - Tipo de cartao
    * par_lsNsu      - NSU
    * par_lsAutoriza - Autorizacao
    * par_lsFinaliza - Finalizacao
    * par_lnValPago  - Valor pago
    * par_lsMenRet   - Mensagem de retorno
    *==========================================================================
    PROCEDURE MontaRetorno(par_lsTipTran, par_lsDataHora, par_lsCupom, par_lsCartao, ;
                           par_lsNsu, par_lsAutoriza, par_lsFinaliza, par_lnValPago, par_lsMenRet)
        LOCAL loc_lsValPago, loc_laCartao, loc_lsCupomTemp, loc_lsPos, loc_lnLinha
        LOCAL loc_lSucesso

        loc_lSucesso = .T.
        TRY
            loc_lsValPago = STRTRAN(ALLTRIM(TRANSFORM(par_lnValPago, "99999999999.99")), ".", ",")

            DIMENSION loc_laCartao[11]
            loc_laCartao[1]  = "Outro, nao definido"
            loc_laCartao[2]  = "Visa"
            loc_laCartao[3]  = "Mastercard"
            loc_laCartao[4]  = "Diners"
            loc_laCartao[5]  = "American Express"
            loc_laCartao[6]  = "Sollo"
            loc_laCartao[7]  = "Sidecard (Redecard)"
            loc_laCartao[8]  = "Private Label (Redecard)"
            loc_laCartao[9]  = "Redeshop"
            loc_laCartao[10] = ""
            loc_laCartao[11] = "Fininvest"

            IF VAL(par_lsCartao) > 10 OR VAL(par_lsCartao) < 0
                par_lsCartao = "0"
            ENDIF

            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + ALLTRIM(STR(THIS.this_nIdent, 10)))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_lsValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_laCartao[VAL(par_lsCartao) + 1])
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_lsTipTran)
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_lsNsu)
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_lsAutoriza)
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
                SUBSTR(par_lsDataHora, 7, 2) + SUBSTR(par_lsDataHora, 5, 2) + SUBSTR(par_lsDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
                SUBSTR(par_lsDataHora, 7, 2) + SUBSTR(par_lsDataHora, 5, 2) + SUBSTR(par_lsDataHora, 1, 4))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_lsDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_lsFinaliza)
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_lsDataHora, 9, 6))

            loc_lsCupomTemp = par_lsCupom
            loc_lsPos       = 1
            loc_lnLinha     = 1
            DO WHILE loc_lsPos <> 0
                loc_lsPos = AT(CHR(10), loc_lsCupomTemp)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_lnLinha, "@L 999") + " = " + ;
                    IIF(loc_lsPos <> 0, SUBSTR(loc_lsCupomTemp, 1, loc_lsPos - 1), loc_lsCupomTemp))
                loc_lsCupomTemp = SUBSTR(loc_lsCupomTemp, loc_lsPos + 1)
                loc_lnLinha     = loc_lnLinha + 1
            ENDDO

            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_lnLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_lsMenRet)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            IF FILE("C:\client\Resp\IntPos.001")
                COPY TO "C:\client\Resp\IntPos.001" SDF
            ENDIF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + ALLTRIM(STR(THIS.this_nIdent, 10)))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            IF FILE("C:\client\Resp\IntPos.STS")
                COPY TO "C:\client\Resp\IntPos.STS" SDF
            ENDIF

            USE IN crSiTef

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro SiTef MontaRetorno")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Popula propriedades do BO com os parametros recebidos
    * Chamado pelo Form antes de exibir (substitui init parametrizado do legado)
    *==========================================================================
    PROCEDURE CarregarParametros(par_cIP, par_nInicio, par_nValor, par_cCupom, ;
                                  par_cCaixa, par_nIdent, par_cPos, par_nParcelas, ;
                                  par_cFuncoes, par_cBanco, par_cAgencia, par_cConta, ;
                                  par_cNumeroCheque, par_cDtCheque, par_cCPF, ;
                                  par_cTipoPessoa, par_cCupomNV, par_cAgenciaDV, ;
                                  par_cContaDV, par_cChequeDV, par_cPraca, ;
                                  par_cPesquisa, par_cCMC7)
        THIS.this_cIP             = IIF(VARTYPE(par_cIP)          = "C", par_cIP,          "")
        THIS.this_nInicio         = IIF(VARTYPE(par_nInicio)       = "N", par_nInicio,       0)
        THIS.this_nValor          = IIF(VARTYPE(par_nValor)        = "N", par_nValor,        0)
        THIS.this_cCupom          = IIF(VARTYPE(par_cCupom)        = "C", par_cCupom,        "")
        THIS.this_cCaixa          = IIF(VARTYPE(par_cCaixa)        = "C", par_cCaixa,        "")
        THIS.this_nIdent          = IIF(VARTYPE(par_nIdent)        = "N", par_nIdent,        0)
        THIS.this_cPos            = IIF(VARTYPE(par_cPos)          = "C", par_cPos,          "")
        THIS.this_nParcelas       = IIF(VARTYPE(par_nParcelas)     = "N", par_nParcelas,     0)
        THIS.this_cFuncoes        = IIF(VARTYPE(par_cFuncoes)      = "C", par_cFuncoes,      "")
        THIS.this_cBanco          = IIF(VARTYPE(par_cBanco)        = "C", par_cBanco,        "")
        THIS.this_cAgencia        = IIF(VARTYPE(par_cAgencia)      = "C", par_cAgencia,      "")
        THIS.this_cConta          = IIF(VARTYPE(par_cConta)        = "C", par_cConta,        "")
        THIS.this_cNumeroCheque   = IIF(VARTYPE(par_cNumeroCheque) = "C", par_cNumeroCheque, "")
        THIS.this_cDtCheque       = IIF(VARTYPE(par_cDtCheque)     = "C", par_cDtCheque,     "")
        THIS.this_cCPF            = IIF(VARTYPE(par_cCPF)          = "C", par_cCPF,          "")
        THIS.this_cTipoPessoa     = IIF(VARTYPE(par_cTipoPessoa)   = "C", par_cTipoPessoa,   "F")
        THIS.this_cCupomNV        = IIF(VARTYPE(par_cCupomNV)      = "C", par_cCupomNV,      "")
        THIS.this_cAgenciaDV      = IIF(VARTYPE(par_cAgenciaDV)    = "C", par_cAgenciaDV,    "")
        THIS.this_cContaDV        = IIF(VARTYPE(par_cContaDV)      = "C", par_cContaDV,      "")
        THIS.this_cChequeDV       = IIF(VARTYPE(par_cChequeDV)     = "C", par_cChequeDV,     "")
        THIS.this_cPraca          = IIF(VARTYPE(par_cPraca)        = "C", par_cPraca,        "")
        THIS.this_cPesquisa       = IIF(VARTYPE(par_cPesquisa)     = "C", par_cPesquisa,     "")
        THIS.this_cCMC7           = IIF(VARTYPE(par_cCMC7)         = "C", par_cCMC7,         "")

        THIS.this_cRetornoCheque  = ""
        THIS.this_lAbandona       = .F.
        THIS.this_cTipTransacao   = ""
        THIS.this_cDataHoraTEF    = ""
        THIS.this_cCupomTEF       = ""
        THIS.this_cCartao         = ""
        THIS.this_cNSU            = ""
        THIS.this_cAutorizacao    = ""
    ENDPROC

    *==========================================================================
    * ObterRetornoSerasa - Retorna texto descritivo para codigo Serasa
    * par_nIndice - Indice (1..8) do array RetSerasa
    * par_nLinha  - Linha (1..3) da descricao
    *==========================================================================
    FUNCTION ObterRetornoSerasa(par_nIndice, par_nLinha)
        LOCAL loc_laRetSerasa

        DIMENSION loc_laRetSerasa[8, 3]
        loc_laRetSerasa[1, 1] = ""
        loc_laRetSerasa[1, 2] = "Aprovado"
        loc_laRetSerasa[1, 3] = ""

        loc_laRetSerasa[2, 1] = "Banco Nao Existe ou"
        loc_laRetSerasa[2, 2] = "Nao Trabalha com Conta Corrente ou"
        loc_laRetSerasa[2, 3] = "Esta em Processo de Liquidacao"

        loc_laRetSerasa[3, 1] = "Pagamento de Compra com Cheque Pre"
        loc_laRetSerasa[3, 2] = "por Cliente Nao Cadastrado no "
        loc_laRetSerasa[3, 3] = "Estabelecimento"

        loc_laRetSerasa[4, 1] = ""
        loc_laRetSerasa[4, 2] = "Realizar Consulta Analitica"
        loc_laRetSerasa[4, 3] = ""

        loc_laRetSerasa[5, 1] = ""
        loc_laRetSerasa[5, 2] = "Falha no Processo de Consulta"
        loc_laRetSerasa[5, 3] = ""

        loc_laRetSerasa[6, 1] = "Excedido Limite para Pagamento"
        loc_laRetSerasa[6, 2] = "de Compras com Cheque Pre-Datados"
        loc_laRetSerasa[6, 3] = "Determinado pelo Estabelecimento"

        loc_laRetSerasa[7, 1] = ""
        loc_laRetSerasa[7, 2] = "Cheque Maior que o Limite de Compra"
        loc_laRetSerasa[7, 3] = ""

        loc_laRetSerasa[8, 1] = "Cliente Cadastrado Alem do Prazo"
        loc_laRetSerasa[8, 2] = "Definido pelo Estabelecimento para"
        loc_laRetSerasa[8, 3] = "Validade do Cartao provisorio"

        IF par_nIndice >= 1 AND par_nIndice <= 8 AND par_nLinha >= 1 AND par_nLinha <= 3
            RETURN loc_laRetSerasa[par_nIndice, par_nLinha]
        ENDIF

        RETURN ""
    ENDFUNC

    *==========================================================================
    * ObterCodigoSerasa - Retorna o codigo Serasa por indice (1..8)
    *==========================================================================
    FUNCTION ObterCodigoSerasa(par_nIndice)
        LOCAL loc_laCodSerasa

        DIMENSION loc_laCodSerasa[8]
        loc_laCodSerasa[1] = "00"
        loc_laCodSerasa[2] = "19"
        loc_laCodSerasa[3] = "56"
        loc_laCodSerasa[4] = "57"
        loc_laCodSerasa[5] = "60"
        loc_laCodSerasa[6] = "61"
        loc_laCodSerasa[7] = "65"
        loc_laCodSerasa[8] = "76"

        IF par_nIndice >= 1 AND par_nIndice <= 8
            RETURN loc_laCodSerasa[par_nIndice]
        ENDIF

        RETURN ""
    ENDFUNC

    *==========================================================================
    * CarregarDLL - Declara as funcoes da DLL CliSiTef32I para uso em runtime
    * Deve ser chamado pelo Form antes de ExecutarConsulta (equivale ao Load original)
    *==========================================================================
    PROCEDURE CarregarDLL()
        LOCAL loc_oErro
        TRY
            DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                String lsEndereco, String lsLoja, String lsTerminal, Integer lnReservado
            DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnModalidade, String lsValor, String lsCupom, ;
                String lsData, String lsHorario, String lsOperador, String lsRestricao
            DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer @lnComando, Integer @lnTipo, Integer @lnMinimo, ;
                Integer @lnMaximo, String @lsBuffer, Integer lnTamanho, Integer lnResultado
            DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnConfirma, String lsCupom, String lsData, String lsHorario
        CATCH TO loc_oErro
            IF !("already" $ LOWER(loc_oErro.Message))
                MsgErro(loc_oErro.Message, "Erro ao carregar DLL SiTef")
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * ExecutarConsulta - Loop interativo de consulta de cheque via SiTef DLL
    * Equivale ao CANCELA.GotFocus do legado (logica principal da integracao)
    * Popula this_cRetornoCheque e campos de retorno da transacao
    * Retorna .T. se consulta completou; .F. se abortou por erro/cancelamento
    *==========================================================================
    PROCEDURE ExecutarConsulta()
        LOCAL loc_lSucesso, loc_lAbortou
        LOCAL loc_lsIdTerminal, loc_lnValPago
        LOCAL loc_lsMensagem, loc_lMRet
        LOCAL loc_lnNumParcs, loc_lsValores, loc_lsDatas, loc_lcTitulo
        LOCAL loc_lnPos, loc_lnCarSen, loc_lnTipo, loc_lnCard, loc_lsOpcaoC
        LOCAL loc_lsMensagem1
        LOCAL loc_lnStts, loc_lnProximoComando, loc_lnTipoCampo, loc_lnTamanhoMin
        LOCAL loc_lnTamanhoMax, loc_lcBuffer, loc_lnResultado
        LOCAL loc_lcData, loc_lcHora
        LOCAL loc_lnFuncoesDim, loc_lnCommaCount, loc_lnFPOS, loc_lnSrSearch, loc_lnSrIdx
        LOCAL loc_lLpTipo, loc_lTipoDados, loc_lEscolhas, loc_lValores, loc_lcDDCHQ
        LOCAL loc_oErro

        loc_lSucesso = .T.
        loc_lAbortou = .F.

        TRY
            *-- Parse das funcoes adicionais (separa string "1,2,3" em array)
            IF !EMPTY(THIS.this_cFuncoes)
                loc_lnCommaCount = OCCURS(",", THIS.this_cFuncoes)
                loc_lnFuncoesDim = loc_lnCommaCount + 1
                DIMENSION loc_laFuncoes[loc_lnFuncoesDim]
                FOR loc_lnFPOS = 1 TO loc_lnCommaCount
                    loc_laFuncoes[loc_lnFPOS] = SUBSTR(THIS.this_cFuncoes, ;
                        IIF(loc_lnFPOS = 1, 1, AT(",", THIS.this_cFuncoes, loc_lnFPOS) + 1), 1)
                NEXT
                loc_laFuncoes[loc_lnFuncoesDim] = SUBSTR(THIS.this_cFuncoes, LEN(THIS.this_cFuncoes), 1)
            ELSE
                loc_lnFuncoesDim = 1
                DIMENSION loc_laFuncoes[1]
                loc_laFuncoes[1] = ""
                THIS.this_cFuncoes = ""
            ENDIF

            loc_lsIdTerminal = "00000" + go_4c_Sistema.cCodEmpresa
            loc_lnValPago    = ALLTRIM(STRTRAN(TRANSFORM(THIS.this_nValor, "999999999.99"), ".", ","))

            *-- Configurar terminal SiTef
            IF ConfiguraIntSiTefInterativo(THIS.this_cIP, loc_lsIdTerminal, THIS.this_cPos, 0) <> 0
                DO SigTfSup WITH "P", "Sem comunicacao com SiTef", "", "", "", "", ;
                    "", "", "", loc_lnValPago, "", THIS.this_nIdent
                loc_lAbortou = .T.
            ENDIF

            *-- Iniciar funcao SiTef
            IF !loc_lAbortou
                loc_lcData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
                loc_lcHora = STRTRAN(TIME(), ":", "")
                IF IniciaFuncaoSiTefInterativo(THIS.this_nInicio, loc_lnValPago, ;
                        THIS.this_cCupom, loc_lcData, loc_lcHora, THIS.this_cCaixa, "") <> 10000
                    DO SigTfSup WITH "P", "Sem comunicacao com SiTef", "", "", "", "", ;
                        "", "", "", loc_lnValPago, "", THIS.this_nIdent
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *-- Loop principal de interacao com a DLL SiTef
            IF !loc_lAbortou
                loc_lnStts           = 10000
                loc_lnProximoComando = 0
                loc_lnTipoCampo      = 0
                loc_lnTamanhoMin     = 0
                loc_lnTamanhoMax     = 0
                loc_lcBuffer         = SPACE(2000)
                loc_lnResultado      = 0
                loc_lsMensagem       = ""
                loc_lnNumParcs       = ALLTRIM(STR(THIS.this_nParcelas))
                loc_lsValores        = "0,00"
                loc_lsDatas          = ""
                loc_lcTitulo         = ""
                loc_lnPos            = 1
                loc_lnCarSen         = 1
                loc_lnTipo           = 1
                loc_lnCard           = 1
                loc_lsOpcaoC         = "0"
                loc_lsMensagem1      = ""

                DO WHILE loc_lnStts = 10000
                    loc_lnStts = ContinuaFuncaoSiTefInterativo( ;
                        @loc_lnProximoComando, @loc_lnTipoCampo, ;
                        @loc_lnTamanhoMin, @loc_lnTamanhoMax, ;
                        @loc_lcBuffer, LEN(ALLTRIM(loc_lcBuffer)), loc_lnResultado)
                    loc_lnResultado = 0

                    IF loc_lnStts = -2
                        loc_lsMensagem = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario"
                        EXIT
                    ENDIF
                    IF loc_lnStts <> 10000
                        loc_lsMensagem = ALLTRIM(loc_lcBuffer)
                        EXIT
                    ENDIF

                    IF loc_lnStts = 10000
                        IF !EMPTY(loc_lsMensagem)
                            THIS.this_cRetornoCheque = loc_lsMensagem
                            IF !EMPTY(THIS.this_cBanco)
                                THIS.this_cRetornoCheque = "00" + ALLTRIM(loc_lsMensagem)
                            ENDIF
                            loc_lsMensagem = ""
                        ENDIF

                        *-- Comando 21: pesquisa pre-definida (funcao "1")
                        IF loc_lnProximoComando = 21 AND THIS.this_cFuncoes = "1"
                            IF loc_lnTipo = 1
                                loc_lcBuffer    = "1" + REPLICATE(CHR(0), 1999)
                                loc_lnResultado = 1000
                                loc_lnTipo      = 2
                                LOOP
                            ENDIF
                            IF loc_lnTipo = 2
                                IF EMPTY(THIS.this_cPesquisa)
                                    DO FORM SigCqTef TO loc_lsOpcaoC
                                ELSE
                                    loc_lsOpcaoC = THIS.this_cPesquisa
                                ENDIF
                                IF loc_lsOpcaoC = "0"
                                    DO FORM SigTfDss WITH ;
                                        "Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                                        "", "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                                        "", "", "VM", 0, 0
                                    loc_lAbortou = .T.
                                    EXIT
                                ENDIF
                                loc_lcBuffer    = loc_lsOpcaoC + REPLICATE(CHR(0), 1999)
                                loc_lnResultado = 1000
                                loc_lnTipo      = 3
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Comando 30: dados do portador (funcao "1")
                        IF loc_lnProximoComando = 30 AND THIS.this_cFuncoes = "1"
                            IF loc_lnCard = 1
                                loc_lcBuffer    = IIF(THIS.this_cTipoPessoa = "F", "0", "1") + REPLICATE(CHR(0), 1999)
                                loc_lnResultado = 1000
                                loc_lnCard      = 2
                                LOOP
                            ENDIF
                            IF loc_lnCard = 2
                                loc_lcBuffer    = THIS.this_cCPF + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cCPF))
                                loc_lnResultado = 1000
                                loc_lnCard      = 3
                                LOOP
                            ENDIF
                            IF loc_lnCard = 3
                                loc_lcBuffer    = THIS.this_cDtCheque + REPLICATE(CHR(0), 1992)
                                loc_lnResultado = 1000
                                loc_lnCard      = 4
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Comando 31: dados do cheque via CMC7 ou campos (funcao "1")
                        IF loc_lnProximoComando = 31 AND THIS.this_cFuncoes = "1"
                            IF EMPTY(THIS.this_cCMC7)
                                loc_lcBuffer = "0:" + THIS.this_cPraca + THIS.this_cBanco + ;
                                    THIS.this_cAgencia + THIS.this_cAgenciaDV + ;
                                    PADR(THIS.this_cConta, 10) + THIS.this_cContaDV + ;
                                    THIS.this_cNumeroCheque + THIS.this_cChequeDV
                            ELSE
                                loc_lcBuffer = "1:" + THIS.this_cCMC7
                            ENDIF
                            loc_lcBuffer = loc_lcBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_lcBuffer))
                            LOOP
                        ENDIF

                        *-- Comando 31 + tipo 517: data do cheque via dialog SIGCHTEF
                        IF loc_lnProximoComando = 31 AND loc_lnTipoCampo = 517
                            loc_lcDDCHQ  = ""
                            DO FORM SIGCHTEF TO loc_lcDDCHQ
                            loc_lcBuffer = loc_lcDDCHQ + REPLICATE(CHR(0), 2000 - LEN(loc_lcDDCHQ))
                            LOOP
                        ENDIF

                        *-- Comandos de entrada interativa (30, 21, 34, 20, 31)
                        IF loc_lnProximoComando = 30 OR loc_lnProximoComando = 21 OR ;
                           loc_lnProximoComando = 34 OR loc_lnProximoComando = 20 OR ;
                           loc_lnProximoComando = 31

                            IF loc_lnProximoComando = 21
                                loc_lLpTipo = "M"
                            ELSE
                                loc_lLpTipo = "N"
                            ENDIF
                            IF loc_lnProximoComando = 30 OR loc_lnProximoComando = 34 OR ;
                               loc_lnProximoComando = 20
                                loc_lcTitulo = ALLTRIM(loc_lcBuffer)
                            ENDIF

                            IF !EMPTY(THIS.this_cFuncoes) AND loc_lnPos <= loc_lnFuncoesDim
                                loc_lcBuffer    = loc_laFuncoes[loc_lnPos]
                                loc_lcBuffer    = loc_lcBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_lcBuffer))
                                loc_lnResultado = 1000
                                loc_lnPos       = loc_lnPos + 1
                                LOOP
                            ELSE
                                IF loc_lnProximoComando = 30 AND ;
                                   (loc_lnTipoCampo = 505 OR loc_lnTipoCampo = 511) AND ;
                                   THIS.this_nParcelas <> 0
                                    loc_lcBuffer        = ALLTRIM(TRANSFORM(THIS.this_nParcelas, "@L 99")) + ;
                                        REPLICATE(CHR(0), 1998)
                                    THIS.this_nParcelas = 0
                                    loc_lnResultado     = 1000
                                    LOOP
                                ENDIF

                                loc_lTipoDados = ""
                                IF loc_lnTipoCampo = 504 OR loc_lnTipoCampo = 506 OR ;
                                   loc_lnTipoCampo = 515 OR "DDMMAAAA" $ loc_lcBuffer
                                    loc_lTipoDados = "D"
                                ENDIF
                                IF loc_lnTipoCampo = 130
                                    loc_lTipoDados = "V"
                                ENDIF
                                IF loc_lnProximoComando = 20
                                    loc_lEscolhas = "0:Sim;1:N" + CHR(227) + "o;"
                                    loc_lcTitulo  = ALLTRIM(loc_lcBuffer)
                                    loc_lLpTipo   = "M"
                                ELSE
                                    loc_lEscolhas = ALLTRIM(loc_lcBuffer)
                                ENDIF

                                loc_lValores = ""
                                DO FORM FormSIGPRTFH WITH loc_lEscolhas, loc_lLpTipo, loc_lcTitulo, ;
                                    loc_lnTamanhoMin, loc_lnTamanhoMax, loc_lTipoDados TO loc_lValores

                                IF loc_lnProximoComando = 30 AND ;
                                   (loc_lnTipoCampo = 505 OR loc_lnTipoCampo = 511)
                                    loc_lnNumParcs = loc_lValores
                                ENDIF
                                IF EMPTY(loc_lValores) OR ISNULL(loc_lValores)
                                    DO SigTfSup WITH "P", ;
                                        "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                                        "", "", "", "", "", "", "", loc_lnValPago, "", THIS.this_nIdent
                                    loc_lAbortou = .T.
                                    EXIT
                                ENDIF
                                IF loc_lnTipoCampo = 504 OR loc_lnTipoCampo = 506 OR ;
                                   loc_lnTipoCampo = 515 OR "DDMMAAAA" $ loc_lcBuffer
                                    loc_lValores = DTOC(loc_lValores)
                                    loc_lsDatas  = loc_lValores
                                    loc_lValores = SUBSTR(loc_lValores, 1, 2) + ;
                                        SUBSTR(loc_lValores, 4, 2) + SUBSTR(loc_lValores, 7, 4)
                                ENDIF
                                IF loc_lnTipoCampo = 130
                                    loc_lValores  = STRTRAN(ALLTRIM(TRANSFORM(loc_lValores, "99999999.99")), ".", ",")
                                    loc_lsValores = loc_lValores
                                ENDIF
                                loc_lcBuffer = ALLTRIM(loc_lValores)
                                loc_lcBuffer = loc_lcBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_lcBuffer))
                                loc_lcTitulo = ""
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Comando 23: aguardar passe/insercao de cartao ou senha
                        IF loc_lnProximoComando = 23
                            IF loc_lnCarSen = 1
                                WAIT WINDOW "Passe ou Insira o Cart" + CHR(227) + "o" NOWAIT
                            ELSE
                                WAIT WINDOW "Digite a Senha" NOWAIT
                            ENDIF
                            LOOP
                        ENDIF
                        IF loc_lnProximoComando = 13
                            WAIT CLEAR
                            loc_lnCarSen = 2
                        ENDIF
                        IF loc_lnProximoComando = 4
                            loc_lcTitulo = ALLTRIM(loc_lcBuffer)
                        ENDIF
                        IF loc_lnProximoComando = 3
                            loc_lMRet = ALLTRIM(loc_lcBuffer)
                        ENDIF
                        IF loc_lnProximoComando = 22
                            loc_lsMensagem = ALLTRIM(STRTRAN(loc_lcBuffer, CHR(0), ""))
                            LOOP
                        ENDIF

                        *-- Capturar campos de retorno da transacao SiTef
                        IF loc_lnTipoCampo = 100
                            THIS.this_cTipTransacao = loc_lcBuffer
                        ENDIF
                        IF loc_lnTipoCampo = 105
                            THIS.this_cDataHoraTEF = loc_lcBuffer
                        ENDIF
                        IF loc_lnTipoCampo = 121
                            THIS.this_cCupomTEF = loc_lcBuffer
                        ENDIF
                        IF loc_lnTipoCampo = 132
                            THIS.this_cCartao = loc_lcBuffer
                        ENDIF
                        IF loc_lnTipoCampo = 134
                            THIS.this_cNSU = ALLTRIM(STR(VAL(loc_lcBuffer)))
                        ENDIF
                        IF loc_lnTipoCampo = 135
                            THIS.this_cAutorizacao = loc_lcBuffer
                        ENDIF
                        IF loc_lsOpcaoC = "4" AND loc_lnStts <> 0
                            loc_lsMensagem1 = ALLTRIM(loc_lcBuffer)
                        ENDIF

                        IF loc_lnProximoComando <> 30 AND loc_lnProximoComando <> 21 AND ;
                           loc_lnProximoComando <> 34 AND loc_lnProximoComando <> 20 AND ;
                           loc_lnProximoComando <> 31
                            loc_lcBuffer = SPACE(2000)
                        ENDIF
                    ENDIF
                ENDDO

                *-- Processar resultado final: verificar codigo Serasa
                IF !loc_lAbortou AND loc_lnStts <> 1000 AND loc_lnStts <> 0
                    loc_lnSrIdx = 0
                    FOR loc_lnSrSearch = 1 TO 8
                        IF THIS.ObterCodigoSerasa(loc_lnSrSearch) = SUBSTR(loc_lcBuffer, 1, 2)
                            loc_lnSrIdx = loc_lnSrSearch
                            EXIT
                        ENDIF
                    NEXT
                    IF loc_lnSrIdx = 0
                        THIS.this_cRetornoCheque = ALLTRIM(loc_lcBuffer)
                    ELSE
                        THIS.this_cRetornoCheque = SUBSTR(loc_lcBuffer, 1, 2) + ;
                            THIS.ObterRetornoSerasa(loc_lnSrIdx, 1) + " " + ;
                            THIS.ObterRetornoSerasa(loc_lnSrIdx, 2) + " " + ;
                            THIS.ObterRetornoSerasa(loc_lnSrIdx, 3)
                    ENDIF
                ENDIF

                IF loc_lAbortou
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExecutarConsulta SiTef")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

