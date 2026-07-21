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
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2122 linhas total):

*-- Linhas 121 a 129:
121:             SET DATE TO BRITISH
122:             SET CENTURY ON
123: 
124:             THIS.Caption     = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
125:             THIS.AlwaysOnTop = .T.
126: 
127:             THIS.CarregarDadosOperacao()
128:             THIS.ConfigurarPageFrame()
129:             THIS.ConfigurarConteudo()

*-- Linhas 192 a 237:
192:     PROTECTED PROCEDURE ConfigurarCabecalho()
193:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
194:         WITH THIS.cnt_4c_Cabecalho
195:             .Top         = 0
196:             .Left        = 0
197:             .Width       = THIS.Width
198:             .Height      = 80
199:             .BorderWidth = 0
200:             .BackStyle   = 1
201:             .BackColor   = RGB(100, 100, 100)
202: 
203:             .AddObject("lbl_4c_Sombra", "Label")
204:             WITH .lbl_4c_Sombra
205:                 .AutoSize  = .F.
206:                 .FontBold  = .T.
207:                 .FontName  = "Tahoma"
208:                 .FontSize  = 18
209:                 .WordWrap  = .T.
210:                 .Alignment = 0
211:                 .BackStyle = 0
212:                 .Caption   = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
213:                 .Height    = 40
214:                 .Left      = 10
215:                 .Top       = 18
216:                 .Width     = THIS.Width
217:                 .ForeColor = RGB(0, 0, 0)
218:             ENDWITH
219: 
220:             .AddObject("lbl_4c_Titulo", "Label")
221:             WITH .lbl_4c_Titulo
222:                 .AutoSize    = .F.
223:                 .FontBold    = .T.
224:                 .FontName    = "Tahoma"
225:                 .FontSize    = 18
226:                 .WordWrap    = .T.
227:                 .Alignment   = 0
228:                 .BackStyle   = 0
229:                 .Caption     = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
230:                 .Height      = 46
231:                 .Left        = 10
232:                 .Top         = 17
233:                 .Width       = THIS.Width
234:                 .ForeColor   = RGB(255, 255, 255)
235:                 .ToolTipText = "T" + CHR(237) + "tulo"
236:             ENDWITH
237:         ENDWITH

*-- Linhas 250 a 273:
250:             .BorderStyle = 0
251:             .Value       = 0
252:             .Height      = 85
253:             .Left        = 420
254:             .Top         = -2
255:             .Width       = 85
256:             .BackColor   = RGB(255, 255, 255)
257:             .Themes      = .F.
258: 
259:             WITH .Buttons(1)
260:                 .Top        = 5
261:                 .Left       = 5
262:                 .Height     = 75
263:                 .Width      = 75
264:                 .FontBold   = .T.
265:                 .FontItalic = .T.
266:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
267:                 .Cancel     = .F.
268:                 .Caption    = CHR(60) + "Cancelar"
269:                 .ForeColor  = RGB(90, 90, 90)
270:                 .BackColor  = RGB(255, 255, 255)
271:                 .Themes     = .F.
272:                 .Name       = "CANCELA"
273:             ENDWITH

*-- Linhas 286 a 313:
286:             *-- Shape2: borda decorativa ao redor dos campos de entrada
287:             THIS.AddObject("shp_4c_Shape2", "Shape")
288:             WITH THIS.shp_4c_Shape2
289:                 .Top           = 93
290:                 .Left          = 17
291:                 .Height        = 202
292:                 .Width         = 466
293:                 .SpecialEffect = 0
294:             ENDWITH
295: 
296:             *-- Label5: rotulo "VALOR :"
297:             THIS.AddObject("lbl_4c_Label5", "Label")
298:             WITH THIS.lbl_4c_Label5
299:                 .AutoSize  = .F.
300:                 .FontBold  = .T.
301:                 .FontName  = "Tahoma"
302:                 .FontSize  = 8
303:                 .Alignment = 0
304:                 .BackStyle = 0
305:                 .Caption   = "VALOR :"
306:                 .Height    = 15
307:                 .Left      = 175
308:                 .Top       = 102
309:                 .Width     = 45
310:                 .ForeColor = RGB(90, 90, 90)
311:             ENDWITH
312: 
313:             *-- GetValor: valor da transacao (somente leitura - exibe valor recebido)

