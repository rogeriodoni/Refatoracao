# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2145 linhas total):

*-- Linhas 116 a 124:
116:         LPARAMETERS par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
117:                     par_cDebCred, par_cTipPagto, par_nNumParcs, par_cIdent, par_cOpers
118: 
119:         THIS.Caption = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
120: 
121:         THIS.this_cEndSiTef = IIF(VARTYPE(par_cEndSiTef) = "C", par_cEndSiTef, "")
122:         THIS.this_nValPago  = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, 0)
123:         THIS.this_cCupom    = IIF(VARTYPE(par_cCupom) $ "NC", TRANSFORM(par_cCupom, "@L 999999"), "000000")
124:         THIS.this_cCaixa    = IIF(VARTYPE(par_cCaixa) = "C", par_cCaixa, "")

*-- Linhas 236 a 332:
236:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
237:         loc_oCab = THIS.cnt_4c_Cabecalho
238:         WITH loc_oCab
239:             .Top         = 0
240:             .Left        = 0
241:             .Width       = THIS.Width
242:             .Height      = 80
243:             .BackColor   = RGB(100,100,100)
244:             .BackStyle   = 1
245:             .BorderWidth = 0
246:         ENDWITH
247: 
248:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
249:         WITH loc_oCab.lbl_4c_Sombra
250:             .AutoSize      = .F.
251:             .Width         = loc_oCab.Width - 10
252:             .Height        = 40
253:             .Top           = 18
254:             .Left          = 10
255:             .FontName      = "Tahoma"
256:             .FontSize      = 18
257:             .FontBold      = .T.
258:             .FontUnderline = .F.
259:             .Alignment     = 0
260:             .BackStyle     = 0
261:             .WordWrap      = .T.
262:             .ForeColor     = RGB(0,0,0)
263:             .Caption       = THIS.Caption
264:         ENDWITH
265: 
266:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
267:         WITH loc_oCab.lbl_4c_Titulo
268:             .AutoSize      = .F.
269:             .Width         = loc_oCab.Width - 10
270:             .Height        = 46
271:             .Top           = 17
272:             .Left          = 10
273:             .FontName      = "Tahoma"
274:             .FontSize      = 18
275:             .FontBold      = .T.
276:             .Alignment     = 0
277:             .BackStyle     = 0
278:             .WordWrap      = .T.
279:             .ForeColor     = RGB(255,255,255)
280:             .Caption       = THIS.Caption
281:             *-- SCX legado: lblTitulo.ToolTipText = "Titulo do Relatorio"
282:             .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
283:         ENDWITH
284:     ENDPROC
285: 
286:     *--------------------------------------------------------------------------
287:     * ConfigurarCampos - cria os campos de captura direto no Form (sem
288:     * PageFrame - controles filhos de THIS, Top/Left transcritos EXATOS do
289:     * SCX legado, SEM compensacao +29 porque nao ha PageFrame.Top=-29 aqui).
290:     * Migrado de: SIGPRDFT.Shape2/Label5/GetValor/Label2/GetDigitos/Label8/
291:     * Container1(.Label1)/GetCartao/Label11/Label4/Optiongroup1/Label6/
292:     * Text1/GetDatas
293:     *--------------------------------------------------------------------------
294:     PROTECTED PROCEDURE ConfigurarCampos()
295:         LOCAL loc_oCnt
296: 
297:         *-- Shape2 - moldura decorativa ao redor dos campos
298:         THIS.AddObject("shp_4c_Shape2", "Shape")
299:         WITH THIS.shp_4c_Shape2
300:             .Top           = 93
301:             .Left          = 17
302:             .Width         = 466
303:             .Height        = 202
304:             .SpecialEffect = 0
305:         ENDWITH
306: 
307:         *-- Label5 "VALOR :" + txt_4c_Valor (GetValor)
308:         THIS.AddObject("lbl_4c_Label5", "Label")
309:         WITH THIS.lbl_4c_Label5
310:             .AutoSize  = .F.
311:             .Alignment = 0
312:             .Top       = 102
313:             .Left      = 175
314:             .Width     = 45
315:             .Height    = 15
316:             .FontName  = "Tahoma"
317:             .FontSize  = 8
318:             .FontBold  = .T.
319:             .ForeColor = RGB(90,90,90)
320:             .BackStyle = 0
321:             .Caption   = "VALOR :"
322:         ENDWITH
323: 
324:         THIS.AddObject("txt_4c_Valor", "TextBox")
325:         WITH THIS.txt_4c_Valor
326:             .Top               = 99
327:             .Left              = 222
328:             .Width             = 100
329:             .Height            = 23
330:             .Alignment         = 3
331:             .Value             = 0
332:             .InputMask         = "99,999,999.99"

