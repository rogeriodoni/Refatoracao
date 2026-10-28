# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [LAYOUT-POSITION] Controle 'Banco' (parent: SIGOPCHB): Left original=127 vs migrado 'txt_4c_Banco' Left=167 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Conta' (parent: SIGOPCHB): Left original=127 vs migrado 'txt_4c_Conta' Left=167 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cheque' (parent: SIGOPCHB): Left original=119 vs migrado 'txt_4c_Cheque' Left=167 (diff=48px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChb.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1308 linhas total):

*-- Linhas 207 a 240:
207:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
208: 
209:                 THIS.ConfigurarCabecalho()
210:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
211:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
212: 
213:                 THIS.ConfigurarGrupos()
214:                 THIS.InicializarCriteriosBusca()
215:                 THIS.ConfigurarCamposBusca1()
216:                 THIS.ConfigurarCamposBusca2()
217:                 THIS.AplicarValoresIniciaisBusca()
218:                 THIS.ConfigurarEventosBusca()
219:                 THIS.ConfigurarBotoesAcao()
220: 
221:                 *-- Equivalente ao ThisForm.GetBanco.SetFocus no fim do Init
222:                 *-- legado. Guardado por gb_4c_ValidandoUI - SetFocus exige
223:                 *-- form visivel e a validacao de UI instancia sem Show().
224:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
225:                     THIS.txt_4c_Banco.SetFocus()
226:                 ENDIF
227: 
228:                 loc_lSucesso = .T.
229:             ENDIF
230:         CATCH TO loc_oErro
231:             MsgErro(loc_oErro.Message + CHR(13) + ;
232:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
233:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpChb.InicializarForm")
234:         ENDTRY
235: 
236:         RETURN loc_lSucesso
237:     ENDPROC
238: 
239:     *==================================================================
240:     * ConfigurarCabecalho - Container cinza escuro com o titulo do dialogo

*-- Linhas 246 a 294:
246:         THIS.AddObject("cnt_4c_Sombra", "Container")
247:         loc_oCnt = THIS.cnt_4c_Sombra
248:         WITH loc_oCnt
249:             .Top         = 0
250:             .Left        = 0
251:             .Width       = THIS.Width
252:             .Height      = 80
253:             .BorderWidth = 0
254:             .BackColor   = RGB(100, 100, 100)
255:             .Visible     = .T.
256:         ENDWITH
257: 
258:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
259:         WITH loc_oCnt.lbl_4c_Sombra
260:             .FontBold      = .T.
261:             .FontName      = "Tahoma"
262:             .FontSize      = 18
263:             .FontUnderline = .F.
264:             .WordWrap      = .T.
265:             .Alignment     = 0
266:             .BackStyle     = 0
267:             .AutoSize      = .F.
268:             .Caption       = "Procurar"
269:             .Height        = 40
270:             .Left          = 10
271:             .Top           = 18
272:             .Width         = THIS.Width - 21
273:             .ForeColor     = RGB(0, 0, 0)
274:             .Visible       = .T.
275:         ENDWITH
276: 
277:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
278:         WITH loc_oCnt.lbl_4c_Titulo
279:             .FontBold  = .T.
280:             .FontName  = "Tahoma"
281:             .FontSize  = 18
282:             .WordWrap  = .T.
283:             .Alignment = 0
284:             .BackStyle = 0
285:             .AutoSize  = .F.
286:             .Caption   = "Procurar"
287:             .Height    = 46
288:             .Left      = 10
289:             .Top       = 17
290:             .Width     = THIS.Width - 21
291:             .ForeColor = RGB(255, 255, 255)
292:             .Visible   = .T.
293:         ENDWITH
294:     ENDPROC

*-- Linhas 300 a 323:
300:     PROTECTED PROCEDURE ConfigurarGrupos()
301:         THIS.AddObject("shp_4c_Shape2", "Shape")
302:         WITH THIS.shp_4c_Shape2
303:             .Top         = 4
304:             .Left        = 321
305:             .Height      = 110
306:             .Width       = 173
307:             .BackStyle   = 0
308:             .BorderStyle = 0
309:             .FillStyle   = 1
310:             .BackColor   = RGB(192, 192, 192)
311:             .BorderColor = RGB(136, 189, 188)
312:             .Visible     = .T.
313:         ENDWITH
314: 
315:         THIS.AddObject("shp_4c_Shape1", "Shape")
316:         WITH THIS.shp_4c_Shape1
317:             .Top         = 100
318:             .Left        = 102
319:             .Height      = 133
320:             .Width       = 295
321:             .BackStyle   = 0
322:             .BorderStyle = 6
323:             .FillStyle   = 1

*-- Linhas 350 a 423:
350:     * recebe InputMask aqui.
351:     *
352:     * .Value reproduz o tipo que o Init do legado atribui a cada campo
353:     * (ThisForm.Get*.Value = ...) e o memvar do ControlSource:
354:     *   _ProcBco = Space(03) / _ProcAge = Space(04) / _ProcCon = Space(10)
355:     *   _ProcChe = Space(06) / _ProcVen = { / / }  (DATE)
356:     * MaxLength vem do tamanho desses mesmos memvares - nao ha coluna de
357:     * banco associada a estes campos de criterio de busca.
358:     *==================================================================
359:     PROTECTED PROCEDURE ConfigurarCamposBusca1()
360: 
361:         *-- Banco (Say "Banco :" + GetBanco, TabIndex 1/2 do legado)
362:         THIS.AddObject("lbl_4c_Banco", "Label")
363:         WITH THIS.lbl_4c_Banco
364:             .Top       = 110
365:             .Left      = 127
366:             .Width     = 38
367:             .Height    = 15
368:             .Alignment = 0
369:             .BackStyle = 0
370:             .AutoSize  = .F.
371:             .FontName  = "Tahoma"
372:             .FontSize  = 8
373:             .ForeColor = RGB(90, 90, 90)
374:             .Caption   = "Banco :"
375:             .TabIndex  = 1
376:             .Visible   = .T.
377:         ENDWITH
378: 
379:         THIS.AddObject("txt_4c_Banco", "TextBoxBuscaCheque")
380:         WITH THIS.txt_4c_Banco
381:             .Top           = 107
382:             .Left          = 167
383:             .Width         = 31
384:             .Height        = 23
385:             .Value         = ""
386:             .InputMask     = "999"
387:             .MaxLength     = 3
388:             .FontName      = "Tahoma"
389:             .FontSize      = 8
390:             .ForeColor     = RGB(0, 0, 0)
391:             .TabIndex      = 2
392:             .ControlSource  = "ThisForm.this_cProcBco"
393:             .this_cGrupoWhen = "BANCO"
394:             .Visible       = .T.
395:         ENDWITH
396: 
397:         *-- Agencia (Say "Agencia :" + GetAgencia, TabIndex 3/4 do legado)
398:         THIS.AddObject("lbl_4c_Agencia", "Label")
399:         WITH THIS.lbl_4c_Agencia
400:             .Top       = 134
401:             .Left      = 118
402:             .Width     = 47
403:             .Height    = 15
404:             .Alignment = 0
405:             .BackStyle = 0
406:             .AutoSize  = .F.
407:             .FontName  = "Tahoma"
408:             .FontSize  = 8
409:             .ForeColor = RGB(90, 90, 90)
410:             .Caption   = "Ag" + CHR(234) + "ncia :"
411:             .TabIndex  = 3
412:             .Visible   = .T.
413:         ENDWITH
414: 
415:         THIS.AddObject("txt_4c_Agencia", "TextBoxBuscaCheque")
416:         WITH THIS.txt_4c_Agencia
417:             .Top           = 131
418:             .Left          = 167
419:             .Width         = 40
420:             .Height        = 23
421:             .Value         = ""
422:             .InputMask     = "9999"
423:             .MaxLength     = 4

*-- Linhas 431 a 536:
431:         ENDWITH
432: 
433:         *-- Conta (Say "Conta :" + GetConta, TabIndex 5/6 do legado)
434:         THIS.AddObject("lbl_4c_Conta", "Label")
435:         WITH THIS.lbl_4c_Conta
436:             .Top       = 158
437:             .Left      = 127
438:             .Width     = 38
439:             .Height    = 15
440:             .Alignment = 0
441:             .BackStyle = 0
442:             .AutoSize  = .F.
443:             .FontName  = "Tahoma"
444:             .FontSize  = 8
445:             .ForeColor = RGB(90, 90, 90)
446:             .Caption   = "Conta :"
447:             .TabIndex  = 5
448:             .Visible   = .T.
449:         ENDWITH
450: 
451:         THIS.AddObject("txt_4c_Conta", "TextBoxBuscaCheque")
452:         WITH THIS.txt_4c_Conta
453:             .Top           = 155
454:             .Left          = 167
455:             .Width         = 81
456:             .Height        = 23
457:             .Value         = ""
458:             .InputMask     = "9999999999"
459:             .MaxLength     = 10
460:             .FontName      = "Tahoma"
461:             .FontSize      = 8
462:             .ForeColor     = RGB(0, 0, 0)
463:             .TabIndex      = 6
464:             .ControlSource  = "ThisForm.this_cProcCon"
465:             .this_cGrupoWhen = "CONTA"
466:             .Visible       = .T.
467:         ENDWITH
468: 
469:         *-- Cheque (Say "Cheque :" + GetCheque, TabIndex 7/8 do legado)
470:         THIS.AddObject("lbl_4c_Cheque", "Label")
471:         WITH THIS.lbl_4c_Cheque
472:             .Top       = 182
473:             .Left      = 119
474:             .Width     = 46
475:             .Height    = 15
476:             .Alignment = 0
477:             .BackStyle = 0
478:             .AutoSize  = .F.
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .ForeColor = RGB(90, 90, 90)
482:             .Caption   = "Cheque :"
483:             .TabIndex  = 7
484:             .Visible   = .T.
485:         ENDWITH
486: 
487:         THIS.AddObject("txt_4c_Cheque", "TextBoxBuscaCheque")
488:         WITH THIS.txt_4c_Cheque
489:             .Top           = 179
490:             .Left          = 167
491:             .Width         = 52
492:             .Height        = 23
493:             .Value         = ""
494:             .InputMask     = "999999"
495:             .MaxLength     = 6
496:             .FontName      = "Tahoma"
497:             .FontSize      = 8
498:             .ForeColor     = RGB(0, 0, 0)
499:             .TabIndex      = 8
500:             .ControlSource  = "ThisForm.this_cProcChe"
501:             .this_cGrupoWhen = "CHEQUE"
502:             .Visible       = .T.
503:         ENDWITH
504: 
505:         *-- Vencimento (Say3 "Vencimento :" + GetVencimento, TabIndex 9/10
506:         *-- do legado). Campo DATE: o Init do legado faz
507:         *-- ThisForm.GetVencimento.Value = { / / } e o memvar do
508:         *-- ControlSource e' _ProcVen = { / / }. Sem InputMask (o dump
509:         *-- declara InputMask = "", override vazio) e sem MaxLength
510:         *-- (nao se aplica a campo de data).
511:         THIS.AddObject("lbl_4c_Label3", "Label")
512:         WITH THIS.lbl_4c_Label3
513:             .Top       = 110
514:             .Left      = 243
515:             .Width     = 64
516:             .Height    = 15
517:             .Alignment = 0
518:             .BackStyle = 0
519:             .AutoSize  = .F.
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .ForeColor = RGB(90, 90, 90)
523:             .Caption   = "Vencimento :"
524:             .TabIndex  = 9
525:             .Visible   = .T.
526:         ENDWITH
527: 
528:         THIS.AddObject("txt_4c_Vencimento", "TextBoxBuscaCheque")
529:         WITH THIS.txt_4c_Vencimento
530:             .Top           = 107
531:             .Left          = 309
532:             .Width         = 81
533:             .Height        = 23
534:             .Value         = {}
535:             .FontName      = "Tahoma"
536:             .FontSize      = 8