*-- Linhas 322 a 350:
322:                 .Format            = ""
323:                 .Height            = 23
324:                 .InputMask         = "99,999,999.99"
325:                 .Left              = 222
326:                 .TabIndex          = 1
327:                 .Top               = 99
328:                 .Width             = 100
329:                 .ForeColor         = RGB(0, 0, 0)
330:                 .DisabledForeColor = RGB(0, 0, 0)
331:             ENDWITH
332: 
333:             *-- Label8: rotulo "NUMERO CARTAO :"
334:             THIS.AddObject("lbl_4c_Label8", "Label")
335:             WITH THIS.lbl_4c_Label8
336:                 .AutoSize  = .F.
337:                 .FontBold  = .T.
338:                 .FontName  = "Tahoma"
339:                 .FontSize  = 8
340:                 .Alignment = 0
341:                 .BackStyle = 0
342:                 .Caption   = "NUMERO CARTAO :"
343:                 .Height    = 15
344:                 .Left      = 116
345:                 .Top       = 136
346:                 .Width     = 104
347:                 .ForeColor = RGB(90, 90, 90)
348:             ENDWITH
349: 
350:             *-- GetCartao: numero do cartao (Enabled=.F. por padrao; ativa se lCartao="S")

*-- Linhas 359 a 389:
359:                 .Format            = ""
360:                 .Height            = 23
361:                 .InputMask         = "9999999999999999999"
362:                 .Left              = 222
363:                 .MaxLength         = 19
364:                 .TabIndex          = 2
365:                 .Top               = 133
366:                 .Width             = 160
367:                 .ForeColor         = RGB(0, 0, 0)
368:                 .DisabledForeColor = RGB(0, 0, 0)
369:             ENDWITH
370:             BINDEVENT(THIS.txt_4c_Cartao, "GotFocus", THIS, "TxtCartaoGotFocus")
371: 
372:             *-- Label2: rotulo "4 ULTIMOS DIGITOS :" (muda para "Validade Cartao :" quando lCartao="S")
373:             THIS.AddObject("lbl_4c_Label2", "Label")
374:             WITH THIS.lbl_4c_Label2
375:                 .AutoSize  = .F.
376:                 .FontBold  = .T.
377:                 .FontName  = "Tahoma"
378:                 .FontSize  = 8
379:                 .Alignment = 0
380:                 .BackStyle = 0
381:                 .Caption   = "4 ULTIMOS DIGITOS :"
382:                 .Height    = 17
383:                 .Left      = 101
384:                 .Top       = 171
385:                 .Width     = 119
386:                 .ForeColor = RGB(90, 90, 90)
387:             ENDWITH
388: 
389:             *-- GetDigitos: 4 ultimos digitos do cartao (GotFocus inicia sessao TEF)