*-- Linhas 339 a 366:
339:         ENDWITH
340: 
341:         *-- Label2 "4 ULTIMOS DIGITOS :" + txt_4c_Digitos (GetDigitos)
342:         THIS.AddObject("lbl_4c_Label2", "Label")
343:         WITH THIS.lbl_4c_Label2
344:             .AutoSize  = .F.
345:             .Alignment = 0
346:             .Top       = 171
347:             .Left      = 101
348:             .Width     = 119
349:             .Height    = 17
350:             .FontName  = "Tahoma"
351:             .FontSize  = 8
352:             .FontBold  = .T.
353:             .ForeColor = RGB(90,90,90)
354:             .BackStyle = 0
355:             .Caption   = "4 ULTIMOS DIGITOS :"
356:         ENDWITH
357: 
358:         THIS.AddObject("txt_4c_Digitos", "TextBox")
359:         WITH THIS.txt_4c_Digitos
360:             .Top       = 168
361:             .Left      = 222
362:             .Width     = 40
363:             .Height    = 23
364:             .Value     = ""
365:             .InputMask = "9999"
366:             .Enabled   = .T.

*-- Linhas 372 a 399:
372:         ENDWITH
373: 
374:         *-- Label8 "NUMERO CARTAO :" + txt_4c_Cartao (GetCartao)
375:         THIS.AddObject("lbl_4c_Label8", "Label")
376:         WITH THIS.lbl_4c_Label8
377:             .AutoSize  = .F.
378:             .Alignment = 0
379:             .Top       = 136
380:             .Left      = 116
381:             .Width     = 104
382:             .Height    = 15
383:             .FontName  = "Tahoma"
384:             .FontSize  = 8
385:             .FontBold  = .T.
386:             .ForeColor = RGB(90,90,90)
387:             .BackStyle = 0
388:             .Caption   = "NUMERO CARTAO :"
389:         ENDWITH
390: 
391:         THIS.AddObject("txt_4c_Cartao", "TextBox")
392:         WITH THIS.txt_4c_Cartao
393:             .Top               = 133
394:             .Left              = 222
395:             .Width             = 160
396:             .Height            = 23
397:             .Alignment         = 3
398:             .Value             = ""
399:             .InputMask         = "9999999999999999999"

*-- Linhas 410 a 461:
410:         THIS.AddObject("cnt_4c_Container1", "Container")
411:         loc_oCnt = THIS.cnt_4c_Container1
412:         WITH loc_oCnt
413:             .Top           = 298
414:             .Left          = 54
415:             .Width         = 392
416:             .Height        = 58
417:             .SpecialEffect = 0
418:         ENDWITH
419: 
420:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
421:         WITH loc_oCnt.lbl_4c_Label1
422:             .AutoSize  = .F.
423:             .Alignment = 2
424:             .Top       = 14
425:             .Left      = 18
426:             .Width     = 349
427:             .Height    = 29
428:             .FontName  = "Tahoma"
429:             .FontSize  = 18
430:             .FontBold  = .T.
431:             .ForeColor = RGB(90,90,90)
432:             .BackStyle = 0
433:             .Caption   = "Insira ou Passe o Cartao"
434:         ENDWITH
435: 
436:         *-- Label11 "1a PARCELA/VENCTO :" + txt_4c_Datas (GetDatas)
437:         THIS.AddObject("lbl_4c_Label11", "Label")
438:         WITH THIS.lbl_4c_Label11
439:             .AutoSize  = .F.
440:             .Alignment = 0
441:             .Top       = 268
442:             .Left      = 98
443:             .Width     = 122
444:             .Height    = 15
445:             .FontName  = "Tahoma"
446:             .FontSize  = 8
447:             .FontBold  = .T.
448:             .ForeColor = RGB(90,90,90)
449:             .BackStyle = 0
450:             .Caption   = "1" + CHR(170) + " PARCELA/VENCTO :"
451:         ENDWITH
452: 
453:         THIS.AddObject("txt_4c_Datas", "TextBox")
454:         WITH THIS.txt_4c_Datas
455:             .Top               = 266
456:             .Left              = 222
457:             .Width             = 75
458:             .Height            = 23
459:             .Alignment         = 3
460:             .Value             = {}
461:             .Enabled           = .F.

