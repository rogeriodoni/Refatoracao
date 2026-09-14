# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_BalTmpMccr' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrebal.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1271 linhas total):

*-- Linhas 58 a 66:
58:                 THIS.this_oRelatorio = CREATEOBJECT("sigrebalBO")
59: 
60:                 THIS.ConfigurarCabecalho()
61:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
62:                 THIS.ConfigurarBotoes()
63:                 THIS.ConfigurarCampos()
64:                 THIS.ConfigurarBINDEVENTs()
65: 
66:                 THIS.AtualizarEstadoMoedaDesc()

*-- Linhas 109 a 167:
109:     PROTECTED PROCEDURE ConfigurarCabecalho()
110:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH THIS.cnt_4c_Cabecalho
112:             .Top         = 0
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
122:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
123:             .Top       = 25
124:             .Left      = 20
125:             .AutoSize  = .T.
126:             .Caption   = "Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o"
127:             .FontName  = "Tahoma"
128:             .FontSize  = 14
129:             .FontBold  = .T.
130:             .ForeColor = RGB(255, 255, 255)
131:             .BackStyle = 0
132:             .Visible   = .T.
133:         ENDWITH
134:         THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible = .T.
135:         THIS.cnt_4c_Cabecalho.Visible = .T.
136:     ENDPROC
137: 
138:     *--------------------------------------------------------------------------
139:     * ConfigurarBotoes - CommandGroup com 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarBotoes()
142:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
143:         WITH THIS.cmg_4c_Botoes
144:             .Top           = 0
145:             .Left          = 529
146:             .Width         = 273
147:             .Height        = 80
148:             .ButtonCount   = 4
149:             .BackStyle     = 0
150:             .BorderStyle   = 0
151:             .BorderColor   = RGB(136, 189, 188)
152:             .SpecialEffect = 1
153:             .Themes        = .F.
154:             .Visible       = .T.
155:         ENDWITH
156: 
157:         WITH THIS.cmg_4c_Botoes.Buttons(1)
158:             .Top             = 5
159:             .Left            = 5
160:             .Width           = 65
161:             .Height          = 70
162:             .Caption         = "Visualizar"
163:             .FontName        = "Tahoma"
164:             .FontBold        = .T.
165:             .FontItalic      = .T.
166:             .FontSize        = 8
167:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"

*-- Linhas 174 a 186:
174:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
175: 
176:         WITH THIS.cmg_4c_Botoes.Buttons(2)
177:             .Top             = 5
178:             .Left            = 71
179:             .Width           = 65
180:             .Height          = 70
181:             .Caption         = "Imprimir"
182:             .FontName        = "Tahoma"
183:             .FontBold        = .T.
184:             .FontItalic      = .T.
185:             .FontSize        = 8
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"

*-- Linhas 193 a 205:
193:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
194: 
195:         WITH THIS.cmg_4c_Botoes.Buttons(3)
196:             .Top             = 5
197:             .Left            = 137
198:             .Width           = 65
199:             .Height          = 70
200:             .Caption         = "Excel"
201:             .FontName        = "Tahoma"
202:             .FontBold        = .T.
203:             .FontItalic      = .T.
204:             .FontSize        = 8
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"

*-- Linhas 212 a 224:
212:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
213: 
214:         WITH THIS.cmg_4c_Botoes.Buttons(4)
215:             .Top             = 5
216:             .Left            = 203
217:             .Width           = 65
218:             .Height          = 70
219:             .Caption         = "Encerrar"
220:             .FontName        = "Tahoma"
221:             .FontBold        = .T.
222:             .FontItalic      = .T.
223:             .FontSize        = 8
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 243 a 296:
243:     PROTECTED PROCEDURE ConfigurarPaginaDados()
244: 
245:         *-- === ATE (periodo) top=132/137 ===
246:         THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
247:         WITH THIS.lbl_4c_Lbl_periodo
248:             .Top       = 137
249:             .Left      = 258
250:             .AutoSize  = .T.
251:             .Caption   = "At" + CHR(233) + " :"
252:             .FontName  = "Tahoma"
253:             .FontSize  = 8
254:             .BackStyle = 0
255:             .ForeColor = RGB(90, 90, 90)
256:             .Visible   = .T.
257:         ENDWITH
258: 
259:         THIS.AddObject("txt_4c__dt_final", "TextBox")
260:         WITH THIS.txt_4c__dt_final
261:             .Top           = 132
262:             .Left          = 288
263:             .Width         = 80
264:             .Height        = 23
265:             .FontName      = "Tahoma"
266:             .FontSize      = 9
267:             .Format        = "K"
268:             .SpecialEffect = 1
269:             .BorderColor   = RGB(100, 100, 100)
270:             .Value         = DATE()
271:             .Visible       = .T.
272:         ENDWITH
273: 
274:         *-- === MOEDA top=157/161 ===
275:         THIS.AddObject("lbl_4c_Lbl_moeda", "Label")
276:         WITH THIS.lbl_4c_Lbl_moeda
277:             .Top       = 161
278:             .Left      = 243
279:             .AutoSize  = .T.
280:             .Caption   = "Moeda :"
281:             .FontName  = "Tahoma"
282:             .FontSize  = 8
283:             .BackStyle = 0
284:             .ForeColor = RGB(90, 90, 90)
285:             .Visible   = .T.
286:         ENDWITH
287: 
288:         THIS.AddObject("txt_4c__cd_moeda", "TextBox")
289:         WITH THIS.txt_4c__cd_moeda
290:             .Top           = 157
291:             .Left          = 288
292:             .Width         = 31
293:             .Height        = 23
294:             .FontName      = "Tahoma"
295:             .FontSize      = 9
296:             .Format        = "K!"

*-- Linhas 303 a 312:
303: 
304:         THIS.AddObject("txt_4c__ds_moeda", "TextBox")
305:         WITH THIS.txt_4c__ds_moeda
306:             .Top           = 157
307:             .Left          = 320
308:             .Width         = 115
309:             .Height        = 23
310:             .FontName      = "Tahoma"
311:             .FontSize      = 9
312:             .Format        = "K"

*-- Linhas 318 a 342:
318:         ENDWITH
319: 
320:         *-- === EMPRESA top=182/186 ===
321:         THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
322:         WITH THIS.lbl_4c_Lbl_empresa
323:             .Top       = 186
324:             .Left      = 234
325:             .AutoSize  = .T.
326:             .Caption   = "Empresa :"
327:             .FontName  = "Tahoma"
328:             .FontSize  = 8
329:             .BackStyle = 0
330:             .ForeColor = RGB(90, 90, 90)
331:             .Visible   = .T.
332:         ENDWITH
333: 
334:         THIS.AddObject("txt_4c__cd_empresa", "TextBox")
335:         WITH THIS.txt_4c__cd_empresa
336:             .Top           = 182
337:             .Left          = 288
338:             .Width         = 31
339:             .Height        = 23
340:             .FontName      = "Tahoma"
341:             .FontSize      = 9
342:             .Format        = "K!"