*-- Linhas 550 a 587:
550:     * exatamente como no dump - Left=309 continua a coluna da direita).
551:     *
552:     * .Value reproduz o estado final que o Init do legado deixa em cada
553:     * campo (a ultima atribuicao ThisForm.Get*.Value = ... sobrescreve o
554:     * Store nos memvars _Proc*): GetValor.Value=0, GetControle.Value=''
555:     * (char sem MaxLength no dump), GetProtocolo.Value='' (idem),
556:     * GetArquivo.Value=Space(6) com MaxLength=6 (unico desta leva com
557:     * MaxLength/InputMask declarados no dump).
558:     *==================================================================
559:     PROTECTED PROCEDURE ConfigurarCamposBusca2()
560: 
561:         *-- Valor (Say4 "Valor :" + GetValor, TabIndex 11/12 do legado)
562:         THIS.AddObject("lbl_4c_Label4", "Label")
563:         WITH THIS.lbl_4c_Label4
564:             .Top       = 134
565:             .Left      = 274
566:             .Width     = 33
567:             .Height    = 15
568:             .Alignment = 0
569:             .BackStyle = 0
570:             .AutoSize  = .F.
571:             .FontName  = "Tahoma"
572:             .FontSize  = 8
573:             .ForeColor = RGB(90, 90, 90)
574:             .Caption   = "Valor :"
575:             .TabIndex  = 11
576:             .Visible   = .T.
577:         ENDWITH
578: 
579:         THIS.AddObject("txt_4c_Valor", "TextBoxBuscaCheque")
580:         WITH THIS.txt_4c_Valor
581:             .Top           = 131
582:             .Left          = 309
583:             .Width         = 81
584:             .Height        = 23
585:             .Value         = 0
586:             .InputMask     = "999,999.99"
587:             .FontName      = "Tahoma"