*-- Linhas 467 a 548:
467:         ENDWITH
468: 
469:         *-- Label4 "TIPO DE VENDA :" + obj_4c_Optiongroup1
470:         THIS.AddObject("lbl_4c_Label4", "Label")
471:         WITH THIS.lbl_4c_Label4
472:             .AutoSize  = .F.
473:             .Alignment = 0
474:             .Top       = 204
475:             .Left      = 129
476:             .Width     = 91
477:             .Height    = 15
478:             .FontName  = "Tahoma"
479:             .FontSize  = 8
480:             .FontBold  = .T.
481:             .ForeColor = RGB(90,90,90)
482:             .BackStyle = 0
483:             .Caption   = "TIPO DE VENDA :"
484:         ENDWITH
485: 
486:         THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
487:         WITH THIS.obj_4c_Optiongroup1
488:             .ButtonCount = 2
489:             .Top         = 200
490:             .Left        = 222
491:             .Width       = 161
492:             .Height      = 26
493:             .Enabled     = .T.
494:             .Value       = 1
495: 
496:             WITH .Buttons(1)
497:                 .Caption   = " A vista"
498:                 .Top       = 4
499:                 .Left      = 5
500:                 .Width     = 61
501:                 .Height    = 17
502:                 .FontName  = "Tahoma"
503:                 .FontSize  = 8
504:                 .FontBold  = .T.
505:                 .ForeColor = RGB(90,90,90)
506:                 .BackStyle = 0
507:             ENDWITH
508: 
509:             WITH .Buttons(2)
510:                 .Caption   = " Predatado"
511:                 .Top       = 5
512:                 .Left      = 73
513:                 .Width     = 80
514:                 .Height    = 15
515:                 .FontName  = "Tahoma"
516:                 .FontSize  = 8
517:                 .FontBold  = .T.
518:                 .ForeColor = RGB(90,90,90)
519:                 .BackStyle = 0
520:             ENDWITH
521:         ENDWITH
522: 
523:         *-- Label6 "No PARCELAS :" + txt_4c_Text1 (Text1)
524:         THIS.AddObject("lbl_4c_Label6", "Label")
525:         WITH THIS.lbl_4c_Label6
526:             .AutoSize  = .F.
527:             .Alignment = 0
528:             .Top       = 238
529:             .Left      = 139
530:             .Width     = 81
531:             .Height    = 15
532:             .FontName  = "Tahoma"
533:             .FontSize  = 8
534:             .FontBold  = .T.
535:             .ForeColor = RGB(90,90,90)
536:             .BackStyle = 0
537:             .Caption   = "N" + CHR(186) + " PARCELAS :"
538:         ENDWITH
539: 
540:         THIS.AddObject("txt_4c_Text1", "TextBox")
541:         WITH THIS.txt_4c_Text1
542:             .Top               = 235
543:             .Left              = 222
544:             .Width             = 27
545:             .Height            = 23
546:             .Value             = ""
547:             .InputMask         = "99"
548:             .Enabled           = .F.

*-- Linhas 564 a 573:
564:         WITH THIS.obj_4c_SAIDA
565:             .ButtonCount = 1
566:             .AutoSize    = .T.
567:             .Top         = -2
568:             .Left        = 420
569:             .Width       = 85
570:             .Height      = 85
571:             .BorderStyle = 0
572:             *-- SCX legado: SAIDA.BackStyle = 0 (transparente). CommandGroup TEM
573:             *-- BackStyle - medido no VFP9, ao contrario do CommandButton, que