*-- Linhas 349 a 358:
349: 
350:         THIS.AddObject("txt_4c__ds_empresa", "TextBox")
351:         WITH THIS.txt_4c__ds_empresa
352:             .Top           = 182
353:             .Left          = 320
354:             .Width         = 290
355:             .Height        = 23
356:             .FontName      = "Tahoma"
357:             .FontSize      = 9
358:             .Format        = "K"

*-- Linhas 364 a 412:
364:         ENDWITH
365: 
366:         *-- === CONTA ZERADA top=207/211 ===
367:         THIS.AddObject("lbl_4c_Label2", "Label")
368:         WITH THIS.lbl_4c_Label2
369:             .Top       = 211
370:             .Left      = 209
371:             .AutoSize  = .T.
372:             .Caption   = "Conta Zerada :"
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8
375:             .BackStyle = 0
376:             .ForeColor = RGB(90, 90, 90)
377:             .Visible   = .T.
378:         ENDWITH
379: 
380:         THIS.AddObject("obj_4c_OptGcontaz", "OptionGroup")
381:         WITH THIS.obj_4c_OptGcontaz
382:             .ButtonCount = 2
383:             .Top         = 207
384:             .Left        = 283
385:             .Width       = 109
386:             .Height      = 25
387:             .BackStyle   = 0
388:             .BorderStyle = 0
389:             .Value       = 1
390: 
391:             .Option1.Caption   = "\<Sim"
392:             .Option1.FontName  = "Tahoma"
393:             .Option1.FontSize  = 8
394:             .Option1.BackStyle = 0
395:             .Option1.ForeColor = RGB(90, 90, 90)
396:             .Option1.Top       = 5
397:             .Option1.Left      = 5
398:             .Option1.Width     = 40
399:             .Option1.Height    = 17
400: 
401:             .Option2.Caption   = "\<N" + CHR(227) + "o"
402:             .Option2.FontName  = "Tahoma"
403:             .Option2.FontSize  = 8
404:             .Option2.BackStyle = 0
405:             .Option2.ForeColor = RGB(90, 90, 90)
406:             .Option2.Top       = 5
407:             .Option2.Left      = 45
408:             .Option2.Width     = 41
409:             .Option2.Height    = 17
410: 
411:             .Visible = .T.
412:         ENDWITH