*-- Linhas 395 a 459:
395:                 .Enabled   = .T.
396:                 .Height    = 23
397:                 .InputMask = "9999"
398:                 .Left      = 222
399:                 .TabIndex  = 3
400:                 .Top       = 168
401:                 .Width     = 40
402:                 .ForeColor = RGB(0, 0, 0)
403:                 .BackColor = RGB(212, 208, 200)
404:             ENDWITH
405:             BINDEVENT(THIS.txt_4c_Digitos, "GotFocus", THIS, "TxtDigitosGotFocus")
406:             BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "TxtDigitosKeyPress")
407: 
408:             *-- Label4: rotulo "TIPO DE VENDA :"
409:             THIS.AddObject("lbl_4c_Label4", "Label")
410:             WITH THIS.lbl_4c_Label4
411:                 .AutoSize  = .F.
412:                 .FontBold  = .T.
413:                 .FontName  = "Tahoma"
414:                 .FontSize  = 8
415:                 .Alignment = 0
416:                 .BackStyle = 0
417:                 .Caption   = "TIPO DE VENDA :"
418:                 .Height    = 15
419:                 .Left      = 129
420:                 .Top       = 204
421:                 .Width     = 91
422:                 .ForeColor = RGB(90, 90, 90)
423:             ENDWITH
424: 
425:             *-- Optiongroup1: selecao "A vista" / "Predatado"
426:             THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
427:             WITH THIS.obj_4c_Optiongroup1
428:                 .ButtonCount = 2
429:                 .Enabled     = .T.
430:                 .Height      = 26
431:                 .Left        = 222
432:                 .Top         = 200
433:                 .Width       = 161
434:                 .TabIndex    = 5
435:                 WITH .Buttons(1)
436:                     .FontBold  = .T.
437:                     .Caption   = " A vista"
438:                     .Height    = 17
439:                     .Left      = 5
440:                     .Top       = 4
441:                     .Width     = 61
442:                     .ForeColor = RGB(90, 90, 90)
443:                     .BackStyle = 0
444:                     .AutoSize  = .F.
445:                     .Themes    = .F.
446:                 ENDWITH
447:                 WITH .Buttons(2)
448:                     .FontBold  = .T.
449:                     .FontName  = "Tahoma"
450:                     .FontSize  = 8
451:                     .Caption   = " Predatado"
452:                     .Height    = 15
453:                     .Left      = 73
454:                     .Top       = 5
455:                     .Width     = 80
456:                     .ForeColor = RGB(90, 90, 90)
457:                     .BackStyle = 0
458:                     .AutoSize  = .F.
459:                     .Themes    = .F.

*-- Linhas 465 a 484:
465:             BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "GotFocus", THIS, "OptGrupoOption1GotFocus")
466: 
467:             *-- Label6: rotulo "N? PARCELAS :"
468:             THIS.AddObject("lbl_4c_Label6", "Label")
469:             WITH THIS.lbl_4c_Label6
470:                 .AutoSize  = .F.
471:                 .FontBold  = .T.
472:                 .FontName  = "Tahoma"
473:                 .FontSize  = 8
474:                 .Alignment = 0
475:                 .BackStyle = 0
476:                 .Caption   = "N" + CHR(186) + " PARCELAS :"
477:                 .Height    = 15
478:                 .Left      = 139
479:                 .Top       = 238
480:                 .Width     = 81
481:                 .ForeColor = RGB(90, 90, 90)
482:             ENDWITH
483: 
484:             *-- Text1: numero de parcelas (habilitado pelo TEF quando aplicavel)

*-- Linhas 491 a 523:
491:                 .Format            = ""
492:                 .Height            = 23
493:                 .InputMask         = "99"
494:                 .Left              = 222
495:                 .TabIndex          = 6
496:                 .Top               = 235
497:                 .Width             = 27
498:                 .ForeColor         = RGB(0, 0, 0)
499:                 .DisabledForeColor = RGB(0, 0, 0)
500:                 .Value             = ""
501:             ENDWITH
502:             BINDEVENT(THIS.txt_4c_Text1, "GotFocus",  THIS, "TxtText1GotFocus")
503:             BINDEVENT(THIS.txt_4c_Text1, "KeyPress",   THIS, "TxtText1KeyPress")
504:             BINDEVENT(THIS.txt_4c_Text1, "KeyPress",  THIS, "TxtText1LostFocus")
505: 
506:             *-- Label11: rotulo "1a PARCELA/VENCTO :"
507:             THIS.AddObject("lbl_4c_Label11", "Label")
508:             WITH THIS.lbl_4c_Label11
509:                 .AutoSize  = .F.
510:                 .FontBold  = .T.
511:                 .FontName  = "Tahoma"
512:                 .FontSize  = 8
513:                 .Alignment = 0
514:                 .BackStyle = 0
515:                 .Caption   = "1" + CHR(186) + " PARCELA/VENCTO :"
516:                 .Height    = 15
517:                 .Left      = 98
518:                 .Top       = 268
519:                 .Width     = 122
520:                 .ForeColor = RGB(90, 90, 90)
521:             ENDWITH
522: 
523:             *-- GetDatas: data da primeira parcela ou vencimento