*-- Linhas 594 a 622:
594:         ENDWITH
595: 
596:         *-- Controle (Say1 "Controle :" + GetControle, TabIndex 13/14)
597:         THIS.AddObject("lbl_4c_Label1", "Label")
598:         WITH THIS.lbl_4c_Label1
599:             .Top       = 158
600:             .Left      = 257
601:             .Width     = 50
602:             .Height    = 15
603:             .Alignment = 0
604:             .BackStyle = 0
605:             .AutoSize  = .F.
606:             .FontName  = "Tahoma"
607:             .FontSize  = 8
608:             .ForeColor = RGB(90, 90, 90)
609:             .Caption   = "Controle :"
610:             .TabIndex  = 13
611:             .Visible   = .T.
612:         ENDWITH
613: 
614:         THIS.AddObject("txt_4c_Controle", "TextBoxBuscaCheque")
615:         WITH THIS.txt_4c_Controle
616:             .Top           = 155
617:             .Left          = 309
618:             .Width         = 66
619:             .Height        = 23
620:             .Value         = ""
621:             .FontName      = "Tahoma"
622:             .FontSize      = 8

*-- Linhas 628 a 656:
628:         ENDWITH
629: 
630:         *-- Protocolo (Say2 "Protocolo :" + GetProtocolo, TabIndex 15/16)
631:         THIS.AddObject("lbl_4c_Label2", "Label")
632:         WITH THIS.lbl_4c_Label2
633:             .Top       = 182
634:             .Left      = 253
635:             .Width     = 54
636:             .Height    = 15
637:             .Alignment = 0
638:             .BackStyle = 0
639:             .AutoSize  = .F.
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8
642:             .ForeColor = RGB(90, 90, 90)
643:             .Caption   = "Protocolo :"
644:             .TabIndex  = 15
645:             .Visible   = .T.
646:         ENDWITH
647: 
648:         THIS.AddObject("txt_4c_Protocolo", "TextBoxBuscaCheque")
649:         WITH THIS.txt_4c_Protocolo
650:             .Top           = 179
651:             .Left          = 309
652:             .Width         = 67
653:             .Height        = 23
654:             .Value         = ""
655:             .FontName      = "Tahoma"
656:             .FontSize      = 8