*-- Linhas 579 a 596:
579:             .Value       = 0
580: 
581:             WITH .Buttons(1)
582:                 .Top        = 5
583:                 .Left       = 5
584:                 .Width      = 75
585:                 .Height     = 75
586:                 .FontName   = "Comic Sans MS"
587:                 .FontSize   = 8
588:                 .FontBold   = .T.
589:                 .FontItalic = .T.
590:                 .Cancel     = .F.
591:                 .Caption    = "\<Cancelar"
592:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
593:                 .ForeColor  = RGB(90,90,90)
594:                 .BackColor  = RGB(255,255,255)
595:                 .Themes     = .F.
596:             ENDWITH

*-- Linhas 647 a 658:
647: 
648:         IF loc_oBO.this_lOpFpCartao
649:             THIS.txt_4c_Cartao.Enabled  = .T.
650:             THIS.lbl_4c_Label2.Caption  = "Validade Cartao :"
651:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
652:         ELSE
653:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
654:         ENDIF
655: 
656:         THIS.txt_4c_Text1.Value = TRANSFORM(THIS.this_nNumParcs, "@L 99")
657: 
658:         *-- Legado SIGPRDFT.Init: lnParcs=TRANSFORM(NumParcs,"@L 99") / ldData=DATE()

*-- Linhas 1107 a 1115:
1107:             ENDIF
1108: 
1109:             IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) = "DIGITE A SENHA"
1110:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1111:             ENDIF
1112: 
1113:             IF loc_nRetorno = 0
1114:                 EXIT
1115:             ENDIF

*-- Linhas 1234 a 1242:
1234:             ENDIF
1235:         ENDDO
1236: 
1237:         THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.
1238: 
1239:         *-- Legado: IF lnRetorno < 0 .or. ThisForm.Abandona / Thisform.release
1240:         IF loc_nRetorno < 0 OR THIS.this_lAbandona
1241:             THIS.Release()
1242:             RETURN

*-- Linhas 1258 a 1272:
1258: 
1259:         IF loc_lTipoVenda
1260:             IF !THIS.txt_4c_Text1.Enabled
1261:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
1262:                 THIS.txt_4c_Digitos.Enabled = .F.
1263:                 THIS.obj_4c_Optiongroup1.Enabled = .T.
1264:                 THIS.txt_4c_Datas.Enabled = .T.
1265:             ENDIF
1266:         ELSE
1267:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
1268:             THIS.obj_4c_Optiongroup1.Enabled = .T.
1269:         ENDIF
1270: 
1271:         THIS.obj_4c_SAIDA.Enabled = .T.
1272:     ENDPROC

*-- Linhas 1309 a 1317:
1309:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1310: 
1311:             IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
1312:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1313:             ENDIF
1314:             IF loc_nRetorno = 0
1315:                 EXIT
1316:             ENDIF
1317:             IF loc_nRetorno < 0

*-- Linhas 1345 a 1353:
1345:                 LOOP
1346:             ENDIF
1347:             IF loc_oBO.this_nProximoComando = 23
1348:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1349:             ENDIF
1350:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
1351:                 IF loc_oBO.this_lOpFpGarantias
1352:                     loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1353:                 ELSE

*-- Linhas 1379 a 1387:
1379:                 ENDIF
1380:             ENDIF
1381:             IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) = "DIGITE A SENHA"
1382:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1383:             ENDIF
1384:             IF loc_oBO.this_nProximoComando = 3
1385:                 loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_oBO.this_cBuffer)
1386:             ENDIF
1387:             IF loc_oBO.this_nTipoCampo = 100

*-- Linhas 1437 a 1448:
1437:         ENDIF
1438: 
1439:         IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
1440:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
1441:         ELSE
1442:             IF loc_oBO.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada
1443:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
1444:                 THIS.obj_4c_Optiongroup1.Enabled = .T.
1445:                 THIS.txt_4c_Datas.Enabled = .T.
1446:             ELSE
1447:                 THIS.obj_4c_Optiongroup1.Enabled = .F.
1448:             ENDIF