*-- Linhas 532 a 573:
532:                 .Format            = ""
533:                 .Height            = 23
534:                 .InputMask         = ""
535:                 .Left              = 222
536:                 .TabIndex          = 7
537:                 .Top               = 266
538:                 .Width             = 75
539:                 .ForeColor         = RGB(0, 0, 0)
540:                 .DisabledForeColor = RGB(0, 0, 0)
541:             ENDWITH
542:             BINDEVENT(THIS.txt_4c_Datas, "GotFocus",  THIS, "TxtDatasGotFocus")
543:             BINDEVENT(THIS.txt_4c_Datas, "KeyPress",   THIS, "TxtDatasKeyPress")
544:             BINDEVENT(THIS.txt_4c_Datas, "KeyPress",  THIS, "TxtDatasLostFocus")
545: 
546:             *-- Container1: exibe mensagem de instrucao ao usuario (tipo "Insira o Cartao")
547:             THIS.AddObject("cnt_4c_Container1", "Container")
548:             WITH THIS.cnt_4c_Container1
549:                 .Top           = 298
550:                 .Left          = 54
551:                 .Width         = 392
552:                 .Height        = 58
553:                 .SpecialEffect = 0
554:                 .BackStyle     = 1
555:                 .BackColor     = RGB(255, 255, 255)
556: 
557:                 .AddObject("lbl_4c_Label1", "Label")
558:                 WITH .lbl_4c_Label1
559:                     .AutoSize  = .F.
560:                     .FontBold  = .T.
561:                     .FontName  = "Tahoma"
562:                     .FontSize  = 18
563:                     .Alignment = 2
564:                     .BackStyle = 0
565:                     .Caption   = "Insira ou Passe o Cartao"
566:                     .Height    = 29
567:                     .Left      = 18
568:                     .Top       = 14
569:                     .Width     = 349
570:                     .ForeColor = RGB(90, 90, 90)
571:                 ENDWITH
572:             ENDWITH
573: 

*-- Linhas 593 a 612:
593:             IF USED("crSigOpFp")
594:                 IF crSigOpFp.lCartao = "S"
595:                     THIS.txt_4c_Cartao.Enabled = .T.
596:                     THIS.lbl_4c_Label2.Caption  = "Validade Cart" + CHR(227) + "o :"
597:                 ENDIF
598:             ENDIF
599: 
600:             IF !THIS.txt_4c_Datas.Enabled
601:                 IF USED("crSigOpFp") AND crSigOpFp.lCartao = "N"
602:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
603:                 ELSE
604:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
605:                 ENDIF
606:             ELSE
607:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
608:             ENDIF
609: 
610:             THIS.txt_4c_Digitos.BackColor = RGB(212, 208, 200)
611: 
612:         CATCH TO loc_oErro

*-- Linhas 790 a 798:
790:             ENDIF
791: 
792:             IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DIGITE A SENHA"
793:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
794:             ENDIF
795: 
796:             IF loc_nRetorno = 0
797:                 EXIT
798:             ENDIF

*-- Linhas 923 a 931:
923:             ENDIF
924:         ENDDO
925: 
926:         THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.
927: 
928:         IF loc_nRetorno < 0 OR THIS.this_lAbandonou
929:             THIS.Release()
930:             RETURN
931:         ENDIF

*-- Linhas 943 a 957:
943: 
944:         IF loc_lTipoVenda
945:             IF !THIS.txt_4c_Text1.Enabled
946:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
947:                 THIS.txt_4c_Digitos.Enabled          = .F.
948:                 THIS.obj_4c_Optiongroup1.Enabled     = .T.
949:                 THIS.txt_4c_Datas.Enabled            = .T.
950:             ENDIF
951:         ELSE
952:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
953:             THIS.obj_4c_Optiongroup1.Enabled             = .T.
954:         ENDIF
955: 
956:         THIS.obj_4c_SAIDA.Enabled = .T.
957:     ENDPROC

*-- Linhas 1015 a 1023:
1015:             ENDIF
1016: 
1017:             IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1018:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1019:             ENDIF
1020: 
1021:             IF loc_nRetorno = 0
1022:                 EXIT
1023:             ENDIF