*-- Linhas 662 a 690:
662:         ENDWITH
663: 
664:         *-- Arquivo (Say5 "Arquivo :" + GetArquivo, TabIndex 17/18)
665:         THIS.AddObject("lbl_4c_Label5", "Label")
666:         WITH THIS.lbl_4c_Label5
667:             .Top       = 208
668:             .Left      = 261
669:             .Width     = 46
670:             .Height    = 15
671:             .Alignment = 0
672:             .BackStyle = 0
673:             .AutoSize  = .F.
674:             .FontName  = "Tahoma"
675:             .FontSize  = 8
676:             .ForeColor = RGB(90, 90, 90)
677:             .Caption   = "Arquivo :"
678:             .TabIndex  = 17
679:             .Visible   = .T.
680:         ENDWITH
681: 
682:         THIS.AddObject("txt_4c_Arquivo", "TextBoxBuscaCheque")
683:         WITH THIS.txt_4c_Arquivo
684:             .Top           = 203
685:             .Left          = 309
686:             .Width         = 52
687:             .Height        = 23
688:             .Value         = SPACE(6)
689:             .InputMask     = "999999"
690:             .MaxLength     = 6

*-- Linhas 814 a 837:
814:                 "o foi poss" + CHR(237) + "vel ler os crit" + CHR(233) + "rios da tela.", ;
815:                 "FormSigOpChb.FormParaBO")
816:         ELSE
817:             loc_oBO = THIS.this_oBusinessObject
818: 
819:             loc_oBO.this_cBanco      = THIS.txt_4c_Banco.Value
820:             loc_oBO.this_cAgencia    = THIS.txt_4c_Agencia.Value
821:             loc_oBO.this_cConta      = THIS.txt_4c_Conta.Value
822:             loc_oBO.this_cCheque     = THIS.txt_4c_Cheque.Value
823:             loc_oBO.this_dVencimento = ConverterParaData(THIS.txt_4c_Vencimento.Value)
824:             loc_oBO.this_nValor      = IIF(VARTYPE(THIS.txt_4c_Valor.Value) = "N", ;
825:                                            THIS.txt_4c_Valor.Value, ;
826:                                            VAL(TRANSFORM(THIS.txt_4c_Valor.Value)))
827:             loc_oBO.this_cControle   = THIS.txt_4c_Controle.Value
828:             loc_oBO.this_cProtocolo  = THIS.txt_4c_Protocolo.Value
829:             loc_oBO.this_cArquivo    = THIS.txt_4c_Arquivo.Value
830: 
831:             loc_lSucesso = .T.
832:         ENDIF
833: 
834:         RETURN loc_lSucesso
835:     ENDFUNC
836: 
837:     *==================================================================