*-- Linhas 1497 a 1505:
1497:         THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1498: 
1499:         IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR loc_oBO.this_nProximoComando = 23
1500:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1501:         ENDIF
1502:         IF loc_oBO.this_nProximoComando = 22
1503:             THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1504:                 ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)))
1505:             loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)

*-- Linhas 1585 a 1605:
1585:         loc_oBO.this_cNsu             = ""
1586:         loc_oBO.this_cAutorizacao     = ""
1587:         loc_oBO.this_cFinalizacao     = ""
1588:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
1589:         loc_oBO.this_cMensagemRetorno = ""
1590: 
1591:         IF loc_oBO.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada AND loc_oBO.this_cOpFpTcdc != "S"
1592:             loc_oBO.this_nContinua = 1000
1593:             IF THIS.obj_4c_Optiongroup1.Enabled
1594:                 loc_oBO.this_cBuffer = STR(THIS.obj_4c_Optiongroup1.Value, 1) + REPLICATE(CHR(0), 1999)
1595:             ELSE
1596:                 DO WHILE loc_oBO.this_nProximoComando != 30
1597:                     loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1598:                     THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1599:                     IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR loc_oBO.this_nProximoComando = 23
1600:                         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1601:                     ENDIF
1602:                     IF loc_nRetorno < 0
1603:                         THIS.ErroTef(loc_nRetorno)
1604:                         THIS.Release()
1605:                         RETURN

*-- Linhas 1614 a 1622:
1614: 
1615:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1616:                 IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
1617:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1618:                 ENDIF
1619:                 IF loc_nRetorno < 0
1620:                     THIS.ErroTef(loc_nRetorno)
1621:                     THIS.Release()
1622:                     RETURN

*-- Linhas 1688 a 1696:
1688:                     loc_oBO.this_cFinalizacao = loc_oBO.this_cBuffer
1689:                 ENDIF
1690:                 IF "DIGITE A SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
1691:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1692:                 ENDIF
1693:                 IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
1694:                     IF loc_oBO.this_lOpFpSaque
1695:                         MsgAviso("Saque via SiTef requer o dialogo SigCsTef, nao portado nesta migracao. Valor de saque assumido: 0,00.", "Saque")
1696:                     ENDIF

*-- Linhas 1742 a 1750:
1742:                     RETURN
1743:                 ENDIF
1744:             ENDIF
1745:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
1746:         ENDIF
1747:     ENDPROC
1748: 
1749:     *--------------------------------------------------------------------------
1750:     * DatasKeyPress - equivalente ao SIGPRDFT.GetDatas.Valid (ENTER/TAB).

*-- Linhas 1771 a 1779:
1771:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1772:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1773:             IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR loc_oBO.this_nProximoComando = 23
1774:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1775:             ENDIF
1776:             IF loc_nRetorno < 0
1777:                 THIS.ErroTef(loc_nRetorno)
1778:                 THIS.Release()
1779:                 RETURN

*-- Linhas 1825 a 1833:
1825:                 EXIT
1826:             ENDIF
1827:             IF loc_oBO.this_nProximoComando = 23
1828:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1829:             ENDIF
1830:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 500
1831:                 loc_oFormSenha = CREATEOBJECT("FormSIGPRSTF")
1832:                 loc_oFormSenha.Show()
1833:                 IF loc_oFormSenha.this_lCancelado

*-- Linhas 1891 a 1899:
1891:                 loc_oBO.this_cFinalizacao = loc_oBO.this_cBuffer
1892:             ENDIF
1893:             IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) $ "DIGITE A SENHA"
1894:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1895:             ENDIF
1896:             IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30
1897:                 loc_cMensagem = loc_oBO.this_cBuffer
1898:                 loc_oBO.this_cBuffer = SPACE(2000)
1899:                 loc_oBO.this_nContinua = 0


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* SIGPRDFTBO.PRG
* Business Object - Integracao com terminal SiTef (pagamento em cartao de debito)
* Origem: SIGPRDFT.scx (form legado, sem tabela propria - integracao com DLL SiTef)
*==============================================================================

DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Parametros de entrada recebidos do form/tela chamadora (Init original)
    this_cEndSiTef = ""             && Endereco do servidor SiTef (EndSiTef)
    this_nValPago = 0               && Valor a ser pago na transacao (ValPago)
    this_cCupom = ""                && Numero do cupom fiscal (Cupom)
    this_cCaixa = ""                && Identificacao do caixa/PDV (Caixa)
    this_cDebCred = ""              && Indicador Debito/Credito (DebCred)
    this_cTipPagto = ""             && Tipo de pagamento (TipPagto)
    this_nNumParcs = 0              && Numero de parcelas informado na chamada (NumParcs)
    this_cIdent = ""                && Identificador da transacao (lcIdent)
    this_cOpers = ""                && Operador responsavel (pcOpers)

    *-- Campos digitados na tela (mapeados dos controles GetValor/GetDigitos/GetCartao/etc)
    this_nValor = 0                 && GetValor.Value - valor da transacao
    this_cDigitos = ""              && GetDigitos.Value - 4 ultimos digitos do cartao
    this_cCartao = ""               && GetCartao.Value - numero do cartao lido/digitado
    this_cBandeira = "00000"        && ThisForm.pcBandeira - bandeira do cartao
    this_nTipoVenda = 1             && Optiongroup1.Value - 1=A Vista, 2=Parcelado
    this_nParcelas = 0              && Text1.Value - numero de parcelas
    this_dDataParc = {}             && GetDatas.Value - data da 1a parcela/vencimento

    *-- Dados de retorno da transacao TEF (preenchidos apos comunicacao com o PIN-PAD)
    this_cTipoTransacao = ""        && lsTipTran - tipo de transacao retornado pelo SiTef
    this_cDataHoraTef = ""          && lsDataHora - data/hora da transacao no SiTef
    this_cCupomTef = ""             && lsCupom - cupom retornado pelo SiTef
    this_cCartaoTef = ""            && lsCartao - numero de cartao mascarado retornado
    this_cNsu = ""                  && lsNsu - Numero Sequencial Unico da transacao
    this_cAutorizacao = ""          && lsAutoriza - codigo de autorizacao
    this_cFinalizacao = ""          && lsFinaliza - codigo de finalizacao da transacao
    this_cMensagemRetorno = ""      && MenRet - mensagem de retorno do SiTef

    *-- Controle de fluxo/protocolo SiTef
    this_nProximoComando = 0        && ProximoComando - protocolo ContinuaFuncaoSiTefInterativo
    this_nTipoCampo = 0             && TipoCampo
    this_nTamanhoMinimo = 0         && TamanhoMinimo
    this_nTamanhoMaximo = 0         && TamanhoMaximo
    this_cBuffer = ""               && Buffer - buffer de comunicacao com o SiTef
    this_nContinua = 0              && lnContinua
    this_lCancela = .F.             && llCancela - indica cancelamento da operacao
    this_lAbandona = .F.            && ThisForm.abandona - indica abandono da tela
    this_lKeyEsc = .T.              && ThisForm.pckeyesc - habilita ESC para cancelar
    this_lTransacaoOk = .F.         && Indica se a transacao foi concluida com sucesso

    *-- Parametros consultados na operacao de pagamento (SigOpFp/sigcdemp/SIGFIMPF)
    this_lOpFpCartao = .F.          && SigOpFp.lcartao = "S" - forma aceita cartao
    this_lOpFpSaque = .F.           && SigOpFp.lsaque = "S" - permite saque
    this_cOpFpTcdc = "N"            && SigOpFp.tcdc - indica consulta CDC
    this_lOpFpGarantias = .F.       && SigOpFp.garantias = "S"
    this_nOpFpDias = 0              && SigOpFp.dias
    this_nOpFpMesFec = 0            && SigOpFp.mesfec
    this_cIdTerminal = ""           && Empresa+caixa enviado ao SiTef (ConfiguraInt*)

    *-- Estado auxiliar do protocolo (migrado de variaveis PUBLIC/PRIVATE do form legado)
    this_lDataConfirmada = .F.      && DCD - .T. apos ProximoComando=21 confirmar data
    this_cCartaoAux = ""            && ThisForm.lsCartao (legado) - Left(Buffer,5) em TipoCampo=131
    this_cValorSaque = "0,00"       && lcSaque - valor de saque (sub-dialogo SigCsTef nao portado)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Este BO nao possui tabela propria: eh uma integracao com o terminal SiTef
    * (DLL CliSiTef32I.DLL), portanto this_cTabela/this_cCampoChave ficam vazios.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.DeclararFuncoesSiTef()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das 4 funcoes do protocolo interativo
    * (migrado de SIGPRDFT.Load). Redeclarar a mesma assinatura eh inofensivo
    * em VFP9; a falha real (DLL ausente) so aparece quando a funcao eh
    * CHAMADA, nao na declaracao - por isso o TRY aqui eh so para nao derrubar
    * InicializarForm em maquina de desenvolvimento sem o CliSiTef32I.DLL.
    *==========================================================================
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        TRY
            DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

            DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
                STRING lsHorario, STRING lsOperador, STRING lsRestricao

            DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
                STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado

            DECLARE INTEGER FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnConfirma, STRING lsCupom, STRING lsData, STRING lsHorario
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/teste sem PIN-pad SiTef) -
            *-- as chamadas reais avisam o usuario via ConectarSiTef/IniciarSiTef.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarParametrosOperacao - Migrado de SIGPRDFT.Init (blocos
    * SqlExecute crSigOpFp/crSigCdEmp) + GotFocus (lcIdTerminal). Le a forma de
    * pagamento (SigOpFp) pelo codigo recebido em this_cOpers e monta o
    * identificador de terminal (empresa+caixa) usado por ConectarSiTef.
    *==========================================================================
    FUNCTION CarregarParametrosOperacao()
        LOCAL loc_lSucesso, loc_oErro, loc_nEmpresa

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT lcartao, lsaque, tcdc, garantias, dias, mesfec FROM SigOpFp " + ;
                "WHERE fpags = " + EscaparSQL(THIS.this_cOpers), ;
                "cursor_4c_SigOpFp")

            IF USED("cursor_4c_SigOpFp") AND !EOF("cursor_4c_SigOpFp")
                THIS.this_lOpFpCartao    = (TratarNulo(cursor_4c_SigOpFp.lcartao, "N") = "S")
                THIS.this_lOpFpSaque     = (TratarNulo(cursor_4c_SigOpFp.lsaque, "N") = "S")
                THIS.this_cOpFpTcdc      = TratarNulo(cursor_4c_SigOpFp.tcdc, "N")
                THIS.this_lOpFpGarantias = (TratarNulo(cursor_4c_SigOpFp.garantias, "N") = "S")
                THIS.this_nOpFpDias      = TratarNulo(cursor_4c_SigOpFp.dias, 0)
                THIS.this_nOpFpMesFec    = TratarNulo(cursor_4c_SigOpFp.mesfec, 0)
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF

            IF loc_lSucesso
                *-- sigcdemp.codemps (numeric) equivale ao SigCdEmp.nEmps legado;
                *-- sigcdemp.cemps (char) eh a chave usada no filtro por empresa.
                IF USED("cursor_4c_SigCdEmpTef")
                    USE IN cursor_4c_SigCdEmpTef
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codemps FROM sigcdemp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_SigCdEmpTef")

                loc_nEmpresa = 0
                IF USED("cursor_4c_SigCdEmpTef") AND !EOF("cursor_4c_SigCdEmpTef")
                    loc_nEmpresa = TratarNulo(cursor_4c_SigCdEmpTef.codemps, 0)
                ENDIF
                IF USED("cursor_4c_SigCdEmpTef")
                    USE IN cursor_4c_SigCdEmpTef
                ENDIF

                *-- SIGFIMPF.cncaixas (caixa/PDV corrente) - SigFiMpF legado nao
                *-- tem equivalente de "caixa aberto" nesta migracao; melhor
                *-- esforco: 1o registro da empresa. Sem match, terminal fecha
                *-- com "000000" (mesmo fallback do legado quando nao localizado).
                IF USED("cursor_4c_SIGFIMPF")
                    USE IN cursor_4c_SIGFIMPF
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_SIGFIMPF")

                IF USED("cursor_4c_SIGFIMPF") AND !EOF("cursor_4c_SIGFIMPF")
                    THIS.this_cIdTerminal = PADL(ALLTRIM(STR(loc_nEmpresa, 5)), 5, "0") + ;
                        TRANSFORM(VAL(TratarNulo(cursor_4c_SIGFIMPF.cncaixas, "0")), "@L 999999")
                ELSE
                    THIS.this_cIdTerminal = PADL(ALLTRIM(STR(loc_nEmpresa, 5)), 5, "0") + "000000"
                ENDIF
                IF USED("cursor_4c_SIGFIMPF")
                    USE IN cursor_4c_SIGFIMPF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao carregar parametros da operacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGPRDFT.GetDigitos.GotFocus (bloco
    * ConfiguraIntSiTefInterativo). Retorna .T. se a comunicacao com o
    * servidor SiTef foi estabelecida.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_nRetorno

        IF EMPTY(THIS.this_cIdTerminal)
            THIS.this_cIdTerminal = "00000000000"
        ENDIF

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            THIS.this_cIdTerminal, THIS.this_cIdTerminal, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGPRDFT.GetDigitos.GotFocus (bloco
    * IniciaFuncaoSiTefInterativo). par_nModalidade=0 eh a unica modalidade
    * usada pelo legado (cartao de debito/credito).
    *==========================================================================
    FUNCTION IniciarSiTef(par_nModalidade, par_cValor, par_cCupom, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = IniciaFuncaoSiTefInterativo(par_nModalidade, par_cValor, par_cCupom, ;
            par_cData, par_cHora, THIS.this_cCaixa, "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (GetDigitos.Valid/GotFocus, GetDatas.Valid/
    * GotFocus, Text1.Valid, SAIDA.CANCELA.Click). Centraliza a chamada por
    * referencia (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) porque VFP9 nao
    * garante passagem por referencia de property de objeto para DLL externa.
    *==========================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), SPACE(2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * FinalizarSiTef - Migrado de SIGPRDFT.GetDatas.Valid (bloco
    * FinalizaTransacaoSiTefInterativo, disparado ao cancelar via senha de
    * supervisor - FormSIGPRSTF).
    *==========================================================================
    FUNCTION FinalizarSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
        RETURN FinalizaTransacaoSiTefInterativo(par_nConfirma, par_cCupom, par_cData, par_cHora)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - SIGPRDFT nao tem cursor nem tabela propria. Os dados
    * digitados na tela (Valor, Digitos, Cartao, TipoVenda, Parcelas, Data)
    * sao atribuidos diretamente as properties this_n*/this_c*/this_d* pelo
    * proprio Form (FormParaBO/BOParaForm), e o retorno da transacao TEF
    * (Nsu/Autorizacao/Finalizacao/etc) vem do protocolo ContinuaFuncaoSiTef
    * Interativo via DLL, nao de um SELECT. Nao ha cursor de banco a
    * percorrer aqui - o comportamento padrao herdado de BusinessBase
    * (no-op, RETURN .T.) ja eh o correto.
    *==========================================================================

    *==========================================================================
    * ObterChavePrimaria - SIGPRDFT nao grava registro nenhum (integracao com
    * o terminal SiTef via CliSiTef32I.DLL - CREATE CURSOR crSiTef eh apenas
    * o buffer de instrucoes do protocolo TEF, nunca persistido no SQL
    * Server). Nao existe chave primaria porque nao existe tabela; retornar
    * vazio mantem RegistrarAuditoria() inofensivo (ela ja aborta quando a
    * chave vem vazia - ver BusinessBase.RegistrarAuditoria).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao: SIGPRDFT eh um dialogo de captura de
    * pagamento em cartao (SIGPRDFT.scx), sem AddCursor, sem tabela e sem SQL
    * de persistencia associados no legado (ver comportamento.json: as unicas
    * queries SQL sao INSERT INTO crSiTef, um cursor LOCAL de memoria usado
    * so para montar o buffer do protocolo ContinuaFuncaoSiTefInterativo, e
    * nunca chega a SQLEXEC/SQL Server). O comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto - nao ha necessidade
    * de sobrescrever esses tres metodos aqui, e RegistrarAuditoria() nunca
    * roda porque Inserir/Atualizar/ExecutarExclusao nunca sao chamados.
    *==========================================================================

ENDDEFINE