*-- Linhas 1067 a 1075:
1067:             ENDIF
1068: 
1069:             IF THIS.this_nProxCmd = 23
1070:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1071:             ENDIF
1072: 
1073:             IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 510
1074:                 THIS.this_cBuffer = IIF(USED("crSigOpFp") AND crSigOpFp.Garantias = "S", ;
1075:                     "1", "2") + REPLICATE(CHR(0), 1999)

*-- Linhas 1102 a 1110:
1102:             ENDIF
1103: 
1104:             IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DIGITE A SENHA"
1105:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1106:             ENDIF
1107: 
1108:             IF THIS.this_nProxCmd = 3
1109:                 THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
1110:             ENDIF

*-- Linhas 1162 a 1173:
1162:         ENDIF
1163: 
1164:         IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 514
1165:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
1166:         ELSE
1167:             IF THIS.this_oBusinessObject.this_cDebCred <> "P" AND !THIS.this_lDCD
1168:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
1169:                 THIS.obj_4c_Optiongroup1.Enabled             = .T.
1170:                 THIS.txt_4c_Datas.Enabled                    = .T.
1171:             ELSE
1172:                 THIS.obj_4c_Optiongroup1.Enabled = .F.
1173:             ENDIF

*-- Linhas 1182 a 1190:
1182:     * Garante que instrucao esteja visivel para cartao manual
1183:     *==========================================================================
1184:     PROCEDURE TxtCartaoGotFocus()
1185:         THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * OptGrupoInteractiveChange - Habilita GetDatas ao mudar tipo de venda
1190:     * Migrado de: SIGPRDFT.Optiongroup1.InteractiveChange

*-- Linhas 1257 a 1265:
1257:         ENDIF
1258: 
1259:         IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1260:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1261:         ENDIF
1262: 
1263:         IF THIS.this_nProxCmd = 22
1264:             MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
1265:                      ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")

*-- Linhas 1299 a 1307:
1299:         THIS.this_cNsu      = ""
1300:         THIS.this_cAutoriza = ""
1301:         THIS.this_cFinaliza = ""
1302:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
1303:         THIS.this_cMRet     = ""
1304: 
1305:         IF THIS.this_oBusinessObject.this_cDebCred <> "P" AND ;
1306:            !THIS.this_lDCD AND ;
1307:            USED("crSigOpFp") AND crSigOpFp.Tcdc <> "S"

*-- Linhas 1318 a 1326:
1318:                         @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1319:                         @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1320:                     IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1321:                         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1322:                     ENDIF
1323:                     IF THIS.this_nProxCmd = 23
1324:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1325:                     ELSE
1326:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.

*-- Linhas 1360 a 1368:
1360:                     THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1361:                 ENDIF
1362:                 IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1363:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1364:                 ENDIF
1365:                 IF loc_nRetorno < 0
1366:                     THIS.ErroTef(loc_nRetorno)
1367:                     THIS.Release()
1368:                     RETURN

*-- Linhas 1454 a 1462:
1454:                     THIS.this_cFinaliza = THIS.this_cBuffer
1455:                 ENDIF
1456:                 IF UPPER(ALLTRIM(THIS.this_cBuffer)) $ "DIGITE A SENHA"
1457:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1458:                 ENDIF
1459:                 IF THIS.this_nProxCmd = 34 AND THIS.this_nTipoCampo = 130
1460:                     THIS.this_cSaque  = "0,00"
1461:                     THIS.this_cBuffer = THIS.this_cSaque + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cSaque))
1462:                     THIS.this_nContinua = 1000

*-- Linhas 1505 a 1513:
1505:                     THIS.Release()
1506:                 ENDIF
1507:             ENDIF
1508:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
1509:         ENDIF
1510:     ENDPROC
1511: 
1512:     *==========================================================================
1513:     * TxtDatasKeyPress - Processa data de vencimento ao pressionar Enter/Tab

*-- Linhas 1546 a 1554:
1546:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1547:             ENDIF
1548:             IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1549:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1550:             ENDIF
1551:             IF loc_nRetorno < 0
1552:                 THIS.ErroTef(loc_nRetorno)
1553:                 THIS.Release()
1554:                 RETURN