*-- Linhas 422 a 662:
422:         THIS.ConfigurarPaginaDados()
423: 
424:         *-- === TIPO top=232/236 ===
425:         THIS.AddObject("lbl_4c_Label1", "Label")
426:         WITH THIS.lbl_4c_Label1
427:             .Top       = 236
428:             .Left      = 255
429:             .AutoSize  = .T.
430:             .Caption   = "Tipo :"
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .BackStyle = 0
434:             .ForeColor = RGB(90, 90, 90)
435:             .Visible   = .T.
436:         ENDWITH
437: 
438:         THIS.AddObject("obj_4c_OptGtprel", "OptionGroup")
439:         WITH THIS.obj_4c_OptGtprel
440:             .ButtonCount = 2
441:             .Top         = 232
442:             .Left        = 283
443:             .Width       = 140
444:             .Height      = 27
445:             .BackStyle   = 0
446:             .BorderStyle = 0
447:             .Value       = 1
448: 
449:             .Option1.Caption   = "\<Anal" + CHR(237) + "tico"
450:             .Option1.FontName  = "Tahoma"
451:             .Option1.FontSize  = 8
452:             .Option1.BackStyle = 0
453:             .Option1.ForeColor = RGB(90, 90, 90)
454:             .Option1.Top       = 5
455:             .Option1.Left      = 5
456:             .Option1.Width     = 64
457:             .Option1.Height    = 17
458: 
459:             .Option2.Caption   = "S\<int" + CHR(233) + "tico"
460:             .Option2.FontName  = "Tahoma"
461:             .Option2.FontSize  = 8
462:             .Option2.BackStyle = 0
463:             .Option2.ForeColor = RGB(90, 90, 90)
464:             .Option2.Top       = 5
465:             .Option2.Left      = 70
466:             .Option2.Width     = 65
467:             .Option2.Height    = 17
468: 
469:             .Visible = .T.
470:         ENDWITH
471: 
472:         *-- === COTACAO top=258/262 ===
473:         THIS.AddObject("lbl_4c_Label3", "Label")
474:         WITH THIS.lbl_4c_Label3
475:             .Top       = 262
476:             .Left      = 235
477:             .AutoSize  = .T.
478:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .BackStyle = 0
482:             .ForeColor = RGB(90, 90, 90)
483:             .Visible   = .T.
484:         ENDWITH
485: 
486:         THIS.AddObject("obj_4c_OptCotacao", "OptionGroup")
487:         WITH THIS.obj_4c_OptCotacao
488:             .ButtonCount = 2
489:             .Top         = 258
490:             .Left        = 283
491:             .Width       = 210
492:             .Height      = 27
493:             .BackStyle   = 0
494:             .BorderStyle = 0
495:             .Value       = 1
496: 
497:             .Option1.Caption   = "\<Fechamento"
498:             .Option1.FontName  = "Tahoma"
499:             .Option1.FontSize  = 8
500:             .Option1.BackStyle = 0
501:             .Option1.ForeColor = RGB(90, 90, 90)
502:             .Option1.Top       = 5
503:             .Option1.Left      = 5
504:             .Option1.Width     = 89
505:             .Option1.Height    = 17
506: 
507:             .Option2.Caption   = "\<Movimenta" + CHR(231) + CHR(227) + "o"
508:             .Option2.FontName  = "Tahoma"
509:             .Option2.FontSize  = 8
510:             .Option2.BackStyle = 0
511:             .Option2.ForeColor = RGB(90, 90, 90)
512:             .Option2.Top       = 5
513:             .Option2.Left      = 100
514:             .Option2.Width     = 98
515:             .Option2.Height    = 17
516: 
517:             .Visible = .T.
518:         ENDWITH
519: 
520:         *-- === CLIENTE top=283/287 ===
521:         THIS.AddObject("lbl_4c_Label4", "Label")
522:         WITH THIS.lbl_4c_Label4
523:             .Top       = 287
524:             .Left      = 242
525:             .AutoSize  = .T.
526:             .Caption   = "Cliente :"
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .BackStyle = 0
530:             .ForeColor = RGB(90, 90, 90)
531:             .Visible   = .T.
532:         ENDWITH
533: 
534:         THIS.AddObject("obj_4c_Opt_Cli", "OptionGroup")
535:         WITH THIS.obj_4c_Opt_Cli
536:             .ButtonCount = 2
537:             .Top         = 283
538:             .Left        = 283
539:             .Width       = 140
540:             .Height      = 27
541:             .BackStyle   = 0
542:             .BorderStyle = 0
543:             .Value       = 1
544: 
545:             .Option1.Caption   = "\<Anal" + CHR(237) + "tico"
546:             .Option1.FontName  = "Tahoma"
547:             .Option1.FontSize  = 8
548:             .Option1.BackStyle = 0
549:             .Option1.ForeColor = RGB(90, 90, 90)
550:             .Option1.Top       = 5
551:             .Option1.Left      = 5
552:             .Option1.Width     = 64
553:             .Option1.Height    = 17
554: 
555:             .Option2.Caption   = "S\<int" + CHR(233) + "tico"
556:             .Option2.FontName  = "Tahoma"
557:             .Option2.FontSize  = 8
558:             .Option2.BackStyle = 0
559:             .Option2.ForeColor = RGB(90, 90, 90)
560:             .Option2.Top       = 5
561:             .Option2.Left      = 70
562:             .Option2.Width     = 65
563:             .Option2.Height    = 17
564: 
565:             .Visible = .T.
566:         ENDWITH
567: 
568:         *-- === ANALISE CONSISTENCIA top=305/309 ===
569:         THIS.AddObject("lbl_4c_Label5", "Label")
570:         WITH THIS.lbl_4c_Label5
571:             .Top       = 309
572:             .Left      = 190
573:             .AutoSize  = .T.
574:             .Caption   = "Anal. Consist" + CHR(234) + "ncia:"
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .BackStyle = 0
578:             .ForeColor = RGB(90, 90, 90)
579:             .Visible   = .T.
580:         ENDWITH
581: 
582:         THIS.AddObject("obj_4c_OpAnCst", "OptionGroup")
583:         WITH THIS.obj_4c_OpAnCst
584:             .ButtonCount = 2
585:             .Top         = 305
586:             .Left        = 283
587:             .Width       = 99
588:             .Height      = 26
589:             .BackStyle   = 0
590:             .BorderStyle = 0
591:             .Value       = 2
592: 
593:             .Option1.Caption   = "\<Sim"
594:             .Option1.FontName  = "Tahoma"
595:             .Option1.FontSize  = 8
596:             .Option1.BackStyle = 0
597:             .Option1.ForeColor = RGB(90, 90, 90)
598:             .Option1.Top       = 5
599:             .Option1.Left      = 5
600:             .Option1.Width     = 42
601:             .Option1.Height    = 17
602: 
603:             .Option2.Caption   = "\<N" + CHR(227) + "o"
604:             .Option2.FontName  = "Tahoma"
605:             .Option2.FontSize  = 8
606:             .Option2.BackStyle = 0
607:             .Option2.ForeColor = RGB(90, 90, 90)
608:             .Option2.Top       = 5
609:             .Option2.Left      = 51
610:             .Option2.Width     = 43
611:             .Option2.Height    = 17
612: 
613:             .Visible = .T.
614:         ENDWITH
615: 
616:         *-- === SALDO CONCILIADO top=324/330 ===
617:         THIS.AddObject("lbl_4c_Label6", "Label")
618:         WITH THIS.lbl_4c_Label6
619:             .Top       = 330
620:             .Left      = 176
621:             .AutoSize  = .T.
622:             .Caption   = "Para contas concili" + CHR(225) + "veis, utilizar saldo conciliado?"
623:             .FontName  = "Tahoma"
624:             .FontSize  = 8
625:             .BackStyle = 0
626:             .ForeColor = RGB(90, 90, 90)
627:             .Visible   = .T.
628:         ENDWITH
629: 
630:         THIS.AddObject("obj_4c_Optconcilias", "OptionGroup")
631:         WITH THIS.obj_4c_Optconcilias
632:             .ButtonCount = 2
633:             .Top         = 324
634:             .Left        = 420
635:             .Width       = 99
636:             .Height      = 26
637:             .BackStyle   = 0
638:             .BorderStyle = 0
639:             .Value       = 2
640: 
641:             .Option1.Caption   = "\<Sim"
642:             .Option1.FontName  = "Tahoma"
643:             .Option1.FontSize  = 8
644:             .Option1.BackStyle = 0
645:             .Option1.ForeColor = RGB(90, 90, 90)
646:             .Option1.Top       = 5
647:             .Option1.Left      = 5
648:             .Option1.Width     = 42
649:             .Option1.Height    = 17
650: 
651:             .Option2.Caption   = "\<N" + CHR(227) + "o"
652:             .Option2.FontName  = "Tahoma"
653:             .Option2.FontSize  = 8
654:             .Option2.BackStyle = 0
655:             .Option2.ForeColor = RGB(90, 90, 90)
656:             .Option2.Top       = 5
657:             .Option2.Left      = 51
658:             .Option2.Width     = 43
659:             .Option2.Height    = 17
660: 
661:             .Visible = .T.
662:         ENDWITH


### BO (C:\4c\projeto\app\classes\sigrebalBO.prg):
*==============================================================================
* SIGREBALBO.PRG
* Business Object para Relatorio de Balanco (SIGREBAL)
*
* Herda de: RelatorioBase
* Form associado: Formsigrebal.prg
* Relatorios FRX: SigReBal.frx (principal), SigReAcs.frx (consistencia)
*
* Filtros:
*   - Data final do balanco
*   - Codigo/descricao da moeda de referencia
*   - Codigo/descricao da empresa (vazio = todas)
*   - Opcao conta zerada (1=Sim, 2=Nao)
*   - Opcao tipo relatorio (1=Analitico, 2=Sintetico)
*   - Opcao cliente (1=Analitico, 2=Sintetico)
*   - Opcao analise consistencia (1=Sim, 2=Nao)
*   - Opcao cotacao (1=Fechamento, 2=Movimentacao)
*   - Opcao saldo conciliado (1=Sim, 2=Nao)
*==============================================================================