*-- Linhas 855 a 878:
855:                 "o foi poss" + CHR(237) + "vel exibir os crit" + CHR(233) + "rios na tela.", ;
856:                 "FormSigOpChb.BOParaForm")
857:         ELSE
858:             loc_oBO = THIS.this_oBusinessObject
859: 
860:             THIS.txt_4c_Banco.Value      = loc_oBO.this_cBanco
861:             THIS.txt_4c_Agencia.Value    = loc_oBO.this_cAgencia
862:             THIS.txt_4c_Conta.Value      = loc_oBO.this_cConta
863:             THIS.txt_4c_Cheque.Value     = loc_oBO.this_cCheque
864:             THIS.txt_4c_Vencimento.Value = ConverterParaData(loc_oBO.this_dVencimento)
865:             THIS.txt_4c_Valor.Value      = IIF(VARTYPE(loc_oBO.this_nValor) = "N", ;
866:                                                loc_oBO.this_nValor, 0)
867:             THIS.txt_4c_Controle.Value   = loc_oBO.this_cControle
868:             THIS.txt_4c_Protocolo.Value  = loc_oBO.this_cProtocolo
869:             THIS.txt_4c_Arquivo.Value    = loc_oBO.this_cArquivo
870: 
871:             loc_lSucesso = .T.
872:         ENDIF
873: 
874:         RETURN loc_lSucesso
875:     ENDFUNC
876: 
877:     *==================================================================
878:     * ConfigurarEventosBusca - BINDEVENTs dos criterios de busca.

*-- Linhas 887 a 922:
887:     * GetArquivo.Valid (Trans(Val(...))) e reformatacao pura de texto -
888:     * sem SQL/CarregarDados, por isso pode ir em "LostFocus" sem risco de
889:     * recursao (regra do projeto so veda LostFocus para metodos pesados).
890:     *==================================================================
891:     PROTECTED PROCEDURE ConfigurarEventosBusca()
892:         BINDEVENT(THIS.txt_4c_Banco, "KeyPress", THIS, "BancoKeyPress")
893:         BINDEVENT(THIS.txt_4c_Arquivo, "LostFocus", THIS, "ValidarArquivo")
894:     ENDPROC
895: 
896:     *==================================================================
897:     * ConfigurarBotoesAcao - Botoes reais do dialogo (Procura/Cancela),
898:     * geometria/Picture/Cancel transcritos do dump:
899:     *   Procura    - Top=3, Left=350, Picture=cadastro_procurar_60.jpg
900:     *   btnCancela - Top=3, Left=425, Picture=cadastro_cancelar_60.jpg,
901:     *                Cancel=.T.
902:     * O SCX legado NAO declara Width/Height (herdados da classe fwbtng) -
903:     * usado o canonico 75x75 dos botoes standalone do framework novo
904:     * (mesmo padrao de FormSigOpBcb.ConfigurarBotoes: Themes=.T. +
905:     * DisabledPicture repetindo o Picture, exigido em standalone
906:     * CommandButton com icone - regra do projeto). 350+75=425 e 425+75=500
907:     * fecham exatamente na largura do form (Width=500), sem sobra.
908:     *==================================================================
909:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
910:         THIS.AddObject("cmd_4c_Procura", "CommandButton")
911:         WITH THIS.cmd_4c_Procura
912:             .Top             = 3
913:             .Left            = 350
914:             .Width           = 75
915:             .Height          = 75
916:             .TabIndex        = 19
917:             .Caption         = "Procurar"
918:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
919:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
920:             .FontName        = "Tahoma"
921:             .FontBold        = .T.
922:             .FontItalic      = .T.

*-- Linhas 931 a 947:
931:             .Visible         = .T.
932:         ENDWITH
933: 
934:         THIS.AddObject("cmd_4c_BtnCancela", "CommandButton")
935:         WITH THIS.cmd_4c_BtnCancela
936:             .Top             = 3
937:             .Left            = 425
938:             .Width           = 75
939:             .Height          = 75
940:             .TabIndex        = 20
941:             .Cancel          = .T.
942:             .Caption         = "Cancelar"
943:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
944:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
945:             .FontName        = "Tahoma"
946:             .FontBold        = .T.
947:             .FontItalic      = .T.