*-- Linhas 1591 a 1599:
1591:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1592:             ENDIF
1593:             IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1594:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1595:             ENDIF
1596:             IF loc_nRetorno < 0
1597:                 THIS.ErroTef(loc_nRetorno)
1598:                 THIS.Release()
1599:                 RETURN

*-- Linhas 1633 a 1641:
1633:             ENDIF
1634: 
1635:             IF THIS.this_nProxCmd = 23
1636:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1637:             ENDIF
1638: 
1639:             IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 500
1640:                 MsgInfo("Senha solicitada - terminal de senha necessario")
1641:                 THIS.RetornoFalha("Operacao Cancelada pelo Usuario", THIS.this_oBusinessObject.this_nValPago)

*-- Linhas 1806 a 1816:
1806:                 loc_cMsg = "Insira ou Passe o Cart" + CHR(227) + "o"
1807:         ENDCASE
1808:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5) AND ;
1809:            PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
1810:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = loc_cMsg
1811:             THIS.cnt_4c_Container1.lbl_4c_Label1.Refresh()
1812:         ENDIF
1813:     ENDPROC
1814: 
1815:     *==========================================================================
1816:     * BtnIncluirClick - Inicia nova sess" + CHR(227) + "o TEF

*-- Linhas 2060 a 2068:
2060:             THIS.this_lParcelas                    = .F.
2061:             THIS.this_lDCD                         = .F.
2062:             THIS.obj_4c_Optiongroup1.Value         = 1
2063:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe o Cart" + CHR(227) + "o"
2064:         CATCH TO loc_oErro
2065:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
2066:         ENDTRY
2067:     ENDPROC
2068: 


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* sigprdftBO.prg - Business Object para integracao SiTef (Cartao de Debito)
* Form original: SIGPRDFT.SCX
* Tipo: OPERACIONAL - dialogo modal de transacao TEF
*==============================================================================
DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Identificacao da entidade (sem tabela CRUD - form operacional)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Parametros de inicializacao recebidos via Init do form
    this_cEndSiTef   = ""
    this_nValPago    = 0
    this_cCupom      = ""
    this_cCaixa      = ""
    this_cDebCred    = ""
    this_cTipPagto   = ""
    this_nNumParcs   = 0
    this_cIdent      = ""
    this_cOpers      = ""

    *-- Dados retornados pelo SiTef apos a transacao
    this_cBandeira   = ""
    this_cCartao     = ""
    this_cNsu        = ""
    this_cAutoriza   = ""
    this_cDataHora   = ""
    this_cTipTran    = ""
    this_cFinaliza   = ""
    this_cMsgRetorno = ""

    *-- Flags e estado da transacao
    this_lAbandonou  = .F.
    this_lDCD        = .F.
    this_cSaqueValor = ""
    this_nParcelas   = 0

    *-- Dados do terminal calculados em runtime
    this_cIdTerminal = ""
    this_cValorStr   = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Override obrigatorio de BusinessBase
    * Form OPERACIONAL (dialogo SiTef) nao possui tabela CRUD. Os dados
    * persistidos sao os arquivos IntPos.001/IntPos.STS gerados por
    * MontaRetorno/RetornoFalha, portanto este metodo eh no-op.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".ValPago") = "N"
                    THIS.this_nValPago = NVL(&par_cAliasCursor..ValPago, 0)
                ENDIF
                IF TYPE(par_cAliasCursor + ".Cupom") = "C"
                    THIS.this_cCupom = NVL(&par_cAliasCursor..Cupom, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Caixa") = "C"
                    THIS.this_cCaixa = NVL(&par_cAliasCursor..Caixa, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Ident") = "C"
                    THIS.this_cIdent = NVL(&par_cAliasCursor..Ident, "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarDoCursor SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Override de BusinessBase para form OPERACIONAL (SiTef)
    * Nao ha tabela CRUD. A persistencia ocorre via arquivos IntPos.001/
    * IntPos.STS gerados por MontaRetorno() apos a transacao SiTef ter
    * sucesso. Este metodo apenas registra a auditoria da operacao.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            THIS.RegistrarAuditoria("INSERT_TEF")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Inserir SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Override de BusinessBase para form OPERACIONAL (SiTef)
    * Nao ha tabela CRUD. Transacoes SiTef nao sao atualizadas apos
    * confirmacao (o protocolo TEF eh append-only). Este metodo apenas
    * registra a auditoria caso seja chamado.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            THIS.RegistrarAuditoria("UPDATE_TEF")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Atualizar SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Registra auditoria da transacao SiTef em LogAuditoria
    * Override que grava informacoes relevantes da transacao mesmo sem tabela
    * de destino (usa NSU + autorizacao como chave logica).
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lOk, loc_oErro

        loc_lOk = .T.
        TRY
            loc_cChave   = ALLTRIM(THIS.this_cNsu) + "|" + ALLTRIM(THIS.this_cAutoriza)
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChavePrimaria, Detalhes) " + ;
                       "VALUES (" + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                       EscaparSQL(LEFT(par_cOperacao, 20)) + ", " + ;
                       EscaparSQL("SIGPRDFT_SITEF") + ", " + ;
                       EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                       EscaparSQL(LEFT("Valor=" + TRANSFORM(THIS.this_nValPago, "@$ 999,999.99") + ;
                                       " Cupom=" + ALLTRIM(THIS.this_cCupom) + ;
                                       " Bandeira=" + ALLTRIM(THIS.this_cBandeira), 500)) + ;
                       ")"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lOk = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * InicializarDLLs - Declara funcoes da DLL CliSiTef32I
    * Migrado de: SIGPRDFT.Load
    *==========================================================================
    PROCEDURE InicializarDLLs()
        LOCAL loc_oErro
        TRY
            DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                String lsEndereco, String lsLoja, String lsTerminal, Integer lnReservado
            DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnModalidade, String lsValor, String lsCupom, ;
                String lsData, String lsHorario, String lsOperador, String lsRestricao
            DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer @lnComando, Integer @lnTipo, Integer @lnMinimo, Integer @lnMaximo, ;
                String @lsBuffer, Integer lnTamanho, Integer lnResultado
            DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnConfirma, String lsCupom, String lsData, String lsHorario
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro DLL SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ErroTef - Trata codigos de erro retornados pelo protocolo SiTef
    * Migrado de: SIGPRDFT.errotef
    *==========================================================================
    PROCEDURE ErroTef(par_nRetorno)
        LOCAL loc_cMsgPadrao
        loc_cMsgPadrao = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"

        IF TYPE("par_nRetorno") <> "N"
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
            RETURN
        ENDIF

        IF par_nRetorno > -1 OR par_nRetorno < -5
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
            RETURN
        ENDIF

        DO CASE
        CASE par_nRetorno = -1
            THIS.RetornoFalha("Modulo Nao Iniciado", THIS.this_nValPago)
        CASE par_nRetorno = -2
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
        CASE par_nRetorno = -3
            THIS.RetornoFalha("Fornecida uma Modalidade Invalida", THIS.this_nValPago)
        CASE par_nRetorno = -4
            THIS.RetornoFalha("Falta Memoria para Rodar a Funcao", THIS.this_nValPago)
        CASE par_nRetorno = -5
            THIS.RetornoFalha("Sem Comunicacao com o SiTef", THIS.this_nValPago)
        ENDCASE
    ENDPROC

    *==========================================================================
    * MontaRetorno - Monta cursor crSiTef e grava arquivos de resposta de SUCESSO
    * Migrado de: SIGPRDFT.montaretorno
    * Par: par_sTipTran  = tipo da transacao (TipoCampo 100)
    *      par_sDataHora = data/hora no formato SiTef (TipoCampo 105)
    *      par_sCupom    = cupom fiscal com linhas separadas por CHR(10)
    *      par_sCartao   = codigo da bandeira selecionada
    *      par_sNsu      = NSU da transacao (TipoCampo 134)
    *      par_sAutoriza = codigo de autorizacao (TipoCampo 135)
    *      par_sFinaliza = dados de finalizacao
    *      par_nValPago  = valor da transacao
    *      par_sMenRet   = mensagem de retorno
    *==========================================================================
    PROCEDURE MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, par_sCartao, ;
                           par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
        LOCAL loc_sValPago, loc_sCartaoSel, loc_sCupomWork, loc_sPos, loc_nLinha
        LOCAL loc_laCartao[11]

        loc_sValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

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

        IF VAL(THIS.this_cBandeira) > 10 OR VAL(THIS.this_cBandeira) < 0
            loc_sCartaoSel = "0"
        ELSE
            loc_sCartaoSel = THIS.this_cBandeira
        ENDIF

        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        CREATE CURSOR crSiTef (tef c(100))

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
        INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_laCartao[VAL(loc_sCartaoSel) + 1])
        INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_sTipTran)
        INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_sNsu)
        INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_sAutoriza)
        INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + ALLTRIM(TRANSFORM(THIS.this_nParcelas, "@L 99")))
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 1, 4))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_sFinaliza)
        INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_sDataHora, 9, 6))

        loc_sPos       = 1
        loc_nLinha     = 1
        loc_sCupomWork = par_sCupom
        DO WHILE loc_sPos <> 0
            loc_sPos = AT(CHR(10), loc_sCupomWork)
            INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                IIF(loc_sPos <> 0, SUBSTR(loc_sCupomWork, 1, loc_sPos - 1), loc_sCupomWork))
            loc_sCupomWork = SUBSTR(loc_sCupomWork, loc_sPos + 1)
            loc_nLinha = loc_nLinha + 1
        ENDDO
        INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
        INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_sMenRet)
        INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        SET SAFETY OFF
        SELECT crSiTef
        COPY TO C:\client\Resp\IntPos.001 SDF
        ZAP

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        COPY TO C:\client\Resp\IntPos.STS SDF
        SET SAFETY ON

        USE IN crSiTef
    ENDPROC

    *==========================================================================
    * RetornoFalha - Monta cursor crSiTef e grava arquivos de resposta de FALHA
    * Migrado de: SIGPRDFT.retornofalha
    * Par: par_cMensagem = mensagem descritiva da falha
    *      par_nValPago  = valor da transacao (para registro no arquivo)
    *==========================================================================
    PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_cMensagem, loc_sValPago

        loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
            "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", ;
            par_cMensagem)
        loc_sValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        CREATE CURSOR crSiTef (tef c(100))

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
        INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
        INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
        INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
            IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
        INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        SET SAFETY OFF
        SELECT crSiTef
        COPY TO C:\client\Resp\IntPos.001 SDF
        ZAP

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        COPY TO C:\client\Resp\IntPos.STS SDF
        SET SAFETY ON

        USE IN crSiTef
    ENDPROC

    *==========================================================================
    * ObterRetornoStr - Retorna string de saida do form para o processo chamador
    * Migrado de: SIGPRDFT.Unload (logica de RETURN)
    * Formato: "saque/parcelas/data+bandeira+cartao"
    * Par: par_cSaque   = valor do saque formatado (ex: "0,00")
    *      par_nParcs   = numero de parcelas confirmadas
    *      par_dData    = data da parcela/vencimento
    *==========================================================================
    FUNCTION ObterRetornoStr(par_cSaque, par_nParcs, par_dData)
        LOCAL loc_cSaque, loc_cBandeira, loc_cCartao

        loc_cSaque    = IIF(EMPTY(par_cSaque), "0,00", par_cSaque)
        loc_cBandeira = IIF(EMPTY(THIS.this_cBandeira), "00000", LEFT(THIS.this_cBandeira + "00000", 5))
        loc_cCartao   = IIF(EMPTY(THIS.this_cCartao), "00000", LEFT(THIS.this_cCartao + "00000", 5))

        RETURN loc_cSaque + "/" + ;
               ALLTRIM(TRANSFORM(par_nParcs, "@L 99")) + "/" + ;
               DTOC(par_dData) + ;
               loc_cBandeira + ;
               loc_cCartao
    ENDPROC

ENDDEFINE

