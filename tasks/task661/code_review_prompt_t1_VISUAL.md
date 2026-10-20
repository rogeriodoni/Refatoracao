# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Transacao' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-HEADER] Header Caption 'No.Autorização' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Hora' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cupom' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'No.Autorização' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Hora' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cupom' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Rede, N.Autorizacao, Valor, Data, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigproef.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1233 linhas total):

*-- Linhas 15 a 23:
15: * BINDEVENTs e logica de carga entram nas fases 7-8.
16: *
17: * FASE 4/8 (Grid e Botoes de Acao): adiciona a grade de transacoes
18: * (grd_4c_Dados) e os botoes de acao sobre a linha selecionada (cmd_4c_
19: * Gerencial/Ultimo/Reimprime/Cancela/Ok). SIGPROEF e OPERACIONAL, nao CRUD -
20: * nao ha Incluir/Alterar/Excluir nem AlternarPagina: os 5 botoes replicam
21: * literalmente os do legado. O Grid recebe ColumnCount e as 7 colunas (com
22: * a legenda final aplicada em runtime pelo Sqltrans do legado, que eleva o
23: * esqueleto de 6 colunas do SCX para 7). Entra tambem a carga de dados da

*-- Linhas 32 a 46:
32: *
33: * FASE 5/8 (Campos Principais - Parte 1): cria o container de filtro de
34: * periodo (cnt_4c_Periodo, Cnt_periodo do legado) com a primeira metade dos
35: * campos - titulo "Periodo" (lbl_4c_Periodo) e o campo de data inicial
36: * (txt_4c_DataInicial). O separador "a" (Say2) e o campo de data final
37: * entram na Fase 6; os BINDEVENTs de LostFocus/Valid desses campos
38: * continuam nas Fases 7-8, junto com os demais handlers do form.
39: *
40: * FASE 6/8 (Campos Restantes e Lookups): completa cnt_4c_Periodo com o
41: * separador "a" (Say2 -> lbl_4c_Separador) e o segundo campo de data
42: * (Dt_final -> txt_4c_DataFinal), e liga os dois campos aos seus handlers
43: * de validacao, transcritos do Valid/LostFocus do legado:
44: *   - ValidarDataInicial  (Dt_inicial.Valid + Dt_inicial.LostFocus)
45: *   - ValidarDataFinal    (Dt_final.Valid   + Dt_final.LostFocus)
46: *   - AtualizarPeriodoNoBO (os dois TextBox sao a fonte do filtro: gravam

*-- Linhas 160 a 168:
160:     * Init - define Caption com CHR() antes de delegar ao FormBase
161:     *--------------------------------------------------------------------------
162:     PROCEDURE Init()
163:         THIS.Caption = "Sele" + CHR(231) + CHR(227) + "o da Transa" + CHR(231) + CHR(227) + "o"
164: 
165:         *-- WindowType=1/ShowWindow=1 na classe causaria TIMEOUT em VFP9 -T
166:         *-- (top-level window modal bloqueante). Classe definida com
167:         *-- WindowType=0/ShowWindow=0; producao restaura o modal aqui (regra #29).
168:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;

*-- Linhas 213 a 221:
213:                     *-- cOperacao), usados pelos botoes de acao (Fase 7/8).
214:                     THIS.this_oBusinessObject.CarregarParametrosSistema()
215: 
216:                     THIS.cnt_4c_Transa.cmd_4c_Cancela.Visible = ;
217:                         THIS.this_oBusinessObject.this_lPermiteCancelar
218: 
219:                     IF !THIS.this_oBusinessObject.CarregarDadosImpressoraFiscal()
220:                         MsgAviso("Impressora Fiscal Inv" + CHR(225) + "lida para esta Loja !!", "Erro")
221:                     ENDIF

*-- Linhas 262 a 309:
262:         THIS.AddObject("cnt_4c_Transa", "Container")
263:         loc_oCnt = THIS.cnt_4c_Transa
264:         WITH loc_oCnt
265:             .Top           = 3
266:             .Left          = 1
267:             .Height        = 333
268:             .Width         = 581
269:             .SpecialEffect = 0
270:             .BackColor     = RGB(255,255,255)
271:             .BackStyle     = 1
272:             .BorderWidth   = 0
273:         ENDWITH
274: 
275:         *-- Say1: titulo "Transacoes Efetuadas" - classe say (AutoSize/esquerda)
276:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
277:         WITH loc_oCnt.lbl_4c_Titulo
278:             .AutoSize   = .T.
279:             .Left       = 191
280:             .Top        = 9
281:             .FontBold   = .T.
282:             .FontItalic = .T.
283:             .FontSize   = 12
284:             .BackStyle  = 0
285:             .ForeColor  = RGB(0,0,160)
286:             .Caption    = "Transa" + CHR(231) + CHR(245) + "es Efetuadas"
287:         ENDWITH
288: 
289:         *-- Line1: linha divisoria azul entre o titulo e a grade
290:         loc_oCnt.AddObject("lin_4c_Line1", "Line")
291:         WITH loc_oCnt.lin_4c_Line1
292:             .Top         = 29
293:             .Left        = 7
294:             .Height      = 0
295:             .Width       = 571
296:             .BorderWidth = 4
297:             .BorderColor = RGB(0,0,160)
298:         ENDWITH
299: 
300:         *-- Shape1: moldura ao redor do bloco de periodo/botoes no rodape
301:         loc_oCnt.AddObject("shp_4c_Shape1", "Shape")
302:         WITH loc_oCnt.shp_4c_Shape1
303:             .Top           = 277
304:             .Left          = 245
305:             .Height        = 53
306:             .Width         = 331
307:             .SpecialEffect = 0
308:             .BackStyle     = 0
309:         ENDWITH

*-- Linhas 327 a 336:
327:         THIS.cnt_4c_Transa.AddObject("grd_4c_Dados", "Grid")
328:         loc_oGrd = THIS.cnt_4c_Transa.grd_4c_Dados
329:         WITH loc_oGrd
330:             .Top           = 41
331:             .Left          = 8
332:             .Height        = 230
333:             .Width         = 569
334:             .ColumnCount   = 7
335:             .ScrollBars    = 2
336:             .FontSize      = 8

*-- Linhas 348 a 430:
348:             .Movable           = .F.
349:             .Resizable         = .F.
350:             .ReadOnly          = .T.
351:             .Header1.Caption   = "Rede"
352:             .Header1.Alignment = 2
353:             .Header1.FontSize  = 8
354:             .Text1.FontSize    = 8
355:         ENDWITH
356: 
357:         WITH loc_oGrd.Column2
358:             .Width             = 78
359:             .FontSize          = 8
360:             .Movable           = .F.
361:             .Resizable         = .F.
362:             .ReadOnly          = .T.
363:             .Header1.Caption   = "No.Autoriza" + CHR(231) + CHR(227) + "o"
364:             .Header1.Alignment = 2
365:             .Header1.FontSize  = 8
366:             .Text1.FontSize    = 8
367:         ENDWITH
368: 
369:         WITH loc_oGrd.Column3
370:             .Width             = 75
371:             .FontSize          = 8
372:             .Movable           = .F.
373:             .Resizable         = .F.
374:             .ReadOnly          = .T.
375:             .Header1.Caption   = "Valor"
376:             .Header1.Alignment = 2
377:             .Header1.FontSize  = 8
378:             .Text1.FontSize    = 8
379:         ENDWITH
380: 
381:         WITH loc_oGrd.Column4
382:             .Width             = 65
383:             .FontSize          = 8
384:             .Movable           = .F.
385:             .Resizable         = .F.
386:             .ReadOnly          = .T.
387:             .Alignment         = 2
388:             .Header1.Caption   = "Data"
389:             .Header1.Alignment = 2
390:             .Header1.FontSize  = 8
391:             .Text1.FontSize    = 8
392:             .Text1.Alignment   = 2
393:         ENDWITH
394: 
395:         WITH loc_oGrd.Column5
396:             .Width             = 55
397:             .FontSize          = 8
398:             .Movable           = .F.
399:             .Resizable         = .F.
400:             .ReadOnly          = .T.
401:             .Header1.Caption   = "Hora"
402:             .Header1.Alignment = 2
403:             .Header1.FontSize  = 8
404:             .Text1.FontSize    = 8
405:         ENDWITH
406: 
407:         WITH loc_oGrd.Column6
408:             .Width             = 60
409:             .FontSize          = 8
410:             .Movable           = .F.
411:             .Resizable         = .F.
412:             .ReadOnly          = .T.
413:             .Header1.Caption   = "Cupom"
414:             .Header1.Alignment = 2
415:             .Header1.FontSize  = 8
416:             .Text1.FontSize    = 8
417:         ENDWITH
418: 
419:         WITH loc_oGrd.Column7
420:             .Width             = 120
421:             .FontSize          = 8
422:             .Movable           = .F.
423:             .Resizable         = .F.
424:             .ReadOnly          = .T.
425:             .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
426:             .Header1.Alignment = 2
427:             .Header1.FontSize  = 8
428:             .Text1.FontSize    = 8
429:         ENDWITH
430:     ENDPROC

*-- Linhas 445 a 617:
445:         loc_oCnt     = THIS.cnt_4c_Transa
446:         loc_cImprimir = gc_4c_CaminhoIcones + "imprimir.bmp"
447: 
448:         loc_oCnt.AddObject("cmd_4c_Gerencial", "CommandButton")
449:         WITH loc_oCnt.cmd_4c_Gerencial
450:             .Top             = 281
451:             .Left            = 251
452:             .Height          = 46
453:             .Width           = 64
454:             .FontBold        = .T.
455:             .FontName        = "Small Fonts"
456:             .FontSize        = 7
457:             .ForeColor       = RGB(0,0,255)
458:             .Caption         = "<F2>\<Gerencial"
459:             .Picture         = loc_cImprimir
460:             .DisabledPicture = loc_cImprimir
461:             .Themes          = .T.
462:         ENDWITH
463: 
464:         loc_oCnt.AddObject("cmd_4c_Ultimo", "CommandButton")
465:         WITH loc_oCnt.cmd_4c_Ultimo
466:             .Top             = 281
467:             .Left            = 315
468:             .Height          = 46
469:             .Width           = 64
470:             .FontBold        = .T.
471:             .FontName        = "Small Fonts"
472:             .FontSize        = 7
473:             .ForeColor       = RGB(0,0,255)
474:             .Caption         = "<F3>\<Ultimo"
475:             .Picture         = loc_cImprimir
476:             .DisabledPicture = loc_cImprimir
477:             .Themes          = .T.
478:         ENDWITH
479: 
480:         loc_oCnt.AddObject("cmd_4c_Reimprime", "CommandButton")
481:         WITH loc_oCnt.cmd_4c_Reimprime
482:             .Top             = 281
483:             .Left            = 379
484:             .Height          = 46
485:             .Width           = 64
486:             .FontBold        = .T.
487:             .FontName        = "Small Fonts"
488:             .FontSize        = 7
489:             .ForeColor       = RGB(0,0,255)
490:             .Caption         = "<F4>\<Reimprimir"
491:             .Picture         = loc_cImprimir
492:             .DisabledPicture = loc_cImprimir
493:             .Themes          = .T.
494:         ENDWITH
495: 
496:         loc_oCnt.AddObject("cmd_4c_Cancela", "CommandButton")
497:         WITH loc_oCnt.cmd_4c_Cancela
498:             .Top             = 281
499:             .Left            = 443
500:             .Height          = 46
501:             .Width           = 64
502:             .FontBold        = .T.
503:             .FontName        = "Small Fonts"
504:             .FontSize        = 7
505:             .ForeColor       = RGB(0,0,255)
506:             .Caption         = "<F5>\<Cancelar"
507:             .Picture         = gc_4c_CaminhoIcones + "e_exit1.bmp"
508:             .DisabledPicture = gc_4c_CaminhoIcones + "e_exit1.bmp"
509:             .Themes          = .T.
510:         ENDWITH
511: 
512:         loc_oCnt.AddObject("cmd_4c_Ok", "CommandButton")
513:         WITH loc_oCnt.cmd_4c_Ok
514:             .Top             = 281
515:             .Left            = 507
516:             .Height          = 46
517:             .Width           = 64
518:             .FontBold        = .T.
519:             .FontName        = "Small Fonts"
520:             .FontSize        = 7
521:             .ForeColor       = RGB(0,0,255)
522:             .Cancel          = .T.
523:             .Caption         = "<ESC> Sair"
524:             .Picture         = gc_4c_CaminhoIcones + "sair.bmp"
525:             .DisabledPicture = gc_4c_CaminhoIcones + "sair.bmp"
526:             .Themes          = .T.
527:         ENDWITH
528: 
529:         *-- Click dos 5 botoes (Fase 7/8) - CommandButton puro criado via
530:         *-- AddObject exige BINDEVENT (regra #3: handler PUBLIC, sem THIS
531:         *-- aqui porque BINDEVENT ja qualifica o metodo do form).
532:         BINDEVENT(loc_oCnt.cmd_4c_Gerencial, "Click", THIS, "BtnGerencialClick")
533:         BINDEVENT(loc_oCnt.cmd_4c_Ultimo,    "Click", THIS, "BtnUltimoClick")
534:         BINDEVENT(loc_oCnt.cmd_4c_Reimprime, "Click", THIS, "BtnReimprimeClick")
535:         BINDEVENT(loc_oCnt.cmd_4c_Cancela,   "Click", THIS, "BtnCancelaClick")
536:         BINDEVENT(loc_oCnt.cmd_4c_Ok,        "Click", THIS, "BtnOkClick")
537:     ENDPROC
538: 
539:     *--------------------------------------------------------------------------
540:     * ConfigurarContainerPeriodo - cria o container de filtro de periodo
541:     * (Cnt_periodo do legado, cnt_4c_Periodo no migrado) dentro de
542:     * cnt_4c_Transa, sobre a moldura (shp_4c_Shape1) criada em
543:     * ConfigurarContainerTransa.
544:     *
545:     * FASE 5/8: titulo "Periodo" (Label1 -> lbl_4c_Periodo) e o primeiro
546:     * campo de data (Dt_inicial -> txt_4c_DataInicial).
547:     * FASE 6/8: separador "a" (Say2 -> lbl_4c_Separador, classe say -
548:     * AutoSize/esquerda, sem Width/Alignment inventados - regra #23), o
549:     * segundo campo de data (Dt_final -> txt_4c_DataFinal), o DATE() que o
550:     * Init do legado poe nos dois campos e os BINDEVENT que ligam cada campo
551:     * ao seu handler de validacao (ValidarDataInicial/ValidarDataFinal).
552:     *--------------------------------------------------------------------------
553:     PROTECTED PROCEDURE ConfigurarContainerPeriodo()
554:         LOCAL loc_oCnt
555: 
556:         THIS.cnt_4c_Transa.AddObject("cnt_4c_Periodo", "Container")
557:         loc_oCnt = THIS.cnt_4c_Transa.cnt_4c_Periodo
558:         WITH loc_oCnt
559:             .Top           = 278
560:             .Left          = 7
561:             .Height        = 52
562:             .Width         = 217
563:             .SpecialEffect = 0
564:             .BackStyle     = 0
565:             .BorderWidth   = 0
566:         ENDWITH
567: 
568:         *-- Label1: titulo "Periodo" em negrito/italico/sublinhado azul
569:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
570:         WITH loc_oCnt.lbl_4c_Periodo
571:             .AutoSize      = .F.
572:             .Top           = 3
573:             .Left          = 16
574:             .Height        = 18
575:             .Width         = 59
576:             .FontBold      = .T.
577:             .FontItalic    = .T.
578:             .FontSize      = 10
579:             .FontUnderline = .T.
580:             .BackStyle     = 0
581:             .ForeColor     = RGB(0,0,160)
582:             .Caption       = "Per" + CHR(237) + "odo"
583:         ENDWITH
584: 
585:         *-- Dt_inicial: campo de data inicial do filtro (fweditdata no legado)
586:         loc_oCnt.AddObject("txt_4c_DataInicial", "TextBox")
587:         WITH loc_oCnt.txt_4c_DataInicial
588:             .Top       = 22
589:             .Left      = 14
590:             .Height    = 23
591:             .Width     = 81
592:             .Alignment = 3
593:             .Value     = {}
594:         ENDWITH
595: 
596:         *-- Say2: separador "a" entre os dois campos de data - classe say,
597:         *-- o dump nao declara Width nem Alignment (regra #23): AutoSize=.T.
598:         *-- e Alignment=0 (esquerda), nunca inventar caixa com Alignment=1.
599:         loc_oCnt.AddObject("lbl_4c_Separador", "Label")
600:         WITH loc_oCnt.lbl_4c_Separador
601:             .AutoSize  = .T.
602:             .Top       = 25
603:             .Left      = 103
604:             .BackStyle = 0
605:             .Caption   = "a"
606:         ENDWITH
607: 
608:         *-- Dt_final: campo de data final do filtro (fweditdata no legado)
609:         loc_oCnt.AddObject("txt_4c_DataFinal", "TextBox")
610:         WITH loc_oCnt.txt_4c_DataFinal
611:             .Top       = 22
612:             .Left      = 119
613:             .Height    = 23
614:             .Width     = 81
615:             .Alignment = 3
616:             .Value     = {}
617:         ENDWITH

*-- Linhas 655 a 679:
655:             CASE par_nKeyCode = -3 && F4
656:                 THIS.BtnReimprimeClick()
657:                 NODEFAULT
658:             CASE par_nKeyCode = -4 AND THIS.cnt_4c_Transa.cmd_4c_Cancela.Visible && F5
659:                 THIS.BtnCancelaClick()
660:                 NODEFAULT
661:         ENDCASE
662:     ENDPROC
663: 
664:     *--------------------------------------------------------------------------
665:     * BtnOkClick - cmd_4c_Ok.Click (Legado: "Release Windows"). Encerra o
666:     * dialogo - eh a unica saida da tela (tambem acionada por ESC, ja que
667:     * cmd_4c_Ok.Cancel = .T.).
668:     *--------------------------------------------------------------------------
669:     PROCEDURE BtnOkClick()
670:         THIS.Release()
671:     ENDPROC
672: 
673:     *--------------------------------------------------------------------------
674:     * BtnCancelaClick - cmd_4c_Cancela.Click. Cancela a transacao TEF
675:     * selecionada na grade, mediante confirmacao do supervisor no terminal
676:     * (SigOpCtf ou SigTfCan, conforme CrSigCdPac.VerSitefs) e so entao grava
677:     * SigFiTef.cStatus = 'CNC' + a baixa em SigMvPar (sigproefBO.Atualizar /
678:     * AtualizarParcelaSigMvPar, que ja implementam esse SQL).
679:     *

*-- Linhas 691 a 717:
691:     PROCEDURE BtnCancelaClick()
692:         LOCAL loc_oBO, loc_cData, loc_lCancelou, loc_oErro
693: 
694:         loc_oBO = THIS.this_oBusinessObject
695: 
696:         IF !USED("cursor_4c_Transacao") OR RECCOUNT("cursor_4c_Transacao") = 0
697:             MsgAviso("N" + CHR(227) + "o Existem Transa" + CHR(231) + CHR(245) + "es Efetuadas", ;
698:                       "Cancelar Transa" + CHR(231) + CHR(227) + "o")
699:             RETURN
700:         ENDIF
701: 
702:         loc_oBO.CarregarDoCursor("cursor_4c_Transacao")
703: 
704:         *-- ValidarDados cobre os dois primeiros guards do legado (sem NSU /
705:         *-- cStatus = "CNC")
706:         IF !loc_oBO.ValidarDados()
707:             MsgAviso(loc_oBO.this_cMensagemErro, "Cancelar Transa" + CHR(231) + CHR(227) + "o")
708:             RETURN
709:         ENDIF
710: 
711:         *-- Legado: cupom fiscal tipo 3 (nao fiscal) pede confirmacao extra
712:         IF loc_oBO.this_nCupFis = 3
713:             IF !MsgConfirma("Aten" + CHR(231) + CHR(227) + "o! Esta " + CHR(233) + " uma opera" + CHR(231) + CHR(227) + "o de Cupom N" + CHR(227) + "o Fiscal." + CHR(13) + ;
714:                             "Deseja Realmente Continuar com o Cancelamento?", "Cancelar Transa" + CHR(231) + CHR(227) + "o")
715:                 RETURN
716:             ENDIF
717:         ENDIF

*-- Linhas 750 a 825:
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     * BtnReimprimeClick - cmd_4c_Reimprime.Click. Reimprime o comprovante da
754:     * transacao selecionada (SigPrOer, migrado como Formsigproer; ou
755:     * SigTfSup, fora do escopo desta migracao, chamada literal).
756:     *
757:     * Legado faz SKIP ANTES de ler FPags/cnValors/cndttrans/cnhrtrans - as
758:     * consultas e o DO FORM usam os dados da linha SEGUINTE da grade, nao da
759:     * linha selecionada (preservado literalmente - regra "formula do
760:     * legado: transcrever, nunca reescrever"); so o NSU e a data impressos
761:     * vem da linha ORIGINALMENTE selecionada, capturados ANTES do SKIP.
762:     *--------------------------------------------------------------------------
763:     PROCEDURE BtnReimprimeClick()
764:         LOCAL loc_oBO, loc_cNsuOriginal, loc_cDataOriginal, loc_oForm, loc_oErro
765: 
766:         loc_oBO = THIS.this_oBusinessObject
767: 
768:         IF !USED("cursor_4c_Transacao") OR RECCOUNT("cursor_4c_Transacao") = 0
769:             MsgAviso("N" + CHR(227) + "o Existem Transa" + CHR(231) + CHR(245) + "es Efetuadas", "Reimprimir")
770:             RETURN
771:         ENDIF
772: 
773:         SELECT cursor_4c_Transacao
774:         IF ALLTRIM(NVL(cStatus, "")) == "CNC"
775:             MsgAviso("Transa" + CHR(231) + CHR(227) + "o Cancelada", "Reimprimir")
776:             RETURN
777:         ENDIF
778: 
779:         loc_cNsuOriginal  = ALLTRIM(NVL(cnnsus, ""))
780:         loc_cDataOriginal = SUBSTR(DTOC(cndttrans), 1, 2) + SUBSTR(DTOC(cndttrans), 4, 2) + SUBSTR(DTOC(cndttrans), 7, 4)
781: 
782:         TRY
783:             *-- Legado: SKIP antes de ler os campos usados no DO FORM (ver cabecalho)
784:             SKIP
785: 
786:             loc_oBO.CarregarDoCursor("cursor_4c_Transacao")
787:             loc_oBO.CarregarFormaPagamento()
788: 
789:             IF ALLTRIM(loc_oBO.this_cVerSitefs) == "4.1"
790:                 loc_oForm = CREATEOBJECT("Formsigproer", loc_oBO.this_cNumIps, loc_oBO.this_cCnCaixas, ;
791:                     loc_cNsuOriginal, loc_cDataOriginal, TRANSFORM(cursor_4c_Transacao.cnvalors), ;
792:                     cursor_4c_Transacao.cndttrans, cursor_4c_Transacao.CnHrTrans, loc_oBO.this_cCodEstabs)
793:                 IF VARTYPE(loc_oForm) = "O"
794:                     loc_oForm.Show()
795:                 ENDIF
796:             ELSE
797:                 *-- fora do escopo desta migracao - chamada mantida literal (padrao SigOpClp)
798:                 DO FORM SigTfSup WITH loc_oBO.this_cNumIps, loc_oBO.this_cCnCaixas, loc_cNsuOriginal, loc_cDataOriginal, ;
799:                     cursor_4c_Transacao.cnvalors, cursor_4c_Transacao.cndttrans, cursor_4c_Transacao.CnHrTrans, loc_oBO.this_cCodEstabs
800:             ENDIF
801: 
802:             SELECT cursor_4c_Transacao
803:             SKIP -1
804:         CATCH TO loc_oErro
805:             MsgErro(loc_oErro.Message + CHR(13) + ;
806:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
807:                     "Procedure: " + loc_oErro.Procedure, ;
808:                     "Erro em BtnReimprimeClick")
809:             IF USED("cursor_4c_Transacao")
810:                 SELECT cursor_4c_Transacao
811:                 SKIP -1
812:             ENDIF
813:         ENDTRY
814: 
815:         THIS.Release()
816:     ENDPROC
817: 
818:     *--------------------------------------------------------------------------
819:     * BtnGerencialClick - cmd_4c_Gerencial.Click. Legado:
820:     *   Resposta=SigPrTef(crSigCdPam.NumIps,110,Transacao.cnValors,"1",
821:     *                      crSigFiMpF.CnCaixas,,"SW000001",0)
822:     *   Release Windows
823:     *
824:     * SigPrTef() eh funcao GLOBAL do legado (protocolo SiTef via DLL do
825:     * pinpad, comando administrativo tipo 110 = "Via Gerencial") que NAO

*-- Linhas 833 a 913:
833:     PROCEDURE BtnGerencialClick()
834:         LOCAL loc_oBO, loc_uResposta, loc_oErro
835: 
836:         loc_oBO = THIS.this_oBusinessObject
837: 
838:         IF USED("cursor_4c_Transacao") AND RECCOUNT("cursor_4c_Transacao") > 0
839:             loc_oBO.CarregarDoCursor("cursor_4c_Transacao")
840:         ENDIF
841: 
842:         TRY
843:             *-- fora do escopo desta migracao - ver comentario acima
844:             loc_uResposta = SigPrTef(loc_oBO.this_cNumIps, 110, loc_oBO.this_nCnValors, "1", ;
845:                                       loc_oBO.this_cCnCaixas, .NULL., "SW000001", 0)
846:         CATCH TO loc_oErro
847:             MsgErro(loc_oErro.Message + CHR(13) + ;
848:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
849:                     "Procedure: " + loc_oErro.Procedure, ;
850:                     "Erro em BtnGerencialClick")
851:         ENDTRY
852: 
853:         THIS.Release()
854:     ENDPROC
855: 
856:     *--------------------------------------------------------------------------
857:     * BtnUltimoClick - cmd_4c_Ultimo.Click. Reimprime a ULTIMA via do
858:     * comprovante (so pelo NSU - sem data/valor/hora, os demais parametros
859:     * do dialogo filho vao vazios como no legado). SigPrOer (migrado como
860:     * Formsigproer) ou SigTfSup (fora do escopo desta migracao, chamada
861:     * literal), conforme CrSigCdPac.VerSitefs.
862:     *--------------------------------------------------------------------------
863:     PROCEDURE BtnUltimoClick()
864:         LOCAL loc_oBO, loc_cNsu, loc_oForm, loc_oErro
865: 
866:         loc_oBO = THIS.this_oBusinessObject
867: 
868:         IF !USED("cursor_4c_Transacao") OR RECCOUNT("cursor_4c_Transacao") = 0
869:             MsgAviso("N" + CHR(227) + "o Existem Transa" + CHR(231) + CHR(245) + "es Efetuadas", ;
870:                       "Reimprimir " + CHR(250) + "ltimo")
871:             RETURN
872:         ENDIF
873: 
874:         loc_oBO.CarregarDoCursor("cursor_4c_Transacao")
875:         loc_oBO.CarregarFormaPagamento()
876: 
877:         loc_cNsu = ALLTRIM(NVL(loc_oBO.this_cCnNsus, ""))
878: 
879:         TRY
880:             IF ALLTRIM(loc_oBO.this_cVerSitefs) == "4.1"
881:                 loc_oForm = CREATEOBJECT("Formsigproer", loc_oBO.this_cNumIps, loc_oBO.this_cCnCaixas, ;
882:                     loc_cNsu, "", "", "", "", loc_oBO.this_cCodEstabs)
883:                 IF VARTYPE(loc_oForm) = "O"
884:                     loc_oForm.Show()
885:                 ENDIF
886:             ELSE
887:                 *-- fora do escopo desta migracao - chamada mantida literal (padrao SigOpClp)
888:                 DO FORM SigTfSup WITH loc_oBO.this_cNumIps, loc_oBO.this_cCnCaixas, loc_cNsu, "", "", "", "", loc_oBO.this_cCodEstabs
889:             ENDIF
890:         CATCH TO loc_oErro
891:             MsgErro(loc_oErro.Message + CHR(13) + ;
892:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
893:                     "Procedure: " + loc_oErro.Procedure, ;
894:                     "Erro em BtnUltimoClick")
895:         ENDTRY
896: 
897:         SELECT cursor_4c_Transacao
898:         IF RECCOUNT("cursor_4c_Transacao") > 0
899:             GO BOTTOM
900:         ENDIF
901: 
902:         THIS.Release()
903:     ENDPROC
904: 
905:     *--------------------------------------------------------------------------
906:     * ValidarDataInicial - handler do campo de data inicial (Dt_inicial do
907:     * legado). Reune, na ordem em que o legado os executa, o Valid e o
908:     * LostFocus do campo:
909:     *
910:     *   PROCEDURE Valid
911:     *   If This.Value > ThisForm.CntTransa.Cnt_periodo.Dt_inicial.Value
912:     *       ThisForm.CntTransa.Cnt_periodo.Dt_inicial.Value = This.Value
913:     *   Endif

*-- Linhas 1080 a 1155:
1080:     * exatamente como o SetAll do legado.
1081:     *--------------------------------------------------------------------------
1082:     PROTECTED PROCEDURE VincularGrade()
1083:         LOCAL loc_oGrd
1084: 
1085:         IF !USED("cursor_4c_Transacao")
1086:             RETURN .F.
1087:         ENDIF
1088: 
1089:         loc_oGrd = THIS.cnt_4c_Transa.grd_4c_Dados
1090: 
1091:         WITH loc_oGrd
1092:             .ColumnCount  = 7
1093:             .RecordSource = "cursor_4c_Transacao"
1094:             .ReadOnly     = .T.
1095: 
1096:             .Column1.ControlSource = "cursor_4c_Transacao.ccupomnvs"
1097:             .Column2.ControlSource = "cursor_4c_Transacao.cnnsus"
1098:             .Column3.ControlSource = "cursor_4c_Transacao.cnvalors"
1099:             .Column4.ControlSource = "cursor_4c_Transacao.cndttrans"
1100:             .Column5.ControlSource = "cursor_4c_Transacao.CnHrTrans"
1101:             .Column6.ControlSource = "cursor_4c_Transacao.cnCupoms"
1102:             .Column7.ControlSource = "cursor_4c_Transacao.cDopes"
1103: 
1104:             *-- larguras do legado (reaplicadas APOS o RecordSource)
1105:             .Column1.Width = 70
1106:             .Column2.Width = 78
1107:             .Column3.Width = 75
1108:             .Column4.Width = 65
1109:             .Column5.Width = 55
1110:             .Column6.Width = 60
1111:             .Column7.Width = 120
1112: 
1113:             *-- legendas do legado (resetadas pelo RecordSource)
1114:             .Column1.Header1.Caption = "Rede"
1115:             .Column2.Header1.Caption = "No.Autoriza" + CHR(231) + CHR(227) + "o"
1116:             .Column3.Header1.Caption = "Valor"
1117:             .Column4.Header1.Caption = "Data"
1118:             .Column5.Header1.Caption = "Hora"
1119:             .Column6.Header1.Caption = "Cupom"
1120:             .Column7.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1121: 
1122:             *-- ReadOnly da COLUNA depois do ReadOnly do GRID (o do grid
1123:             *-- propaga e sobrescreveria o das colunas)
1124:             .Column1.ReadOnly = .T.
1125:             .Column2.ReadOnly = .T.
1126:             .Column3.ReadOnly = .T.
1127:             .Column4.ReadOnly = .T.
1128:             .Column5.ReadOnly = .T.
1129:             .Column6.ReadOnly = .T.
1130:             .Column7.ReadOnly = .T.
1131: 
1132:             .SetAll("DynamicForeColor", ;
1133:                     "IIF(cursor_4c_Transacao.lCancel, RGB(255,0,0), RGB(0,0,0))", ;
1134:                     "Column")
1135:         ENDWITH
1136: 
1137:         *-- Legado: Go Bott no cursor + Grade.Refresh. Popular o cursor NAO
1138:         *-- repinta a grade sozinho (regra #21a).
1139:         SELECT cursor_4c_Transacao
1140:         IF RECCOUNT("cursor_4c_Transacao") > 0
1141:             GO BOTTOM
1142:         ENDIF
1143:         loc_oGrd.Refresh()
1144: 
1145:         *-- Legado: Grade.SetFocus no fim do SqlTrans. Na carga disparada pelo
1146:         *-- Init o form ainda nao esta visivel e SetFocus estouraria; nas
1147:         *-- recargas (troca de periodo) a grade ja esta na tela e recebe o foco.
1148:         IF THIS.Visible AND loc_oGrd.Visible AND loc_oGrd.Enabled
1149:             loc_oGrd.SetFocus()
1150:         ENDIF
1151: 
1152:         RETURN .T.
1153:     ENDPROC
1154: 
1155:     *--------------------------------------------------------------------------

*-- Linhas 1180 a 1201:
1180:     * (a mesma que Reimprime/Ultimo/Cancela deixam posicionada com GO BOTTOM/
1181:     * SKIP -1/GO BOTTOM). Chamado pelo Destroy (regra: calcular ANTES de
1182:     * fechar os cursores) e, em modo de seguranca, pelo proprio Unload.
1183:     *--------------------------------------------------------------------------
1184:     PROCEDURE MontarRetornoTransacao()
1185:         IF USED("cursor_4c_Transacao")
1186:             RETURN cursor_4c_Transacao.cnnsus
1187:         ENDIF
1188:         RETURN ""
1189:     ENDPROC
1190: 
1191:     *--------------------------------------------------------------------------
1192:     * Unload - migrado de sigproef.Unload. Devolve o valor que o Destroy ja
1193:     * cacheou em this_cNsuRetorno (calculado ali ANTES de os cursores serem
1194:     * fechados); recalcula so se por algum caminho ainda nao tiver sido
1195:     * preenchido. Atende os dois modos de abertura: "DO FORM ... TO lcVar"
1196:     * (le este RETURN) e CREATEOBJECT + Show() (le a property
1197:     * this_cNsuRetorno, que sobrevive ao fechamento porque o chamador ainda
1198:     * tem a referencia ao objeto).
1199:     *--------------------------------------------------------------------------
1200:     PROCEDURE Unload()
1201:         IF EMPTY(THIS.this_cNsuRetorno)

*-- Linhas 1208 a 1233:
1208:     * Destroy - libera o Business Object
1209:     *--------------------------------------------------------------------------
1210:     PROCEDURE Destroy()
1211:         *-- Calcula o retorno da tela ANTES de fechar os cursores proprios -
1212:         *-- o Unload dispara DEPOIS do Destroy e ja nao alcancaria
1213:         *-- cursor_4c_Transacao.
1214:         THIS.this_cNsuRetorno = THIS.MontarRetornoTransacao()
1215: 
1216:         *-- cursores proprios desta tela (montados em BuscarTransacoes)
1217:         IF USED("cursor_4c_Transacao")
1218:             USE IN cursor_4c_Transacao
1219:         ENDIF
1220:         IF USED("cursor_4c_Selecao")
1221:             USE IN cursor_4c_Selecao
1222:         ENDIF
1223:         IF USED("cursor_4c_Selecao2")
1224:             USE IN cursor_4c_Selecao2
1225:         ENDIF
1226: 
1227:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1228:             THIS.this_oBusinessObject = .NULL.
1229:         ENDIF
1230:         DODEFAULT()
1231:     ENDPROC
1232: 
1233: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigproefBO.prg):
*====================================================================
* sigproefBO.prg
*
* Business Object para Selecao/Cancelamento de Transacoes TEF (sigproef)
* Form OPERACIONAL - lista as transacoes TEF (cartao/cheque) efetuadas
* num periodo, permite reimprimir comprovante, cancelar a transacao
* (com baixa no SigMvPar) e emitir relatorio Gerencial do TEF.
* Tabela principal: SigFiTef (cidchaves PK char(20))
* Tabelas relacionadas: SigOpFp, SigCdPam, SigCdPac, SigFiMpF,
*                        SigMvCab, SigCdOpe, SigMvPar
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigproefBO AS BusinessBase

    *-- Parametros do sistema, carregados em Init a partir de SigCdPam/SigCdPac
    *-- (legado: crSigCdPam / crSigCdPac, lidos uma unica vez no Init do form)
    this_nNcChequePs = 0      && SigCdPam.ncchequeps - numeric(1,0)
    this_nSistef     = 0      && SigCdPam.sistef - numeric(1,0), indica uso de TEF
    this_cNumIps     = ""     && SigCdPam.numips - char(15), numero do PDV/caixa no TEF
    this_cVerSitefs  = ""     && SigCdPac.versitefs - char(10), versao do protocolo SiTef instalado

    *-- Dados da impressora fiscal do caixa corrente, carregados a partir de
    *-- SigFiMpF (legado: crSigFiMpF, localizado por CursorQuery em cimpfabs)
    this_cCImpFabs   = ""     && SigFiMpF.cimpfabs - PK, numero de fabricacao decriptografado
    this_cCnCaixas   = ""     && SigFiMpF.cncaixas - char(3), caixa associado a impressora

    *-- Identificacao da operacao/caixa, equivalente as propriedades do
    *-- Form legado (coperacao/nocaixa/nofab), usadas em SqlTrans e nos
    *-- DO FORM de Cancelamento/Reimpressao/Gerencial
    this_cOperacao   = ""     && PADR(NoCaixa + NoFab + 'ADM', 20)
    this_cNoCaixa    = ""     && numero do caixa (mesmo valor de this_cCnCaixas)
    this_cNoFab      = ""     && numero de fabricacao da impressora, ja decriptografado

    *-- Permissao de acesso ao botao Cancelar (fChecaAcesso('SIGPROEF','CANCELA'))
    this_lPermiteCancelar = .F.

    *-- Periodo de pesquisa das transacoes (controles Dt_Inicial/Dt_Final)
    this_dDataInicial = {}
    this_dDataFinal   = {}

    *-- Linha corrente do cursor de transacoes (grid da tela), montada em
    *-- BuscarTransacoes a partir de SigFiTef (Selecao) + SigMvCab/SigCdOpe
    *-- (Selecao2) - usada pelos botoes Cancela/Reimprime/Ultimo/Gerencial
    this_cCEmps       = ""    && SigFiTef.cemps - char(3)
    this_cDopes       = ""    && SigFiTef.cdopes - char(20), documento da operacao
    this_cCnCupoms    = ""    && cnCupoms apos SqlTrans (substituido por SigMvCab.Notas)
    this_cCCupomNvs   = ""    && SigFiTef.ccupomnvs - char(20), rede/bandeira do cartao
    this_cCnNsus      = ""    && SigFiTef.cnnsus - char(12), NSU da transacao TEF
    this_nCnValors    = 0     && SigFiTef.cnvalors - valor da transacao (convertido p/ numerico)
    this_dCnDtTrans   = {}    && SigFiTef.cndttrans - data da transacao (convertida p/ DATE)
    this_cCnHrTrans   = ""    && SigFiTef.cnhrtrans - char(8), hora da transacao (@R xx:xx:xx)
    this_cCStatus     = ""    && SigFiTef.cstatus - char(3), status ('CNC' = cancelada)
    this_cFPags       = ""    && SigFiTef.fpags - char(12), forma de pagamento (FK SigOpFp)
    this_lLCancel     = .F.   && .T. quando this_cCStatus = 'CNC' (uso visual na grade)
    this_nCupFis      = 0     && SigMvCab.cupfis (via SigCdOpe) - 1/3 = cupom nao fiscal
    this_cEmpDopNums  = ""    && SigMvCab.empdopnums - char(29), POSICIONAL (regra #42)
    this_cCnIdents    = ""    && SigFiTef.cnidents - char(10), identificador interno da transacao

    *-- Dados da forma de pagamento (SigOpFp), carregados a partir de
    *-- this_cFPags para montar os parametros dos DO FORM de Cancelamento/
    *-- Reimpressao/Ultimo
    this_cOpers       = ""    && SigOpFp.opers
    this_cLCartao     = ""    && SigOpFp.lcartao - char(1), NAO bit (conferido no schema)
    this_cCodEstabs   = ""    && SigOpFp.codestabs

    *-- Registro de SigMvPar correspondente a transacao (localizado por
    *-- this_cEmpDopNums + this_cCnIdents = SigMvPar.cnidtefs), usado para
    *-- marcar o cancelamento (lcancelas) no ExecutarCancelamento
    this_cCidChavesPar = ""   && SigMvPar.cidchaves
    this_nValosPar     = 0    && SigMvPar.valos
    this_cCnIdTefsPar  = ""   && SigMvPar.cnidtefs

    *-- Resultado/mensagem da ultima operacao SQL (Update/Commit)
    this_cMensagemRetorno = ""

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigFiTef"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "sigproefBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega os parametros gerais usados pelos
    * botoes de acao, equivalente ao bloco do Init legado:
    *   .poDatamgr.SqlExecute([Select ncchequeps,Sistef, NumIps From SigCdPam],"crSigCdPam")
    *   .poDatamgr.SqlExecute([Select VerSitefs From SigCdPac],"crSigCdPac")
    *   ThisForm.CntTransa.Cancela.Visible = fChecaAcesso('SIGPROEF','CANCELA')
    *
    * O "=fLerFiscal()" do Init legado NAO entra aqui: carrega CrSigFiFis/
    * config de impressora fiscal para OUTRAS telas (ex.: SigOpAut) - o
    * proprio sigproef nunca le o resultado em lugar nenhum do dump. Omitir
    * tem o MESMO efeito observavel nesta tela (regra CLAUDE.md #27 -
    * funcao global sem consumo local).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_cSQL = "SELECT ncchequeps, sistef, numips FROM SigCdPam"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Pam") > 0
                SELECT cursor_4c_Pam
                GO TOP
                THIS.this_nNcChequePs = TratarNulo(ncchequeps, 0)
                THIS.this_nSistef     = TratarNulo(sistef, 0)
                THIS.this_cNumIps     = TratarNulo(numips, "")
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
            loc_cSQL = "SELECT versitefs FROM SigCdPac"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Pac") > 0
                SELECT cursor_4c_Pac
                GO TOP
                THIS.this_cVerSitefs = TratarNulo(versitefs, "")
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF

            THIS.this_lPermiteCancelar = fChecaAcesso("SIGPROEF", "CANCELA")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarParametrosSistema")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosImpressoraFiscal - Localiza a impressora fiscal do caixa
    * corrente, equivalente ao bloco do Init legado:
    *   lnNoFabr = LeituraFab(oFormulario)
    *   lcNoFabr = fDecriptografar(Alltrim(lnNoFabr))
    *   ThisForm.podatamgr.CursorQuery('SigFiMpF','crSigFiMpF','cimpfabs', lcNoFabr)
    *   Thisform.NoCaixa    = crSigFiMpf.cnCaixas
    *   Thisform.NoFab      = lnNoFabr
    *   Thisform.cOperacao  = PADR(NoCaixa+NoFab+'ADM',20)
    *
    * LeituraFab()/fDecriptografar() (utils\leiturafab.prg/fdecriptografar.prg)
    * sao wrappers de compatibilidade que sempre devolvem "" - o protocolo
    * proprietario da impressora fiscal nao esta no acervo. Com cimpfabs=""
    * a consulta nao casa com nenhuma impressora real - o MESMO efeito
    * pratico que o legado produz quando a leitura da impressora falha.
    *
    * Retorna .F. quando a impressora nao foi localizada (o Form exibe o
    * aviso do legado "Impressora Fiscal Invalida para esta Loja !!"), mas
    * NAO interrompe a abertura: o legado tambem segue adiante (a variavel
    * "ok" fica .F. e nunca eh conferida depois do bloco).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosImpressoraFiscal()
        LOCAL loc_cNoFab, loc_cSQL, loc_nResultado, loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            loc_cNoFab = LeituraFab(.NULL.)

            IF VARTYPE(loc_cNoFab) = "C"
                loc_cNoFab = fDecriptografar(ALLTRIM(loc_cNoFab))

                IF USED("cursor_4c_MpF")
                    USE IN cursor_4c_MpF
                ENDIF

                loc_cSQL = "SELECT cimpfabs, cncaixas FROM SigFiMpF" + ;
                           " WHERE cimpfabs = " + EscaparSQL(loc_cNoFab)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MpF")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_MpF") > 0
                    SELECT cursor_4c_MpF
                    GO TOP
                    THIS.this_cCImpFabs = TratarNulo(cimpfabs, "")
                    THIS.this_cCnCaixas = TratarNulo(cncaixas, "")
                    THIS.this_cNoCaixa  = THIS.this_cCnCaixas
                    THIS.this_cNoFab    = loc_cNoFab
                    THIS.this_cOperacao = PADR(THIS.this_cNoCaixa + THIS.this_cNoFab + "ADM", 20)
                    loc_lEncontrou = .T.
                ENDIF

                IF USED("cursor_4c_MpF")
                    USE IN cursor_4c_MpF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDadosImpressoraFiscal")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFormaPagamento - Localiza a forma de pagamento (SigOpFp) da
    * transacao corrente, equivalente ao bloco repetido em Cancela/Reimprime/
    * Ultimo.Click do legado:
    *   lcSql=[SELECT * From SigOpFp Where Fpags = ']+Transacao.FPags+[']
    *   ThisFOrm.poDatamgr.SqlExecute(lcSql,"csSigOpFp")
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFormaPagamento()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        IF USED("cursor_4c_OpFp")
            USE IN cursor_4c_OpFp
        ENDIF

        loc_cSQL = "SELECT opers, lcartao, codestabs FROM SigOpFp" + ;
                   " WHERE fpags = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cFPags, "")))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_OpFp") > 0
            SELECT cursor_4c_OpFp
            GO TOP
            THIS.this_cOpers     = TratarNulo(opers, "")
            THIS.this_cLCartao   = TratarNulo(lcartao, "")
            THIS.this_cCodEstabs = TratarNulo(codestabs, "")
            loc_lSucesso = .T.
        ENDIF

        IF USED("cursor_4c_OpFp")
            USE IN cursor_4c_OpFp
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha corrente do cursor de transacoes
    * (grid "Transacao" do legado - Create Cursor em SqlTrans) para as
    * properties this_*, usadas pelos botoes Cancela/Reimprime/Ultimo/
    * Gerencial. Colunas na mesma ordem do CREATE CURSOR do legado.
    *
    * SigFiTef.cemps NAO entra aqui: a consulta legado (Selecao) traz
    * a.Cemps, mas o CREATE CURSOR Transacao nunca declara esse campo, e o
    * Gather Memvar so copia os nomes que o cursor destino possui - ou
    * seja, o legado tambem descarta Cemps nesse ponto. Fidelidade ao
    * legado: nao carregar o que ele mesmo nao carrega.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cDopes      = TratarNulo(cDopes, "")
        THIS.this_cCnCupoms   = TratarNulo(cnCupoms, "")
        THIS.this_cCCupomNvs  = TratarNulo(ccupomnvs, "")
        THIS.this_cCnNsus     = TratarNulo(cnnsus, "")
        THIS.this_nCnValors   = TratarNulo(cnvalors, 0)
        THIS.this_dCnDtTrans  = TratarNulo(cndttrans, {})
        THIS.this_cCnHrTrans  = TratarNulo(CnHrTrans, "")
        THIS.this_cCStatus    = TratarNulo(cStatus, "")
        THIS.this_cFPags      = TratarNulo(FPags, "")
        THIS.this_lLCancel    = TratarNulo(lCancel, .F.)
        THIS.this_nCupFis     = TratarNulo(CupFis, 0)
        THIS.this_cEmpDopNums = TratarNulo(EmpdopNums, "")
        THIS.this_cCnIdents   = TratarNulo(cnIdents, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Guardas do legado antes do cancelamento (inicio do
    * Cancela.Click: Eof() / cStatus = "CNC"). A confirmacao interativa do
    * cupom nao fiscal (CupFis = 3) eh decisao de UX e fica no Form, que so
    * chama Salvar()/Atualizar() depois de o usuario confirmar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(NVL(THIS.this_cCnNsus, "")))
            THIS.this_cMensagemErro = "N" + CHR(227) + "o Existem Transa" + CHR(231) + CHR(245) + "es Efetuadas"
            RETURN .F.
        ENDIF

        IF ALLTRIM(NVL(THIS.this_cCStatus, "")) = "CNC"
            THIS.this_cMensagemErro = "Transa" + CHR(231) + CHR(227) + "o Cancelada"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Executa o cancelamento da transacao TEF, equivalente ao
    * corpo em SQL do Cancela.Click do legado:
    *   Update SigFiTef set cStatus = 'CNC', UsuCancs = Usuar
    *     Where ctipos = 'R' And cHeaders = 'CRT' And cnnsus = <valor>
    * e, se a atualizacao acima teve sucesso, marca a parcela de SigMvPar
    * correspondente (AtualizarParcelaSigMvPar). So confirma com
    * SQLCOMMIT quando as duas gravacoes (ou a ausencia legitima da
    * parcela em SigMvPar) permitirem - replica o "If RetSql > 0" final
    * do legado, que so comita quando nada saiu errado.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiTef SET " + ;
                       "cStatus = " + EscaparSQL("CNC") + ", " + ;
                       "UsuCancs = " + EscaparSQL(TratarNulo(gc_4c_UsuarioLogado, "")) + " " + ;
                       "WHERE ctipos = " + EscaparSQL("R") + ;
                       " AND cHeaders = " + EscaparSQL("CRT") + ;
                       " AND cnnsus = " + EscaparSQL(ALLTRIM(THIS.this_cCnNsus))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                IF THIS.AtualizarParcelaSigMvPar()
                    SQLCOMMIT(gnConnHandle)
                    THIS.this_lLCancel = .T.
                    THIS.this_cCStatus = "CNC"
                    loc_lSucesso = .T.
                ELSE
                    SQLROLLBACK(gnConnHandle)
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel atualizar a parcela em SigMvPar:" + ;
                        CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Cancelar Transa" + CHR(231) + CHR(227) + "o")
                ENDIF
            ELSE
                SQLROLLBACK(gnConnHandle)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel cancelar a transa" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Cancelar Transa" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Cancelar Transa" + CHR(231) + CHR(227) + "o")
        ENDTRY

        IF loc_lSucesso
            THIS.RegistrarAuditoria("ATUALIZAR")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarParcelaSigMvPar - Replica o bloco do legado que localiza a
    * parcela de SigMvPar pela chave posicional EmpDopNums (regra #42 -
    * NUNCA Alltrim nas partes, o valor ja vem completo de SigMvCab) e,
    * achando a linha cujo CnIdTefs bate com o identificador TEF da
    * transacao, marca lCancelas = 1.
    *
    * Retorna .T. quando NAO ha parcela (nada a fazer - legado tambem
    * comita so com o UPDATE de SigFiTef) OU quando a parcela foi marcada
    * com sucesso; .F. somente quando a parcela existe e o UPDATE falhou -
    * nesse caso o chamador reverte a transacao inteira (mesmo "If RetSql
    * > 0" final do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarParcelaSigMvPar()
        LOCAL loc_cSQL, loc_nResultado, loc_lPodeComitar

        loc_lPodeComitar = .T.

        IF USED("cursor_4c_SigMvParTmp")
            USE IN cursor_4c_SigMvParTmp
        ENDIF

        loc_cSQL = "SELECT EmpDopNums, Valos, CnIdTefs, cidChaves " + ;
                   "FROM SigMvPar " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvParTmp")

        IF loc_nResultado > 0
            SELECT cursor_4c_SigMvParTmp
            LOCATE FOR ALLTRIM(cnidtefs) == ALLTRIM(THIS.this_cCnIdents)
            IF FOUND()
                THIS.this_cCidChavesPar = TratarNulo(cidchaves, "")
                THIS.this_nValosPar     = TratarNulo(valos, 0)
                THIS.this_cCnIdTefsPar  = TratarNulo(cnidtefs, "")

                loc_cSQL = "UPDATE SigMvPar SET lCancelas = 1 " + ;
                           "WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChavesPar)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lPodeComitar = (loc_nResultado > 0)
            ENDIF
        ENDIF

        IF USED("cursor_4c_SigMvParTmp")
            USE IN cursor_4c_SigMvParTmp
        ENDIF

        RETURN loc_lPodeComitar
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - SigFiTef.cidchaves nao vem na consulta legado
    * (Selecao/Transacao); a chave que o proprio Cancela.Click usa para
    * localizar e atualizar o registro eh cnnsus (Where ... And CNNSUS =
    * <valor>), entao eh essa a chave usada na auditoria deste BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCnNsus, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / ExecutarExclusao - este BO cobre consulta de transacoes
    * TEF e cancelamento (Atualizar); o legado nunca cria nem exclui
    * registro de SigFiTef a partir desta tela (Cancela.Click so faz
    * Update). O comportamento padrao herdado de BusinessBase ja eh o
    * correto para as duas operacoes - por isso nao sao sobrescritas aqui.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * BuscarTransacoes - Carga do cursor de transacoes TEF exibido na grade.
    * Transcreve o corpo de dados do metodo SqlTrans do legado:
    *
    *   1) "Selecao"  -> SigFiTef no periodo (cndttransi entre as duas datas em
    *      DTOS), so transacao de RETORNO (ctipos = "R") de cartao ou cheque
    *      (cHeaders "CRT"/"CHQ") e com NSU preenchido, ordenada por data/hora.
    *   2) "Selecao2" -> SigMvCab x SigCdOpe no mesmo periodo (datas entre o
    *      inicio do primeiro dia e 23:59:59 do ultimo), restrita as operacoes
    *      de cupom (b.cupfis IN (1,3)), indexada por EmpDopNums.
    *   3) cursor_4c_Transacao -> uma linha por transacao, com as conversoes do
    *      legado: hora formatada (@R xx:xx:xx), valor em centavos dividido por
    *      100, data DDMMYYYY convertida para DATE, e Notas/CupFis/EmpDopNums
    *      trazidos de Selecao2 pela chave POSICIONAL de 29 caracteres.
    *
    * A chave de busca em Selecao2 eh POSICIONAL (regra #42): cemps char(3) +
    * cdopes char(20) + STR(cncupoms, 6) = 29 = EmpDopNums char(29). Por isso
    * usa PADR explicito em cada parte - ALLTRIM aqui devolveria ZERO linhas
    * em silencio.
    *
    * O cursor eh criado UMA vez e recarregado com ZAP nas chamadas seguintes:
    * recria-lo derrubaria o RecordSource/ControlSource da grade do form.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_dIni, loc_dFim, loc_cHora, loc_nValor, loc_cDataTxt
        LOCAL loc_dTrans, loc_cChave, loc_cNotas, loc_nCupFis, loc_cEmpDop
        LOCAL loc_cNsu, loc_lTemConexao

        loc_lSucesso            = .F.
        THIS.this_cMensagemErro = ""

        TRY
            *-- Legado: Dt_Inicial/Dt_Final nascem com DATE() no Init do form
            IF EMPTY(THIS.this_dDataInicial)
                THIS.this_dDataInicial = DATE()
            ENDIF
            IF EMPTY(THIS.this_dDataFinal)
                THIS.this_dDataFinal = DATE()
            ENDIF

            loc_dIni = ConverterParaData(THIS.this_dDataInicial)
            loc_dFim = ConverterParaData(THIS.this_dDataFinal)

            *-- Guard do handle, no padrao de DataAccess/BusinessBase: sem ele
            *-- o SQLEXEC estoura com "Variable GNCONNHANDLE is not found" ou
            *-- com erro de handle invalido, mensagem que nao diz nada ao
            *-- usuario. Os dois testes vao em IF ANINHADO, nao em um OR:
            *-- VFP9 NAO faz short-circuit, entao "TYPE(x) != N OR x <= 0"
            *-- avaliaria x <= 0 mesmo com a variavel inexistente - que eh
            *-- exatamente o erro que o guard existe para evitar.
            loc_lTemConexao = .F.
            IF TYPE("gnConnHandle") = "N"
                IF gnConnHandle > 0
                    loc_lTemConexao = .T.
                ENDIF
            ENDIF

            IF !loc_lTemConexao
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados."
                loc_lSucesso = .F.
            ELSE

                *-- 1) Selecao: transacoes TEF do periodo
                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                loc_cSQL = "SELECT DISTINCT a.cemps, a.cdopes, a.cncupoms, a.cnidents," + ;
                           " a.ccupomnvs, a.cnnsus, a.cnvalors, a.cndttrans," + ;
                           " a.cnhrtrans, a.cstatus, a.fpags" + ;
                           " FROM SigFiTef a" + ;
                           " WHERE a.cndttransi BETWEEN " + EscaparSQL(DTOS(loc_dIni)) + ;
                           " AND " + EscaparSQL(DTOS(loc_dFim)) + ;
                           " AND a.ctipos = " + EscaparSQL("R") + ;
                           " AND (a.cheaders = " + EscaparSQL("CRT") + ;
                           " OR a.cheaders = " + EscaparSQL("CHQ") + ")" + ;
                           " AND NOT a.cnnsus = " + EscaparSQL("   ") + ;
                           " ORDER BY a.cndttrans, a.cnhrtrans"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Selecao")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel consultar as transa" + CHR(231) + CHR(245) + "es TEF:" + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    *-- 2) Selecao2: cupom/operacao do movimento no mesmo periodo
                    IF USED("cursor_4c_Selecao2")
                        USE IN cursor_4c_Selecao2
                    ENDIF

                    loc_cSQL = "SELECT a.empdopnums, a.notas, b.cupfis" + ;
                               " FROM SigMvCab a, SigCdOpe b" + ;
                               " WHERE a.datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                               " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399) + ;
                               " AND a.dopes = b.dopes" + ;
                               " AND b.cupfis IN (1,3)"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Selecao2")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel consultar os cupons do per" + CHR(237) + "odo:" + ;
                            CHR(13) + CapturarErroSQL()
                    ELSE
                        SELECT cursor_4c_Selecao2
                        INDEX ON empdopnums TAG empdopnums

                        *-- 3) cursor da grade: estrutura IDENTICA ao Create Cursor
                        *-- Transacao do legado (nomes lidos por CarregarDoCursor)
                        IF USED("cursor_4c_Transacao")
                            SELECT cursor_4c_Transacao
                            ZAP
                        ELSE
                            CREATE CURSOR cursor_4c_Transacao ( ;
                                cDopes     C(20), ;
                                cnCupoms   C(10), ;
                                ccupomnvs  C(20), ;
                                cnnsus     C(12), ;
                                cnvalors   N(12,2), ;
                                cndttrans  D, ;
                                CnHrTrans  C(8), ;
                                cStatus    C(3), ;
                                FPags      C(12), ;
                                lCancel    L, ;
                                CupFis     N(1), ;
                                EmpdopNums C(29), ;
                                cnIdents   C(10))
                            INDEX ON cndttrans TAG Datas
                        ENDIF

                        SELECT cursor_4c_Selecao
                        SCAN
                            loc_cHora    = TRANSFORM(TratarNulo(cnhrtrans, ""), "@R xx:xx:xx")
                            loc_nValor   = ROUND(VAL(STRTRAN(TratarNulo(cnvalors, ""), ",", "")) / 100, 2)
                            loc_cNsu     = SUBSTR(TratarNulo(cnnsus, ""), 1, 12)
                            loc_cDataTxt = TratarNulo(cndttrans, "")

                            *-- cndttrans eh char DDMMYYYY. O legado monta a string
                            *-- dd/mm/aaaa e chama CTOD; o DATE(a,m,d) abaixo produz
                            *-- a MESMA data sem depender do SET DATE em vigor.
                            IF LEN(ALLTRIM(loc_cDataTxt)) >= 8
                                loc_dTrans = DATE(VAL(RIGHT(ALLTRIM(loc_cDataTxt), 4)), ;
                                                  VAL(SUBSTR(loc_cDataTxt, 3, 2)), ;
                                                  VAL(SUBSTR(loc_cDataTxt, 1, 2)))
                            ELSE
                                loc_dTrans = {}
                            ENDIF

                            *-- chave POSICIONAL de 29 chars (regra #42)
                            loc_cChave = PADR(TratarNulo(cemps, ""), 3) + ;
                                         PADR(TratarNulo(cdopes, ""), 20) + ;
                                         STR(VAL(TratarNulo(cncupoms, "")), 6)

                            loc_cNotas  = ""
                            loc_nCupFis = 0
                            loc_cEmpDop = ""

                            *-- O legado faz =Seek(...) e le Selecao2 SEM testar
                            *-- FOUND(): nao achando, a leitura cai em EOF e traz
                            *-- vazio. O IF abaixo produz o MESMO resultado sem ler
                            *-- registro inexistente.
                            IF SEEK(loc_cChave, "cursor_4c_Selecao2", "empdopnums")
                                loc_cNotas  = TratarNulo(cursor_4c_Selecao2.notas, "")
                                loc_nCupFis = TratarNulo(cursor_4c_Selecao2.cupfis, 0)
                                loc_cEmpDop = TratarNulo(cursor_4c_Selecao2.empdopnums, "")
                            ENDIF

                            INSERT INTO cursor_4c_Transacao ( ;
                                cDopes, cnCupoms, ccupomnvs, cnnsus, cnvalors, ;
                                cndttrans, CnHrTrans, cStatus, FPags, lCancel, ;
                                CupFis, EmpdopNums, cnIdents) ;
                            VALUES ( ;
                                TratarNulo(cursor_4c_Selecao.cdopes, ""), ;
                                loc_cNotas, ;
                                TratarNulo(cursor_4c_Selecao.ccupomnvs, ""), ;
                                loc_cNsu, ;
                                loc_nValor, ;
                                loc_dTrans, ;
                                loc_cHora, ;
                                TratarNulo(cursor_4c_Selecao.cstatus, ""), ;
                                TratarNulo(cursor_4c_Selecao.fpags, ""), ;
                                (ALLTRIM(TratarNulo(cursor_4c_Selecao.cstatus, "")) == "CNC"), ;
                                loc_nCupFis, ;
                                loc_cEmpDop, ;
                                TratarNulo(cursor_4c_Selecao.cnidents, ""))
                        ENDSCAN

                        IF USED("cursor_4c_Selecao")
                            USE IN cursor_4c_Selecao
                        ENDIF
                        IF USED("cursor_4c_Selecao2")
                            USE IN cursor_4c_Selecao2
                        ENDIF

                        *-- Legado: Select Transacao / Go Bott (a ultima transacao
                        *-- do periodo fica selecionada ao abrir a tela)
                        SELECT cursor_4c_Transacao
                        IF RECCOUNT("cursor_4c_Transacao") > 0
                            GO BOTTOM
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        IF !loc_lSucesso AND !EMPTY(THIS.this_cMensagemErro)
            MsgErro(THIS.this_cMensagemErro, "Transa" + CHR(231) + CHR(245) + "es TEF")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