*-- Linhas 960 a 969:
960:         *-- do bind - a classe inteira (incluindo CmdProcuraClick/
961:         *-- BtnCancelarClick, declarados mais abaixo neste arquivo) ja
962:         *-- esta compilada quando InicializarForm roda.
963:         BINDEVENT(THIS.cmd_4c_Procura,    "Click", THIS, "CmdProcuraClick")
964:         BINDEVENT(THIS.cmd_4c_BtnCancela, "Click", THIS, "BtnCancelarClick")
965:     ENDPROC
966: 
967:     *==================================================================
968:     * CmdProcuraClick - Transcricao do Procura.Click legado, que faz
969:     * exatamente duas coisas: busca e fecha. A busca inteira (ordem de

*-- Linhas 1145 a 1166:
1145:         *-- leem o .Value dos OUTROS campos. Enquanto ConfigurarCamposBusca1/2
1146:         *-- ainda nao terminaram, parte deles nao existe - e erro dentro de
1147:         *-- When() derruba o Init do form. Sem os nove controles, nao ha
1148:         *-- exclusao mutua a aplicar: libera o foco (comportamento do legado,
1149:         *-- cujo form ja nasce com todos os Get* instanciados pelo SCX).
1150:         IF !(PEMSTATUS(THIS, "txt_4c_Banco", 5)      AND PEMSTATUS(THIS, "txt_4c_Agencia", 5) AND ;
1151:              PEMSTATUS(THIS, "txt_4c_Conta", 5)      AND PEMSTATUS(THIS, "txt_4c_Cheque", 5) AND ;
1152:              PEMSTATUS(THIS, "txt_4c_Vencimento", 5) AND PEMSTATUS(THIS, "txt_4c_Valor", 5) AND ;
1153:              PEMSTATUS(THIS, "txt_4c_Controle", 5)   AND PEMSTATUS(THIS, "txt_4c_Protocolo", 5) AND ;
1154:              PEMSTATUS(THIS, "txt_4c_Arquivo", 5))
1155:             RETURN .T.
1156:         ENDIF
1157: 
1158:         DO CASE
1159:         CASE par_cCampo = "BANCO"
1160:             loc_lPermite = EMPTY(THIS.txt_4c_Controle.Value) AND ;
1161:                            EMPTY(THIS.txt_4c_Protocolo.Value)
1162: 
1163:         CASE INLIST(par_cCampo, "AGENCIA", "CONTA", "CHEQUE")
1164:             loc_lPermite = EMPTY(THIS.txt_4c_Controle.Value) AND ;
1165:                            EMPTY(THIS.txt_4c_Protocolo.Value) AND ;
1166:                            EMPTY(THIS.txt_4c_Arquivo.Value)

*-- Linhas 1176 a 1219:
1176:                            EMPTY(THIS.txt_4c_Controle.Value) AND ;
1177:                            EMPTY(THIS.txt_4c_Protocolo.Value) AND ;
1178:                            EMPTY(THIS.txt_4c_Arquivo.Value)
1179: 
1180:         CASE par_cCampo = "CONTROLE"
1181:             loc_lPermite = EMPTY(THIS.txt_4c_Banco.Value) AND ;
1182:                            EMPTY(THIS.txt_4c_Agencia.Value) AND ;
1183:                            EMPTY(THIS.txt_4c_Conta.Value) AND ;
1184:                            EMPTY(THIS.txt_4c_Cheque.Value) AND ;
1185:                            EMPTY(THIS.txt_4c_Vencimento.Value) AND ;
1186:                            EMPTY(THIS.txt_4c_Valor.Value) AND ;
1187:                            EMPTY(THIS.txt_4c_Protocolo.Value) AND ;
1188:                            EMPTY(THIS.txt_4c_Arquivo.Value)
1189: 
1190:         CASE par_cCampo = "PROTOCOLO"
1191:             loc_lPermite = EMPTY(THIS.txt_4c_Banco.Value) AND ;
1192:                            EMPTY(THIS.txt_4c_Agencia.Value) AND ;
1193:                            EMPTY(THIS.txt_4c_Conta.Value) AND ;
1194:                            EMPTY(THIS.txt_4c_Cheque.Value) AND ;
1195:                            EMPTY(THIS.txt_4c_Vencimento.Value) AND ;
1196:                            EMPTY(THIS.txt_4c_Valor.Value) AND ;
1197:                            EMPTY(THIS.txt_4c_Controle.Value) AND ;
1198:                            EMPTY(THIS.txt_4c_Arquivo.Value)
1199: 
1200:         CASE par_cCampo = "ARQUIVO"
1201:             loc_lPermite = EMPTY(THIS.txt_4c_Banco.Value) AND ;
1202:                            EMPTY(THIS.txt_4c_Agencia.Value) AND ;
1203:                            EMPTY(THIS.txt_4c_Conta.Value) AND ;
1204:                            EMPTY(THIS.txt_4c_Cheque.Value) AND ;
1205:                            EMPTY(THIS.txt_4c_Vencimento.Value) AND ;
1206:                            EMPTY(THIS.txt_4c_Valor.Value) AND ;
1207:                            EMPTY(THIS.txt_4c_Controle.Value) AND ;
1208:                            EMPTY(THIS.txt_4c_Arquivo.Value)
1209:         ENDCASE
1210: 
1211:         RETURN loc_lPermite
1212:     ENDFUNC
1213: 
1214:     *==================================================================
1215:     * BancoKeyPress - Transcricao literal do GetBanco.KeyPress legado:
1216:     * captura caracteres do leitor de codigo de barras (inicia em
1217:     * nKeyCode=60, decodifica em nKeyCode=58 chamando ValidarBancoLeitura
1218:     * no lugar de This.Valid - BINDEVENT "Valid" nao e confiavel em
1219:     * TextBox). Precisa ser PUBLIC (chamado via BINDEVENT - regra #3).


### BO (C:\4c\projeto\app\classes\SigOpChbBO.prg):
*====================================================================
* SigOpChbBO.prg
*
* Business Object para o dialogo "Procurar Cheque" (SIGOPCHB)
* Tabela pesquisada: SigChe (busca por Vencimento/Banco/Agencia/
* Conta/Cheque/Controle/Protocolo/Arquivo - PK: nums)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpChbBO AS BusinessBase

    *-- Propriedades de criterio de busca (mapeamento para tabela SigChe)
    this_cBanco       = ""    && bancos    char(3)  - criterio Banco
    this_cAgencia     = ""    && agencias  char(4)  - criterio Agencia
    this_cConta       = ""    && ncontas   char(10) - criterio Conta (legado usa nContas no WHERE, nao contas)
    this_cCheque      = ""    && ncheques  char(6)  - criterio N. Cheque
    this_dVencimento  = {}    && vencs     datetime - criterio Vencimento
    this_nValor       = 0     && valors    numeric(11,2) - criterio Valor
    this_cControle    = ""    && nums      char(8)  - criterio Controle (chave unica)
    this_cProtocolo   = ""    && protocolos char(8) - criterio Protocolo (via SigCqChm)
    this_cArquivo     = ""    && numeros   char(6)  - criterio Arquivo (numero sequencial de leitura)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChe"
            THIS.this_cCampoChave = "nums"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpChbBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega os criterios de busca a partir de um
    * registro de SigChe (usado ao reabrir o dialogo com um cheque ja
    * localizado, para repopular os campos de pesquisa)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cBanco      = TratarNulo(bancos, "")
        THIS.this_cAgencia    = TratarNulo(agencias, "")
        THIS.this_cConta      = TratarNulo(ncontas, "")
        THIS.this_cCheque     = TratarNulo(ncheques, "")
        THIS.this_dVencimento = ConverterParaData(vencs)
        THIS.this_nValor      = TratarNulo(valors, 0)
        THIS.this_cControle   = TratarNulo(nums, "")
        THIS.this_cProtocolo  = TratarNulo(protocolos, "")
        THIS.this_cArquivo    = TratarNulo(numeros, "")

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna o valor da chave primaria (nums)
    * para uso em RegistrarAuditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cControle
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao - NAO sobrescritos de proposito.
    *
    * O dialogo legado SIGOPCHB (Procura.Click) so executa SEEK no cursor
    * local crSigChe e, na falha, um SELECT via SqlExecute cujo resultado
    * eh copiado (Insert Into CrSigChe From Array Memvar) para o CURSOR
    * local do form pai - nunca ha INSERT/UPDATE/DELETE contra a tabela
    * SigChe no legado. O comportamento padrao herdado de BusinessBase
    * (recusar a operacao) ja eh o correto para este BO somente-leitura.
    *====================================================================

    *====================================================================
    * BuscarCheque - Transcricao da logica de busca do Procura.Click do
    * legado (SIGOPCHB.Procura.Click): monta o WHERE pela PRIMEIRA
    * condicao preenchida, na MESMA ordem de prioridade do Do Case legado
    * (Vencimento > Valor > Banco > Agencia > Conta > Cheque > Controle >
    * Protocolo > Arquivo), e devolve em par_cCursorDestino as linhas de
    * SigChe que casam (equivalente ao "Select * From SigChe Where
    * <lcWher>" seguido do Scan/Insert Into CrSigChe do legado - aqui o
    * Scatter/Insert fica a cargo do form, que mescla o resultado em
    * cursor_4c_SigChe).
    *
    * O legado faz Seek LOCAL em crSigChe antes de ir ao banco (evita
    * reconsultar o que ja estava no cursor do form pai). Esta migracao
    * nao reproduz esse Seek: o form nao tem como compartilhar o cursor
    * do chamador por nome (THIS dialogo fecha com Hide(), nao Release() -
    * ver FormSigOpChb.FecharDialogo - e devolve o resultado so pelo
    * cursor_4c_SigChe que ele mesmo mantem). O form, ao mesclar o
    * resultado desta busca em cursor_4c_SigChe, descarta duplicata pela
    * PK (Nums) - o estado final (quais cheques entram na lista) eh o
    * mesmo; muda so que uma nova busca pode reconsultar o banco por um
    * cheque ja encontrado antes, dentro do MESMO dialogo aberto.
    *
    * Retorna o numero de linhas encontradas (>=0) ou -1 em erro SQL. Se
    * TODOS os criterios estiverem vazios, retorna 0 sem consultar o
    * banco (fiel ao Do Case sem Case casado do legado, que nao executa
    * SqlExecute nenhum).
    *====================================================================
    PROCEDURE BuscarCheque(par_cBanco, par_cAgencia, par_cConta, par_cCheque, ;
            par_dVencimento, par_nValor, par_cControle, par_cProtocolo, ;
            par_cArquivo, par_cCursorDestino)
        LOCAL loc_cWhere, loc_nResultado, loc_cNumsProtocolo

        loc_cWhere     = ""
        loc_nResultado = 0

        DO CASE
        CASE !EMPTY(par_dVencimento)
            loc_cWhere = "Vencs = " + FormatarDataSQL(par_dVencimento)
            IF !EMPTY(par_cBanco)
                loc_cWhere = loc_cWhere + " AND Bancos = " + EscaparSQL(par_cBanco)
            ENDIF
            IF !EMPTY(par_cAgencia)
                loc_cWhere = loc_cWhere + " AND Agencias = " + EscaparSQL(par_cAgencia)
            ENDIF
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_nValor)
            loc_cWhere = "Valors = " + FormatarNumeroSQL(par_nValor, 2)
            IF !EMPTY(par_cBanco)
                loc_cWhere = loc_cWhere + " AND Bancos = " + EscaparSQL(par_cBanco)
            ENDIF
            IF !EMPTY(par_cAgencia)
                loc_cWhere = loc_cWhere + " AND Agencias = " + EscaparSQL(par_cAgencia)
            ENDIF
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cBanco)
            loc_cWhere = "Bancos = " + EscaparSQL(par_cBanco)
            IF !EMPTY(par_cAgencia)
                loc_cWhere = loc_cWhere + " AND Agencias = " + EscaparSQL(par_cAgencia)
            ENDIF
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cAgencia)
            loc_cWhere = "Agencias = " + EscaparSQL(par_cAgencia)
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cConta)
            loc_cWhere = "nContas = " + EscaparSQL(par_cConta)
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cCheque)
            loc_cWhere = "nCheques = " + EscaparSQL(par_cCheque)

        CASE !EMPTY(par_cControle)
            loc_cWhere = "Nums = " + EscaparSQL(par_cControle)

        CASE !EMPTY(par_cProtocolo)
            loc_cNumsProtocolo = THIS.BuscarNumsPorProtocolo(par_cProtocolo)
            IF !EMPTY(loc_cNumsProtocolo)
                loc_cWhere = "Nums = " + EscaparSQL(loc_cNumsProtocolo)
            ENDIF

        CASE !EMPTY(par_cArquivo)
            loc_cWhere = "Numeros = " + EscaparSQL(TRANSFORM(VAL(par_cArquivo), "@L 999999"))
        ENDCASE

        IF !EMPTY(loc_cWhere)
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigChe WHERE " + loc_cWhere, par_cCursorDestino)
            IF loc_nResultado < 0
                MsgErro(CapturarErroSQL(), "SigOpChbBO.BuscarCheque")
                RETURN -1
            ENDIF
        ENDIF

        RETURN loc_nResultado
    ENDPROC

    *====================================================================
    * BuscarNumsPorProtocolo - Transcricao do trecho do criterio Protocolo
    * no Procura.Click legado: ThisForm.Parentform.Podatamgr.CursorQuery(
    * 'SigCqChm','CrChm','Protocolos', Trans(Val(_ProcProtocolo),
    * '@L 99999999')) - localiza, em SigCqChm, o Nums do cheque associado
    * aquele protocolo formatado.
    *====================================================================
    PROTECTED PROCEDURE BuscarNumsPorProtocolo(par_cProtocolo)
        LOCAL loc_cProtocoloFmt, loc_nResultado, loc_cNums

        loc_cProtocoloFmt = TRANSFORM(VAL(par_cProtocolo), "@L 99999999")
        loc_cNums         = ""

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT Nums FROM SigCqChm WHERE Protocolos = " + EscaparSQL(loc_cProtocoloFmt), ;
            "cursor_4c_SigCqChmTmp")

        IF loc_nResultado > 0
            SELECT cursor_4c_SigCqChmTmp
            GO TOP
            loc_cNums = TratarNulo(Nums, "")
        ENDIF

        IF USED("cursor_4c_SigCqChmTmp")
            USE IN cursor_4c_SigCqChmTmp
        ENDIF

        RETURN loc_cNums
    ENDPROC

ENDDEFINE