DEFINE CLASS sigrebalBO AS RelatorioBase

    *-- Filtros do formulario
    this_dDtFinal        = {}
    this_cCdMoeda        = ""
    this_cDsMoeda        = ""
    this_cCdEmpresa      = ""
    this_cDsEmpresa      = ""
    this_nContaz         = 1
    this_nTpRel          = 1
    this_nOptCli         = 1
    this_nOpAnCst        = 2
    this_nOptCotacao     = 1
    this_nOptConcilias   = 2

    *-- Controle interno de relatorio
    this_cArquivoFRX     = ""
    this_cArquivoAcsFRX  = ""
    this_cTitulo         = ""
    this_cCursorDados    = "cursor_4c_BalDados"
    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO de relatorio de balanco
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela      = "SigMvCcr"
            THIS.this_cCampoChave  = ""

            THIS.this_cArquivoFRX    = "SigReBal"
            THIS.this_cArquivoAcsFRX = "SigReAcs"
            THIS.this_cTitulo        = "Balan" + CHR(231) + "o"

            THIS.this_dDtFinal       = DATE()
            THIS.this_cCdMoeda       = ""
            THIS.this_cDsMoeda       = ""
            THIS.this_cCdEmpresa     = ""
            THIS.this_cDsEmpresa     = ""
            THIS.this_nContaz        = 1
            THIS.this_nTpRel         = 1
            THIS.this_nOptCli        = 1
            THIS.this_nOpAnCst       = 2
            THIS.this_nOptCotacao    = 1
            THIS.this_nOptConcilias  = 2

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("cursor_4c_BalPam")
            USE IN cursor_4c_BalPam
        ENDIF
        IF USED("cursor_4c_BalCot")
            USE IN cursor_4c_BalCot
        ENDIF
        IF USED("cursor_4c_BalMoe")
            USE IN cursor_4c_BalMoe
        ENDIF
        IF USED("cursor_4c_BalGcr")
            USE IN cursor_4c_BalGcr
        ENDIF
        IF USED("cursor_4c_BalCss")
            USE IN cursor_4c_BalCss
        ENDIF
        IF USED("cursor_4c_BalCli")
            USE IN cursor_4c_BalCli
        ENDIF
        IF USED("cursor_4c_BalMvcr")
            USE IN cursor_4c_BalMvcr
        ENDIF
        IF USED("cursor_4c_BalTmpMccr")
            USE IN cursor_4c_BalTmpMccr
        ENDIF
        IF USED("cPlConta")
            USE IN cPlConta
        ENDIF
        IF USED("Consulta")
            USE IN Consulta
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarReferencias - Carrega cursores auxiliares do SQL Server
    * Equivalente aos CursorQuery() do Init legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarReferencias()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro
        loc_lSucesso = .T.
        TRY
            *-- SigCdPam - parametros padrao de clientes
            IF USED("cursor_4c_BalPam")
                USE IN cursor_4c_BalPam
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT GrPadClis FROM SigCdPam", "cursor_4c_BalPam")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPam"
                loc_lSucesso = .F.
            ENDIF
            *-- SigCdCot - cotacoes de moedas (indexado por moeda+data)
            IF USED("cursor_4c_BalCot")
                USE IN cursor_4c_BalCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", "cursor_4c_BalCot")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdCot"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            *-- SigCdMoe - moedas cadastradas
            IF USED("cursor_4c_BalMoe")
                USE IN cursor_4c_BalMoe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Cotas FROM SigCdMoe", "cursor_4c_BalMoe")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdMoe"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalMoe
            INDEX ON CMoes TAG CMoes
            *-- SigCdGcr - grupos de conta corrente
            IF USED("cursor_4c_BalGcr")
                USE IN cursor_4c_BalGcr
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs, Classes FROM SigCdGcr", "cursor_4c_BalGcr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdGcr"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalGcr
            INDEX ON Codigos TAG Codigos
            *-- SigCdCss - classes do sistema contabil (balanco)
            IF USED("cursor_4c_BalCss")
                USE IN cursor_4c_BalCss
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Classes, Descrs, Nivels, OpBalancos FROM SigCdCss", "cursor_4c_BalCss")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdCss"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalCss
            INDEX ON Classes TAG Classes
            *-- SigCdCli - clientes / contas correntes
            IF USED("cursor_4c_BalCli")
                USE IN cursor_4c_BalCli
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT IClis, Grupos, RClis, Concilias FROM SigCdCli", "cursor_4c_BalCli")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdCli"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalCli
            INDEX ON Grupos + IClis TAG GrCodigo
            INDEX ON IClis TAG IClis
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.CarregarReferencias")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data informada
    * Equivalente a fCarregarCambio() do sistema legado
    * Busca a cotacao mais recente <= par_dData para a moeda informada
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda
        loc_nCotacao = 1
        loc_cMoeda   = ALLTRIM(par_cMoeda)
        IF USED("cursor_4c_BalCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(par_dData)
            SELECT cursor_4c_BalCot
            SET ORDER TO CMoeData
            IF SEEK(loc_cMoeda + DTOS(par_dData))
                loc_nCotacao = cursor_4c_BalCot.Valos
            ELSE
                SKIP -1
                IF !BOF() AND ALLTRIM(cursor_4c_BalCot.CMoes) = loc_cMoeda AND ;
                   TTOD(cursor_4c_BalCot.Datas) <= par_dData
                    loc_nCotacao = cursor_4c_BalCot.Valos
                ENDIF
            ENDIF
        ENDIF
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa movimentos e monta cPlConta para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado (SIGREBAL)
    * Cria cursores cPlConta (SigReBal.frx) e Consulta (SigReAcs.frx)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_ldDtSaldo, loc_lcCdEmp, loc_lcDsEmp, loc_lcCdMoeda, loc_lcDsMoeda
        LOCAL loc_lnContaz, loc_lnOptRel, loc_lnOptCli, loc_lnOpAnCst
        LOCAL loc_lnOptCot, loc_lnOptConc
        LOCAL loc_lcEmpresa, loc_lcTitulo1s, loc_lcTitulo2s
        LOCAL loc_lnDecimals, loc_lcFixed, loc_lcEscape
        LOCAL loc_lnCot1, loc_lnCot2, loc_lnValors, loc_lnSaldos
        LOCAL loc_lnNivels, loc_lnConta1, loc_lcClasse2
        LOCAL loc_cContas, loc_cDcontas, loc_cOrds, loc_cPs, loc_cIps
        LOCAL loc_lcGrupos, loc_lcContas, loc_lcNopers
        LOCAL loc_nResult, loc_lcQuery, loc_lcDtSQL
        LOCAL ARRAY loc_laOrd(5), loc_laStrArea(5)
        LOCAL ARRAY loc_aFlds(1)

        loc_lSucesso   = .F.
        loc_lcEscape   = ""
        loc_lnDecimals = 0
        loc_lcFixed    = ""

        TRY
            IF !THIS.CarregarReferencias()
                THIS.this_cMensagemErro = "Erro ao carregar refer" + CHR(234) + "ncias"
            ELSE

            loc_ldDtSaldo  = THIS.this_dDtFinal
            loc_lcCdEmp    = ALLTRIM(THIS.this_cCdEmpresa)
            loc_lcDsEmp    = ALLTRIM(THIS.this_cDsEmpresa)
            loc_lcCdMoeda  = ALLTRIM(THIS.this_cCdMoeda)
            loc_lcDsMoeda  = ALLTRIM(THIS.this_cDsMoeda)
            loc_lnContaz   = THIS.this_nContaz
            loc_lnOptRel   = THIS.this_nTpRel
            loc_lnOptCli   = THIS.this_nOptCli
            loc_lnOpAnCst  = THIS.this_nOpAnCst
            loc_lnOptCot   = THIS.this_nOptCotacao
            loc_lnOptConc  = THIS.this_nOptConcilias

            loc_lcEmpresa  = go_4c_Sistema.cEmpresa
            loc_lcTitulo1s = "Balan" + CHR(231) + "o em " + ;
                             DTOC(loc_ldDtSaldo) + " - " + loc_lcDsMoeda
            loc_lcTitulo2s = IIF(!EMPTY(loc_lcCdEmp), ;
                             ALLTRIM(loc_lcCdEmp) + " - " + ALLTRIM(loc_lcDsEmp), ;
                             "TODAS AS EMPRESAS")

            loc_lcEscape   = SET("Escape")
            loc_lnDecimals = VAL(SET("Decimals"))
            loc_lcFixed    = SET("Fixed")
            SET ESCAPE OFF
            SET DECIMALS TO 2
            SET FIXED ON

            *-- Criar cursor de resultado (nome exato exigido por SigReBal.frx)
            IF USED("cPlConta")
                USE IN cPlConta
            ENDIF
            CREATE CURSOR cPlConta (cEmpresas C(40), cTitulo1s C(80), cTitulo2s C(80), ;
                                    cContas C(10), cDContas C(50), nSaldos N(16,2), ;
                                    cOrds C(50), cPs C(1), cIps C(1))
            INDEX ON cOrds TAG cOrds

            *-- Montar string de data limite para o WHERE SQL (fim do dia)
            loc_lcDtSQL = STR(YEAR(loc_ldDtSaldo), 4) + "-" + ;
                          RIGHT("0" + LTRIM(STR(MONTH(loc_ldDtSaldo))), 2) + "-" + ;
                          RIGHT("0" + LTRIM(STR(DAY(loc_ldDtSaldo))), 2) + " 23:59:59"

            *-- Carregar movimentos de conta corrente ate a data saldo
            IF USED("cursor_4c_BalMvcr")
                USE IN cursor_4c_BalMvcr
            ENDIF
            loc_lcQuery = "SELECT Emps, Datas, Opers, Grupos, Contas, Valors, Moedas, " + ;
                          "SValors, SMoedas, Cotacaos, Nopers, Saldos, cIdChaves, Hists, " + ;
                          "Hist2s, Concs, sOpers, sgrupos, scontas, scotacaos, SaldoCs, EmpCcs " + ;
                          "FROM SigMvCcr " + ;
                          "WHERE Datas <= " + EscaparSQL(loc_lcDtSQL) + " OR Datas IS NULL " + ;
                          "ORDER BY Datas, Opers, Grupos, Contas, Valors, " + ;
                          "Moedas, SValors, SMoedas, Cotacaos, Nopers, Saldos, cIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_BalMvcr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigMvCcr"
                SET ESCAPE &loc_lcEscape.
                SET DECIMALS TO loc_lnDecimals
                SET FIXED &loc_lcFixed.
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_BalMvcr
            INDEX ON Datas TAG Datas

            *-- Criar cursor temporario de movimentos (mesma estrutura de cursor_4c_BalMvcr)
            IF USED("cursor_4c_BalTmpMccr")
                USE IN cursor_4c_BalTmpMccr
            ENDIF
            AFIELDS(loc_aFlds, "cursor_4c_BalMvcr")
            CREATE CURSOR cursor_4c_BalTmpMccr FROM ARRAY loc_aFlds
            SELECT cursor_4c_BalTmpMccr
            INDEX ON Nopers TAG Nopers

            *-- Cotacao base da moeda de referencia na data do balanco
            loc_lnCot2 = THIS.CarregarCambio(loc_lcCdMoeda, loc_ldDtSaldo)

            *-- === LOOP PRINCIPAL: processar cada movimento ===
            SELECT cursor_4c_BalMvcr
            SET ORDER TO Datas
            GO TOP
            DO WHILE !EOF("cursor_4c_BalMvcr") AND ;
                     (ISNULL(cursor_4c_BalMvcr.Datas) OR ;
                      TTOD(cursor_4c_BalMvcr.Datas) <= loc_ldDtSaldo)

                *-- Filtrar por empresa se informada (checar EmpCcs primeiro, depois Emps)
                IF !EMPTY(loc_lcCdEmp)
                    IF IIF(!EMPTY(ALLTRIM(cursor_4c_BalMvcr.EmpCcs)), ;
                           ALLTRIM(cursor_4c_BalMvcr.EmpCcs) <> loc_lcCdEmp, ;
                           ALLTRIM(cursor_4c_BalMvcr.Emps) <> loc_lcCdEmp)
                        SELECT cursor_4c_BalMvcr
                        SKIP
                        LOOP
                    ENDIF
                ENDIF

                loc_lcGrupos = ALLTRIM(cursor_4c_BalMvcr.Grupos)
                loc_lcContas = ALLTRIM(cursor_4c_BalMvcr.Contas)

                *-- Calcular cotacao de conversao para a moeda de referencia
                IF (loc_lnOptCot = 1)
                    loc_lnCot1 = THIS.CarregarCambio(cursor_4c_BalMvcr.Moedas, loc_ldDtSaldo)
                ELSE
                    IF ALLTRIM(cursor_4c_BalMvcr.Moedas) <> ALLTRIM(cursor_4c_BalMvcr.SMoedas)
                        loc_lnCot1 = cursor_4c_BalMvcr.Cotacaos
                    ELSE
                        loc_lnCot1 = THIS.CarregarCambio(cursor_4c_BalMvcr.Moedas, ;
                                         TTOD(cursor_4c_BalMvcr.Datas))
                    ENDIF
                    loc_lnCot2 = THIS.CarregarCambio(loc_lcCdMoeda, ;
                                     TTOD(cursor_4c_BalMvcr.Datas))
                ENDIF

                *-- Determinar valor convertido com base em opcao de saldo conciliado
                SELECT cursor_4c_BalCli
                SET ORDER TO IClis
                SEEK loc_lcContas
                IF (loc_lnOptConc = 2) OR cursor_4c_BalCli.Concilias <> 1
                    IF ALLTRIM(cursor_4c_BalMvcr.SMoedas) = loc_lcCdMoeda AND loc_lnOptCot = 2
                        loc_lnValors = cursor_4c_BalMvcr.SValors
                    ELSE
                        loc_lnValors = (cursor_4c_BalMvcr.Valors * loc_lnCot1 / loc_lnCot2)
                    ENDIF
                ELSE
                    IF !cursor_4c_BalMvcr.Concs
                        SELECT cursor_4c_BalMvcr
                        SKIP
                        LOOP
                    ENDIF
                    IF ALLTRIM(cursor_4c_BalMvcr.SMoedas) = loc_lcCdMoeda AND loc_lnOptCot = 2
                        loc_lnValors = cursor_4c_BalMvcr.SValors
                    ELSE
                        loc_lnValors = (cursor_4c_BalMvcr.Valors * loc_lnCot1 / loc_lnCot2)
                    ENDIF
                ENDIF

                loc_lnSaldos = loc_lnValors * IIF(ALLTRIM(cursor_4c_BalMvcr.Opers) = "D", 1, -1)

                *-- Verificar se conta/grupo/classe pertencem ao balanco
                SELECT cursor_4c_BalCli
                SET ORDER TO IClis
                SEEK loc_lcContas
                IF ((loc_lnContaz = 1 OR !EMPTY(loc_lnSaldos)) AND ;
                    !EMPTY(loc_lcContas) AND FOUND() AND ;
                    !EMPTY(loc_lcGrupos))

                    SELECT cursor_4c_BalGcr
                    SET ORDER TO Codigos
                    SEEK loc_lcGrupos
                    IF FOUND() AND !EMPTY(ALLTRIM(cursor_4c_BalGcr.Classes))
                        SELECT cursor_4c_BalCss
                        SET ORDER TO Classes
                        SEEK PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 1)
                        IF FOUND() AND cursor_4c_BalCss.OpBalancos = 1
                            SELECT cursor_4c_BalCss
                            SEEK cursor_4c_BalGcr.Classes
                            IF FOUND()
                                loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 10)
                                loc_lnNivels  = cursor_4c_BalCss.Nivels
                                FOR loc_lnConta1 = 1 TO loc_lnNivels
                                    loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, ;
                                        VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                    loc_laStrArea(loc_lnConta1) = "cursor_4c_BalCss"
                                ENDFOR
                                loc_laOrd(loc_lnNivels + 1)     = PADR(ALLTRIM(cursor_4c_BalGcr.Codigos), 10)
                                loc_laOrd(loc_lnNivels + 2)     = PADR(ALLTRIM(cursor_4c_BalCli.IClis), 10)
                                loc_laStrArea(loc_lnNivels + 1) = "cursor_4c_BalGcr"
                                loc_laStrArea(loc_lnNivels + 2) = "cursor_4c_BalCli"
                                loc_cOrds = ""
                                FOR loc_lnConta1 = 1 TO (loc_lnNivels + 2)
                                    loc_cContas  = loc_laOrd(loc_lnConta1)
                                    IF (loc_lnConta1 <= loc_lnNivels)
                                        SELECT (loc_laStrArea(loc_lnConta1))
                                        SET ORDER TO Classes
                                        SEEK loc_cContas
                                    ENDIF
                                    loc_cOrds    = (loc_cOrds + loc_laOrd(loc_lnConta1))
                                    loc_cDcontas = EVALUATE(loc_laStrArea(loc_lnConta1) + ;
                                        IIF(loc_lnConta1 = (loc_lnNivels + 2), ".RClis", ".Descrs"))
                                    loc_cPs  = STR(IIF(loc_lnConta1 <= loc_lnNivels, ;
                                        loc_lnConta1, IIF(loc_lnConta1 = (loc_lnNivels + 1), 4, 5)), 1)
                                    loc_cIps = STR(loc_lnConta1, 1)
                                    SELECT cursor_4c_BalPam
                                    GO TOP
                                    IF ((cursor_4c_BalCli.Grupos = cursor_4c_BalPam.GrPadClis) AND ;
                                        (loc_lnOptCli = 1 OR loc_cPs <> "5")) OR ;
                                       ((loc_lnOptRel = 1 OR loc_cPs <> "5") AND ;
                                        (cursor_4c_BalCli.Grupos <> cursor_4c_BalPam.GrPadClis))
                                        SELECT cPlConta
                                        SET ORDER TO cOrds
                                        IF !SEEK(PADR(loc_cOrds, 50), "cPlConta", "cOrds")
                                            INSERT INTO cPlConta ;
                                                (cEmpresas, cTitulo1s, cTitulo2s, cContas, ;
                                                 cDContas, nSaldos, cOrds, cPs, cIps) ;
                                                VALUES (loc_lcEmpresa, loc_lcTitulo1s, ;
                                                loc_lcTitulo2s, loc_cContas, loc_cDcontas, ;
                                                0, PADR(loc_cOrds, 50), loc_cPs, loc_cIps)
                                            SELECT cPlConta
                                            SET ORDER TO cOrds
                                            SEEK PADR(loc_cOrds, 50)
                                        ENDIF
                                        REPLACE nSaldos WITH nSaldos + loc_lnSaldos IN cPlConta
                                        IF loc_lnConta1 = loc_lnNivels + 2 AND ;
                                           loc_lnContaz = 2 AND EMPTY(cPlConta.nSaldos)
                                            DELETE IN cPlConta
                                        ENDIF
                                    ENDIF
                                ENDFOR
                                *-- Registrar no cursor de analise de consistencia
                                loc_lcNopers = ALLTRIM(cursor_4c_BalMvcr.Nopers)
                                SELECT cursor_4c_BalTmpMccr
                                SET ORDER TO Nopers
                                IF !SEEK(loc_lcNopers)
                                    INSERT INTO cursor_4c_BalTmpMccr ;
                                        (Emps, Datas, Opers, Grupos, Contas, Valors, Moedas, ;
                                         SValors, SMoedas, Cotacaos, Nopers, Saldos, cIdChaves, ;
                                         Hists, Hist2s, Concs, sOpers, sgrupos, scontas, ;
                                         scotacaos, SaldoCs, EmpCcs) ;
                                        VALUES (cursor_4c_BalMvcr.Emps, cursor_4c_BalMvcr.Datas, ;
                                        cursor_4c_BalMvcr.Opers, cursor_4c_BalMvcr.Grupos, ;
                                        cursor_4c_BalMvcr.Contas, cursor_4c_BalMvcr.Valors, ;
                                        cursor_4c_BalMvcr.Moedas, cursor_4c_BalMvcr.SValors, ;
                                        cursor_4c_BalMvcr.SMoedas, cursor_4c_BalMvcr.Cotacaos, ;
                                        cursor_4c_BalMvcr.Nopers, 0, cursor_4c_BalMvcr.cIdChaves, ;
                                        cursor_4c_BalMvcr.Hists, cursor_4c_BalMvcr.Hist2s, ;
                                        cursor_4c_BalMvcr.Concs, cursor_4c_BalMvcr.sOpers, ;
                                        cursor_4c_BalMvcr.sgrupos, cursor_4c_BalMvcr.scontas, ;
                                        cursor_4c_BalMvcr.scotacaos, cursor_4c_BalMvcr.SaldoCs, ;
                                        cursor_4c_BalMvcr.EmpCcs)
                                ENDIF
                                REPLACE Saldos WITH Saldos + loc_lnSaldos IN cursor_4c_BalTmpMccr
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                SELECT cursor_4c_BalMvcr
                SKIP
            ENDDO

            *-- === LOOP ZERO-BALANCE: incluir contas cadastradas com saldo zero ===
            IF (loc_lnContaz = 1)
                *-- Varrer clientes para incluir contas zeradas
                SELECT cursor_4c_BalCli
                SET ORDER TO GrCodigo
                SCAN
                    IF !EMPTY(ALLTRIM(cursor_4c_BalCli.IClis)) AND ;
                       !EMPTY(ALLTRIM(cursor_4c_BalCli.Grupos))
                        SELECT cursor_4c_BalGcr
                        SET ORDER TO Codigos
                        SEEK ALLTRIM(cursor_4c_BalCli.Grupos)
                        IF FOUND() AND !EMPTY(ALLTRIM(cursor_4c_BalGcr.Classes))
                            SELECT cursor_4c_BalCss
                            SET ORDER TO Classes
                            SEEK PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 1)
                            IF FOUND() AND cursor_4c_BalCss.OpBalancos = 1
                                SELECT cursor_4c_BalCss
                                SEEK cursor_4c_BalGcr.Classes
                                IF FOUND()
                                    loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 10)
                                    loc_lnNivels  = cursor_4c_BalCss.Nivels
                                    FOR loc_lnConta1 = 1 TO loc_lnNivels
                                        loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, ;
                                            VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                        loc_laStrArea(loc_lnConta1) = "cursor_4c_BalCss"
                                    ENDFOR
                                    loc_laOrd(loc_lnNivels + 1)     = PADR(ALLTRIM(cursor_4c_BalGcr.Codigos), 10)
                                    loc_laOrd(loc_lnNivels + 2)     = PADR(ALLTRIM(cursor_4c_BalCli.IClis), 10)
                                    loc_laStrArea(loc_lnNivels + 1) = "cursor_4c_BalGcr"
                                    loc_laStrArea(loc_lnNivels + 2) = "cursor_4c_BalCli"
                                    loc_cOrds = ""
                                    FOR loc_lnConta1 = 1 TO (loc_lnNivels + 2)
                                        loc_cContas  = loc_laOrd(loc_lnConta1)
                                        IF (loc_lnConta1 <= loc_lnNivels)
                                            SELECT (loc_laStrArea(loc_lnConta1))
                                            SET ORDER TO Classes
                                            SEEK loc_cContas
                                        ENDIF
                                        loc_cOrds    = (loc_cOrds + loc_laOrd(loc_lnConta1))
                                        loc_cDcontas = EVALUATE(loc_laStrArea(loc_lnConta1) + ;
                                            IIF(loc_lnConta1 = (loc_lnNivels + 2), ".RClis", ".Descrs"))
                                        loc_cPs  = STR(IIF(loc_lnConta1 <= loc_lnNivels, ;
                                            loc_lnConta1, IIF(loc_lnConta1 = (loc_lnNivels + 1), 4, 5)), 1)
                                        loc_cIps = STR(loc_lnConta1, 1)
                                        SELECT cursor_4c_BalPam
                                        GO TOP
                                        IF ((cursor_4c_BalCli.Grupos = cursor_4c_BalPam.GrPadClis) AND ;
                                            (loc_lnOptCli = 1 OR loc_cPs <> "5")) OR ;
                                           ((loc_lnOptRel = 1 OR loc_cPs <> "5") AND ;
                                            (cursor_4c_BalCli.Grupos <> cursor_4c_BalPam.GrPadClis))
                                            SELECT cPlConta
                                            SET ORDER TO cOrds
                                            IF !SEEK(PADR(loc_cOrds, 50), "cPlConta", "cOrds")
                                                INSERT INTO cPlConta ;
                                                    (cEmpresas, cTitulo1s, cTitulo2s, cContas, ;
                                                     cDContas, nSaldos, cOrds, cPs, cIps) ;
                                                    VALUES (loc_lcEmpresa, loc_lcTitulo1s, ;
                                                    loc_lcTitulo2s, loc_cContas, loc_cDcontas, ;
                                                    0, PADR(loc_cOrds, 50), loc_cPs, loc_cIps)
                                            ENDIF
                                        ENDIF
                                        SELECT cursor_4c_BalCli
                                    ENDFOR
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
                *-- Varrer grupos para incluir entradas de grupos/classes zerados
                SELECT cursor_4c_BalGcr
                SET ORDER TO Codigos
                SCAN
                    IF !EMPTY(ALLTRIM(cursor_4c_BalGcr.Codigos)) AND ;
                       !EMPTY(ALLTRIM(cursor_4c_BalGcr.Classes))
                        SELECT cursor_4c_BalCss
                        SET ORDER TO Classes
                        SEEK PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 1)
                        IF FOUND() AND cursor_4c_BalCss.OpBalancos = 1
                            SELECT cursor_4c_BalCss
                            SEEK cursor_4c_BalGcr.Classes
                            IF FOUND()
                                loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_BalGcr.Classes), 10)
                                loc_lnNivels  = cursor_4c_BalCss.Nivels
                                FOR loc_lnConta1 = 1 TO loc_lnNivels
                                    loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, ;
                                        VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                    loc_laStrArea(loc_lnConta1) = "cursor_4c_BalCss"
                                ENDFOR
                                loc_laOrd(loc_lnNivels + 1)     = PADR(ALLTRIM(cursor_4c_BalGcr.Codigos), 10)
                                loc_laStrArea(loc_lnNivels + 1) = "cursor_4c_BalGcr"
                                loc_cOrds = ""
                                FOR loc_lnConta1 = 1 TO (loc_lnNivels + 1)
                                    loc_cContas  = loc_laOrd(loc_lnConta1)
                                    IF (loc_lnConta1 <= loc_lnNivels)
                                        SELECT (loc_laStrArea(loc_lnConta1))
                                        SET ORDER TO Classes
                                        SEEK loc_cContas
                                    ENDIF
                                    loc_cOrds    = (loc_cOrds + loc_laOrd(loc_lnConta1))
                                    loc_cDcontas = EVALUATE(loc_laStrArea(loc_lnConta1) + ;
                                        IIF(loc_lnConta1 = (loc_lnNivels + 2), ".RClis", ".Descrs"))
                                    loc_cPs  = STR(IIF(loc_lnConta1 <= loc_lnNivels, ;
                                        loc_lnConta1, IIF(loc_lnConta1 = (loc_lnNivels + 1), 4, 5)), 1)
                                    loc_cIps = STR(loc_lnConta1, 1)
                                    IF (loc_lnOptRel = 1 OR loc_cPs <> "5")
                                        SELECT cPlConta
                                        SET ORDER TO cOrds
                                        IF !SEEK(PADR(loc_cOrds, 50), "cPlConta", "cOrds")
                                            INSERT INTO cPlConta ;
                                                (cEmpresas, cTitulo1s, cTitulo2s, cContas, ;
                                                 cDContas, nSaldos, cOrds, cPs, cIps) ;
                                                VALUES (loc_lcEmpresa, loc_lcTitulo1s, ;
                                                loc_lcTitulo2s, loc_cContas, loc_cDcontas, ;
                                                0, PADR(loc_cOrds, 50), loc_cPs, loc_cIps)
                                        ENDIF
                                    ENDIF
                                    SELECT cursor_4c_BalGcr
                                ENDFOR
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Criar cursor Consulta (nome exato exigido por SigReAcs.frx)
            IF USED("Consulta")
                USE IN Consulta
            ENDIF
            SELECT * FROM cursor_4c_BalTmpMccr ;
                WHERE ABS(Saldos) > 1 ;
                INTO CURSOR Consulta READWRITE

            *-- Fechar cursor de movimentos (dados ja processados)
            IF USED("cursor_4c_BalMvcr")
                USE IN cursor_4c_BalMvcr
            ENDIF

            *-- Ordenar cPlConta para apresentacao correta no relatorio
            SELECT cPlConta
            SET ORDER TO cOrds ASCENDING
            GO TOP

            SET ESCAPE &loc_lcEscape.
            SET DECIMALS TO loc_lnDecimals
            SET FIXED &loc_lcFixed.

            loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.PrepararDados")
            IF !EMPTY(loc_lcEscape)
                SET ESCAPE &loc_lcEscape.
            ENDIF
            IF loc_lnDecimals > 0
                SET DECIMALS TO loc_lnDecimals
            ENDIF
            IF !EMPTY(loc_lcFixed)
                SET FIXED &loc_lcFixed.
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Preview do relatorio de balanco na tela
    * Equivalente ao PROCEDURE visualizacao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_lcFrxPath
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Balan" + CHR(231) + "o")
            ELSE
                loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoFRX
                REPORT FORM (loc_lcFrxPath) PREVIEW NOCONSOLE
                IF THIS.this_nOpAnCst = 1 AND USED("Consulta")
                    SELECT Consulta
                    GO TOP
                    IF RECCOUNT() > 0
                        loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoAcsFRX
                        REPORT FORM (loc_lcFrxPath) PREVIEW NOCONSOLE
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto na impressora padrao
    * Equivalente ao PROCEDURE documento do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_lcFrxPath
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Balan" + CHR(231) + "o")
            ELSE
                loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoFRX
                REPORT FORM (loc_lcFrxPath) TO PRINTER NOCONSOLE
                IF THIS.this_nOpAnCst = 1 AND USED("Consulta")
                    SELECT Consulta
                    GO TOP
                    IF RECCOUNT() > 0
                        loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoAcsFRX
                        REPORT FORM (loc_lcFrxPath) TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do BO a partir de um cursor
    * Em BOs REPORT este metodo nao aplica operacao CRUD: os filtros sao
    * preenchidos via FormParaRelatorio() chamando atribuicoes diretas.
    * Mantemos a assinatura para compatibilidade com o contrato de BOs.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            *-- Mapeamento opcional caso o cursor possua os campos de filtro
            IF TYPE(par_cAliasCursor + ".DtFinal") = "D"
                THIS.this_dDtFinal = NVL(EVALUATE(par_cAliasCursor + ".DtFinal"), DATE())
            ENDIF
            IF TYPE(par_cAliasCursor + ".CMoes") = "C"
                THIS.this_cCdMoeda = NVL(EVALUATE(par_cAliasCursor + ".CMoes"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DMoes") = "C"
                THIS.this_cDsMoeda = NVL(EVALUATE(par_cAliasCursor + ".DMoes"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Emps") = "C"
                THIS.this_cCdEmpresa = NVL(EVALUATE(par_cAliasCursor + ".Emps"), "")
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BOs REPORT nao realizam INSERT em tabelas
    * Operacao nao se aplica: o relatorio apenas LE dados via PrepararDados().
    * Retorna .F. e registra mensagem para qualquer chamada acidental.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o de inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o se aplica a relat" + CHR(243) + "rios."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BOs REPORT nao realizam UPDATE em tabelas
    * Operacao nao se aplica: o relatorio apenas LE dados via PrepararDados().
    * Retorna .F. e registra mensagem para qualquer chamada acidental.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o de atualiza" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o se aplica a relat" + CHR(243) + "rios."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - REPORT BO nao possui registro corrente unico
    * Retorna chave composta dos filtros (data+moeda+empresa) para auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra emissao de relatorio em LogAuditoria
    * Chamado por Visualizar/Imprimir/ImprimirComPrompt apos emissao bem-sucedida.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "")
            loc_cSQL = "INSERT INTO LogAuditoria (cTabela, cOperacao, cChave, cUsuario, dDataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigMvCcr") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Imprime relatorio com dialogo de selecao de impressora
    * Equivalente ao PROCEDURE impressao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_oErro, loc_lcFrxPath
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Balan" + CHR(231) + "o")
            ELSE
                loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoFRX
                REPORT FORM (loc_lcFrxPath) TO PRINTER PROMPT NOCONSOLE
                IF THIS.this_nOpAnCst = 1 AND USED("Consulta")
                    SELECT Consulta
                    GO TOP
                    IF RECCOUNT() > 0
                        loc_lcFrxPath = ADDBS(gc_4c_CaminhoReports) + THIS.this_cArquivoAcsFRX
                        REPORT FORM (loc_lcFrxPath) TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrebalBO.ImprimirComPrompt")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

