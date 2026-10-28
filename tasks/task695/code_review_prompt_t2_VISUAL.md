# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [ALINHAMENTO] Botao 'cmd_4c_Visualizar' tem Top=5 mas grupo usa Top=4 (diferenca de 1px)
- [ALINHAMENTO] Botao 'cmd_4c_Imprimir' tem Top=5 mas grupo usa Top=4 (diferenca de 1px)
- [ALINHAMENTO] Botao 'cmd_4c_Saida' tem Top=5 mas grupo usa Top=4 (diferenca de 1px)
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (6300 linhas total):

*-- Linhas 39 a 47:
39: * PEstoque() legado alimenta:
40: *
41: *   aba 2 Pendencias : grade TmpPar (6 colunas), grade de formas de pagamento
42: *                      crTmpTipos com CheckBox marcavel (os 4 handlers de
43: *                      toggle + FiltrarTipos), filtro de grupo, total das
44: *                      pendencias visiveis e os botoes Documento (abre o
45: *                      FormSigMvExp) e Listagem (SigReIpd).
46: *   aba 3 Cheques    : quatro grades (dbAberto / DbFollow / DbTitulo /
47: *                      dbDevolvido), filtro de grupo, os nove totais do pe da

*-- Linhas 96 a 114:
96: *       Cadastro de Clientes (SIGCDCLI -> FormCliente), em vez de inventar a
97: *       operacao (PILAR 1) - ver a nota do bloco "EVENTOS PRINCIPAIS".
98: *
99: *   cmd_4c_Imprime + cnt_4c_SelecionaImpCad / cnt_4c_SelecionaImpressao :
100: *       transcricao de Imprime.Click - abre o painel certo (SelecionaImpCad
101: *       na visao CADASTRO, SelecionaImpressao na visao MOVIMENTO - mesma
102: *       regra de Cmd_MudaCli.Visible do legado) centralizado e com o resto
103: *       da tela desabilitado (DesabilitarControlesImpressao /
104: *       RestaurarControlesImpressao - funil unico para os 6 botoes
105: *       Saida/Visualizar/Imprimir dos dois paineis).
106: *   ImpressaoCad()/Impressao() : os dois metodos de impressao do legado,
107: *       com os FRX SIGOPCGV.frx (Impressao) e SigReGcd.frx (ImpressaoCad)
108: *       copiados para app/reports. Impressao() monta o cursor agregado
109: *       TmpRelGv com uma secao por checkbox marcado; quatro delas (Chk_
110: *       MovPend/dbConserto, Chk_ResVenda/dbTotVendas, Chk_ProdAdq/dbProduto,
111: *       Chk_Producao/dbProduc) dependem das abas Vendas/Operacoes Pend./
112: *       Producao (PProduto() legado, que falta fazer - ver nota abaixo) e
113: *       ficam guardadas por USED(): entram em acao sozinhas quando essa fase
114: *       for feita, sem precisar tocar neste metodo de novo.

*-- Linhas 219 a 227:
219:         THIS.this_cCpfInicial   = IIF(TYPE("par_cCpf")     = "C", par_cCpf,     "")
220: 
221:         IF TYPE("par_cTitulo") = "C" AND !EMPTY(par_cTitulo)
222:             THIS.Caption = par_cTitulo
223:         ENDIF
224: 
225:         RETURN DODEFAULT()
226:     ENDPROC
227: 

*-- Linhas 307 a 325:
307:     PROTECTED PROCEDURE ConfigurarPageFrame()
308:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
309:         WITH THIS.pgf_4c_Paginas
310:             .Top       = -33
311:             .Left      = -1
312:             .Width     = 1003
313:             .Height    = 635
314:             .PageCount = 2
315:             .TabStop   = .F.
316:             .Themes    = .F.
317:             .Visible   = .F.
318: 
319:             .Page1.Caption = "Consulta"
320:             .Page2.Caption = "Resultado"
321: 
322:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
323:                 .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
324:                 .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
325:             ENDIF

*-- Linhas 340 a 389:
340: 
341:         loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
342:         WITH loc_oPg.cnt_4c_Cabecalho
343:             .Top         = 5
344:             .Left        = -1
345:             *-- Page nao expoe Width/Height em runtime (regra #9.2): a largura
346:             *-- da faixa vem do FORM, nao da Page
347:             .Width       = THIS.Width + 2
348:             .Height      = 80
349:             .BackStyle   = 1
350:             .BackColor   = RGB(100, 100, 100)
351:             .BorderWidth = 0
352:             .Visible     = .T.
353: 
354:             .AddObject("lbl_4c_Sombra", "Label")
355:             WITH .lbl_4c_Sombra
356:                 .Top       = 17
357:                 .Left      = 10
358:                 .Width     = THIS.Width
359:                 .Height    = 46
360:                 .AutoSize  = .F.
361:                 .WordWrap  = .T.
362:                 .FontBold  = .T.
363:                 .FontName  = "Tahoma"
364:                 .FontSize  = 18
365:                 .BackStyle = 0
366:                 .ForeColor = RGB(0, 0, 0)
367:                 .Caption   = THIS.Caption
368:                 .Visible   = .T.
369:             ENDWITH
370: 
371:             .AddObject("lbl_4c_Titulo", "Label")
372:             WITH .lbl_4c_Titulo
373:                 .Top       = 18
374:                 .Left      = 10
375:                 .Width     = THIS.Width
376:                 .Height    = 46
377:                 .AutoSize  = .F.
378:                 .WordWrap  = .T.
379:                 .FontBold  = .T.
380:                 .FontName  = "Tahoma"
381:                 .FontSize  = 18
382:                 .BackStyle = 0
383:                 .ForeColor = RGB(255, 255, 255)
384:                 .Caption   = THIS.Caption
385:                 .Visible   = .T.
386:             ENDWITH
387:         ENDWITH
388: 
389:         THIS.ConfigurarOrigem()

*-- Linhas 401 a 511:
401: 
402:         loc_oPg.AddObject("cnt_4c_Origem", "Container")
403:         WITH loc_oPg.cnt_4c_Origem
404:             .Top           = 89
405:             .Left          = 12
406:             .Width         = 702
407:             .Height        = 235
408:             .BackStyle     = 0
409:             .BorderWidth   = 0
410:             .SpecialEffect = 0
411:             .BackColor     = RGB(255, 255, 255)
412:             .Visible       = .T.
413:         ENDWITH
414: 
415:         WITH loc_oPg.cnt_4c_Origem
416:             *-- Labels (classe say do legado - Alignment/Width so quando o dump declara)
417:             .AddObject("lbl_4c_Conta", "Label")
418:             WITH .lbl_4c_Conta
419:                 .Top       = 5
420:                 .Left      = 5
421:                 .Width     = 115
422:                 .Height    = 15
423:                 .Alignment = 1
424:                 .FontBold  = .T.
425:                 .FontSize  = 8
426:                 .BackStyle = 0
427:                 .ForeColor = RGB(90, 90, 90)
428:                 .Caption   = "Conta para Pesquisa"
429:                 .Visible   = .T.
430:             ENDWITH
431: 
432:             .AddObject("lbl_4c_LabelConta", "Label")
433:             WITH .lbl_4c_LabelConta
434:                 .Top       = 30
435:                 .Left      = 49
436:                 .Width     = 60
437:                 .Height    = 15
438:                 .Alignment = 0
439:                 .FontSize  = 8
440:                 .BackStyle = 0
441:                 .ForeColor = RGB(90, 90, 90)
442:                 .Caption   = "Conta"
443:                 .Visible   = .T.
444:             ENDWITH
445: 
446:             .AddObject("lbl_4c_LabelCpf", "Label")
447:             WITH .lbl_4c_LabelCpf
448:                 .Top       = 30
449:                 .Left      = 135
450:                 .Width     = 90
451:                 .Height    = 15
452:                 .Alignment = 0
453:                 .FontSize  = 8
454:                 .BackStyle = 0
455:                 .ForeColor = RGB(90, 90, 90)
456:                 .Caption   = "CPF / CGC"
457:                 .Visible   = .T.
458:             ENDWITH
459: 
460:             .AddObject("lbl_4c_LabelDConta", "Label")
461:             WITH .lbl_4c_LabelDConta
462:                 .Top       = 70
463:                 .Left      = 49
464:                 .Width     = 60
465:                 .Height    = 15
466:                 .Alignment = 0
467:                 .FontSize  = 8
468:                 .BackStyle = 0
469:                 .ForeColor = RGB(90, 90, 90)
470:                 .Caption   = "Nome"
471:                 .Visible   = .T.
472:             ENDWITH
473: 
474:             .AddObject("lbl_4c_LabelConjuge", "Label")
475:             WITH .lbl_4c_LabelConjuge
476:                 .Top       = 70
477:                 .Left      = 330
478:                 .Width     = 130
479:                 .Height    = 15
480:                 .Alignment = 0
481:                 .FontSize  = 8
482:                 .BackStyle = 0
483:                 .ForeColor = RGB(90, 90, 90)
484:                 .Caption   = "Nome do C" + CHR(244) + "njuge"
485:                 .Visible   = .T.
486:             ENDWITH
487: 
488:             .AddObject("lbl_4c_LabelTelefone", "Label")
489:             WITH .lbl_4c_LabelTelefone
490:                 .Top       = 109
491:                 .Left      = 49
492:                 .Width     = 80
493:                 .Height    = 15
494:                 .Alignment = 0
495:                 .FontSize  = 8
496:                 .BackStyle = 0
497:                 .ForeColor = RGB(90, 90, 90)
498:                 .Caption   = "Telefone"
499:                 .Visible   = .T.
500:             ENDWITH
501: 
502:             *-- Campo Conta: codigo exato (Get_conta)
503:             .AddObject("txt_4c_Conta", "TextBox")
504:             WITH .txt_4c_Conta
505:                 .Top               = 44
506:                 .Left              = 49
507:                 .Width             = 80
508:                 .Height            = 21
509:                 .Value             = ""
510:                 .InputMask         = "XXXXXXXXXX"
511:                 .MaxLength         = 10

*-- Linhas 519 a 528:
519:             *-- Campo CPF/CGC: codigo exato validado (Get_cpf)
520:             .AddObject("txt_4c_Cpf", "TextBox")
521:             WITH .txt_4c_Cpf
522:                 .Top               = 44
523:                 .Left              = 134
524:                 .Width             = 146
525:                 .Height            = 21
526:                 .Value             = ""
527:                 .MaxLength         = 20
528:                 .SpecialEffect     = 1

*-- Linhas 535 a 578:
535:             *-- Filtro de pesquisa por Nome: Iniciais (prefixo) / Qualquer Parte (contem)
536:             .AddObject("obj_4c_OptFiltro", "OptionGroup")
537:             WITH .obj_4c_OptFiltro
538:                 .Top         = 63
539:                 .Left        = 82
540:                 .Width       = 175
541:                 .Height      = 19
542:                 .ButtonCount = 2
543:                 .BackStyle   = 0
544:                 .BorderStyle = 0
545:                 .Value       = 1
546:                 WITH .Buttons(1)
547:                     .Caption   = "\<Iniciais"
548:                     .Top       = 5
549:                     .Left      = 5
550:                     .Width     = 50
551:                     .Height    = 15
552:                     .Style     = 0
553:                     .BackStyle = 0
554:                     .FontSize  = 8
555:                 ENDWITH
556:                 WITH .Buttons(2)
557:                     .Caption   = "\<Qualquer Parte"
558:                     .Top       = 5
559:                     .Left      = 62
560:                     .Width     = 91
561:                     .Height    = 15
562:                     .Style     = 0
563:                     .BackStyle = 0
564:                     .FontSize  = 8
565:                 ENDWITH
566:                 .Visible = .T.
567:             ENDWITH
568: 
569:             *-- Campo Nome: pesquisa por LIKE (Get_dconta)
570:             .AddObject("txt_4c_DConta", "TextBox")
571:             WITH .txt_4c_DConta
572:                 .Top               = 84
573:                 .Left              = 49
574:                 .Width             = 278
575:                 .Height            = 21
576:                 .Value             = ""
577:                 .MaxLength         = 40
578:                 .SpecialEffect     = 1

*-- Linhas 585 a 594:
585:             *-- Campo Conjuge: pesquisa por LIKE (GetConj)
586:             .AddObject("txt_4c_Conjuge", "TextBox")
587:             WITH .txt_4c_Conjuge
588:                 .Top               = 84
589:                 .Left              = 330
590:                 .Width             = 338
591:                 .Height            = 21
592:                 .Value             = ""
593:                 .MaxLength         = 40
594:                 .SpecialEffect     = 1

*-- Linhas 601 a 610:
601:             *-- Campo Telefone: pesquisa por LIKE (getTelefone)
602:             .AddObject("txt_4c_Telefone", "TextBox")
603:             WITH .txt_4c_Telefone
604:                 .Top               = 123
605:                 .Left              = 49
606:                 .Width             = 115
607:                 .Height            = 21
608:                 .Value             = ""
609:                 .MaxLength         = 40
610:                 .SpecialEffect     = 1

*-- Linhas 638 a 705:
638: 
639:         loc_oPg.AddObject("cmg_4c_GrpOperacao", "CommandGroup")
640:         WITH loc_oPg.cmg_4c_GrpOperacao
641:             .Top         = 3
642:             .Left        = 769
643:             .Width       = 235
644:             .Height      = 85
645:             .ButtonCount = 3
646:             .BackStyle   = 0
647:             .BorderStyle = 0
648:             .SpecialEffect = 1
649:             .BorderColor = RGB(136, 189, 188)
650:             .Themes      = .F.
651: 
652:             WITH .Buttons(1)
653:                 .Top        = 5
654:                 .Left       = 5
655:                 .Width      = 75
656:                 .Height     = 75
657:                 .FontBold   = .T.
658:                 .FontItalic = .T.
659:                 .FontName   = "Comic Sans MS"
660:                 .FontSize   = 8
661:                 .Caption    = "\<Cadastro"
662:                 .ToolTipText = "Dados Cadastrais"
663:                 .ForeColor  = RGB(90, 90, 90)
664:                 .BackColor  = RGB(255, 255, 255)
665:                 .Themes     = .F.
666:                 IF FILE(gc_4c_CaminhoIcones + "geral_contatos_60.jpg")
667:                     .Picture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
668:                 ENDIF
669:             ENDWITH
670: 
671:             WITH .Buttons(2)
672:                 .Top        = 5
673:                 .Left       = 80
674:                 .Width      = 75
675:                 .Height     = 75
676:                 .FontBold   = .T.
677:                 .FontItalic = .T.
678:                 .FontName   = "Comic Sans MS"
679:                 .FontSize   = 8
680:                 .Caption    = "\<Movimento"
681:                 .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
682:                 .ForeColor  = RGB(90, 90, 90)
683:                 .BackColor  = RGB(255, 255, 255)
684:                 .Themes     = .F.
685:                 IF FILE(gc_4c_CaminhoIcones + "geral_pastas_60.jpg")
686:                     .Picture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
687:                 ENDIF
688:             ENDWITH
689: 
690:             WITH .Buttons(3)
691:                 .Top        = 5
692:                 .Left       = 155
693:                 .Width      = 75
694:                 .Height     = 75
695:                 .FontBold   = .T.
696:                 .FontItalic = .T.
697:                 .FontName   = "Comic Sans MS"
698:                 .FontSize   = 8
699:                 .Cancel     = .T.
700:                 .Caption    = "[ESC] Sair"
701:                 .ForeColor  = RGB(90, 90, 90)
702:                 .BackColor  = RGB(255, 255, 255)
703:                 .Themes     = .F.
704:                 IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
705:                     .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 1199 a 1274:
1199: 
1200:         loc_oPg.AddObject("pgf_4c_Resultado", "PageFrame")
1201:         WITH loc_oPg.pgf_4c_Resultado
1202:             .Top           = 127
1203:             .Left          = -1
1204:             .Width         = 1003
1205:             .Height        = 476
1206:             .PageCount     = 10
1207:             *-- SpecialEffect de PageFrame eh READ-ONLY em runtime: o legado
1208:             *-- declara 2 no SCX, mas o VFP9 nao aceita a atribuicao aqui
1209:             .Tabs          = .F.
1210:             .Themes        = .F.
1211:             .Visible       = .T.
1212: 
1213:             .Page1.FontName  = "Verdana"
1214:             .Page1.FontSize  = 8
1215:             .Page1.Caption   = "Saldo"
1216:             .Page1.BackColor = RGB(255, 255, 255)
1217:             .Page1.ForeColor = RGB(36, 84, 155)
1218: 
1219:             .Page2.FontName  = "Tahoma"
1220:             .Page2.FontSize  = 8
1221:             .Page2.Caption   = "Pend" + CHR(234) + "ncias"
1222:             .Page2.BackColor = RGB(255, 255, 255)
1223:             .Page2.ForeColor = RGB(90, 90, 90)
1224: 
1225:             .Page3.FontName  = "Tahoma"
1226:             .Page3.FontSize  = 8
1227:             .Page3.Caption   = "Cheques"
1228:             .Page3.BackColor = RGB(255, 255, 255)
1229:             .Page3.ForeColor = RGB(90, 90, 90)
1230: 
1231:             .Page4.FontName  = "Tahoma"
1232:             .Page4.FontSize  = 8
1233:             .Page4.Caption   = "Cart" + CHR(227) + "o"
1234:             .Page4.BackColor = RGB(255, 255, 255)
1235:             .Page4.ForeColor = RGB(90, 90, 90)
1236: 
1237:             .Page5.FontName  = "Tahoma"
1238:             .Page5.FontSize  = 8
1239:             .Page5.Caption   = "Vendas"
1240:             .Page5.BackColor = RGB(255, 255, 255)
1241:             .Page5.ForeColor = RGB(90, 90, 90)
1242: 
1243:             .Page6.FontName  = "Tahoma"
1244:             .Page6.FontSize  = 8
1245:             .Page6.Caption   = "Estoque"
1246:             .Page6.BackColor = RGB(255, 255, 255)
1247:             .Page6.ForeColor = RGB(90, 90, 90)
1248: 
1249:             .Page7.FontName  = "Tahoma"
1250:             .Page7.FontSize  = 8
1251:             .Page7.Caption   = "Opera" + CHR(231) + CHR(245) + "es Pendentes"
1252:             .Page7.BackColor = RGB(255, 255, 255)
1253:             .Page7.ForeColor = RGB(90, 90, 90)
1254: 
1255:             .Page8.FontName  = "Tahoma"
1256:             .Page8.FontSize  = 8
1257:             .Page8.Caption   = "Produ" + CHR(231) + CHR(227) + "o"
1258:             .Page8.BackColor = RGB(255, 255, 255)
1259:             .Page8.ForeColor = RGB(90, 90, 90)
1260: 
1261:             .Page9.FontName  = "Tahoma"
1262:             .Page9.FontSize  = 8
1263:             .Page9.Caption   = "H.Cheques"
1264:             .Page9.BackColor = RGB(255, 255, 255)
1265:             .Page9.ForeColor = RGB(90, 90, 90)
1266: 
1267:             .Page10.FontName  = "Tahoma"
1268:             .Page10.FontSize  = 8
1269:             .Page10.Caption   = "Cr" + CHR(233) + "dito"
1270:             .Page10.BackColor = RGB(255, 255, 255)
1271:             .Page10.ForeColor = RGB(90, 90, 90)
1272: 
1273:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
1274:                 .Page1.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"

*-- Linhas 1301 a 1326:
1301:         LOCAL loc_oPg
1302:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page1
1303: 
1304:         loc_oPg.AddObject("lbl_4c_Historico", "Label")
1305:         WITH loc_oPg.lbl_4c_Historico
1306:             .Top       = 90
1307:             .Left      = 11
1308:             .Width     = 160
1309:             .Height    = 15
1310:             .Alignment = 0
1311:             .FontSize  = 8
1312:             .BackStyle = 0
1313:             .ForeColor = RGB(90, 90, 90)
1314:             .Caption   = "Hist" + CHR(243) + "rico Conta Corrente"
1315:             .Visible   = .T.
1316:         ENDWITH
1317: 
1318:         loc_oPg.AddObject("grd_4c_Historico", "Grid")
1319:         WITH loc_oPg.grd_4c_Historico
1320:             .Top           = 104
1321:             .Left          = 11
1322:             .Width         = 721
1323:             .Height        = 292
1324:             .FontName      = "Courier New"
1325:             .DeleteMark    = .F.
1326:             .RecordMark    = .F.

*-- Linhas 1332 a 1392:
1332:             .Visible       = .T.
1333: 
1334:             .Columns(1).ControlSource      = "dbHistorico.emps"
1335:             .Columns(1).Header1.Caption    = "Emp"
1336:             .Columns(1).Width              = 31
1337:             .Columns(1).ReadOnly           = .T.
1338: 
1339:             .Columns(2).ControlSource      = "dbHistorico.datas"
1340:             .Columns(2).Header1.Caption    = "Data"
1341:             .Columns(2).Width              = 80
1342:             .Columns(2).ReadOnly           = .T.
1343: 
1344:             .Columns(3).ControlSource      = "dbHistorico.valors"
1345:             .Columns(3).Header1.Caption    = "Valor"
1346:             .Columns(3).Width              = 94
1347:             .Columns(3).Format             = "9,999,999.99"
1348:             .Columns(3).InputMask          = "9,999,999.99"
1349:             .Columns(3).ReadOnly           = .T.
1350: 
1351:             .Columns(4).ControlSource      = "dbHistorico.opers"
1352:             .Columns(4).Header1.Caption    = "O"
1353:             .Columns(4).Width              = 18
1354:             .Columns(4).ReadOnly           = .T.
1355: 
1356:             .Columns(5).ControlSource      = "dbHistorico.saldos"
1357:             .Columns(5).Header1.Caption    = "Saldo"
1358:             .Columns(5).Width              = 94
1359:             .Columns(5).Alignment          = 3
1360:             .Columns(5).Format             = "9,999,999.99"
1361:             .Columns(5).InputMask          = "9,999,999.99"
1362:             .Columns(5).ReadOnly           = .T.
1363: 
1364:             .Columns(6).ControlSource      = "dbHistorico.hists"
1365:             .Columns(6).Header1.Caption    = "Hist" + CHR(243) + "rico"
1366:             .Columns(6).Width              = 376
1367:             .Columns(6).ReadOnly           = .T.
1368:         ENDWITH
1369: 
1370:         loc_oPg.AddObject("lbl_4c_Saldo", "Label")
1371:         WITH loc_oPg.lbl_4c_Saldo
1372:             .Top       = 251
1373:             .Left      = 747
1374:             .Width     = 150
1375:             .Height    = 15
1376:             .Alignment = 0
1377:             .FontSize  = 8
1378:             .BackStyle = 0
1379:             .ForeColor = RGB(90, 90, 90)
1380:             .Caption   = "Saldo por Moeda"
1381:             .Visible   = .T.
1382:         ENDWITH
1383: 
1384:         loc_oPg.AddObject("grd_4c_Saldo", "Grid")
1385:         WITH loc_oPg.grd_4c_Saldo
1386:             .Top          = 265
1387:             .Left         = 747
1388:             .Width        = 242
1389:             .Height       = 131
1390:             .FontName     = "Courier New"
1391:             .DeleteMark   = .F.
1392:             .RecordMark   = .F.

*-- Linhas 1398 a 1445:
1398:             .Visible      = .T.
1399: 
1400:             .Columns(1).ControlSource   = "dbSaldo.moedas"
1401:             .Columns(1).Header1.Caption = "Moe"
1402:             .Columns(1).Width           = 70
1403:             .Columns(1).ReadOnly        = .T.
1404: 
1405:             .Columns(2).ControlSource   = "dbSaldo.saldos"
1406:             .Columns(2).Header1.Caption = "Saldo"
1407:             .Columns(2).Width           = 86
1408:             .Columns(2).Format          = "9,999,999.99"
1409:             .Columns(2).InputMask       = "9,999,999.99"
1410:             .Columns(2).ReadOnly        = .T.
1411: 
1412:             .Columns(3).ControlSource   = "dbSaldo.SaldoConta"
1413:             .Columns(3).Header1.Caption = "Dispon" + CHR(237) + "vel"
1414:             .Columns(3).Width           = 86
1415:             .Columns(3).Format          = "9,999,999.99"
1416:             .Columns(3).InputMask       = "9,999,999.99"
1417:             .Columns(3).ReadOnly        = .T.
1418:         ENDWITH
1419: 
1420:         *-- Botao "Documento" (Anexa) do historico de conta corrente (Result.
1421:         *-- Saldo.Anexa do legado): mesmo padrao icone-only do cmd_4c_AnexaPend
1422:         *-- da aba Pendencias (regra do botao nunca desabilitado em runtime).
1423:         loc_oPg.AddObject("cmd_4c_AnexaSaldo", "CommandButton")
1424:         WITH loc_oPg.cmd_4c_AnexaSaldo
1425:             .Top             = 407
1426:             .Left            = 744
1427:             .Width           = 40
1428:             .Height          = 40
1429:             .FontName        = "Verdana"
1430:             .FontSize        = 8
1431:             .Caption         = ""
1432:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1433:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1434:             .ToolTipText     = "Documento"
1435:             .ForeColor       = RGB(90, 90, 90)
1436:             .BackColor       = RGB(255, 255, 255)
1437:             .Themes          = .T.
1438:             .Visible         = .T.
1439:         ENDWITH
1440:         BINDEVENT(loc_oPg.cmd_4c_AnexaSaldo, "Click", THIS, "BtnAnexaSaldoClick")
1441: 
1442:         loc_oPg.grd_4c_Historico.Refresh()
1443:         loc_oPg.grd_4c_Saldo.Refresh()
1444:     ENDPROC
1445: 

*-- Linhas 1465 a 1474:
1465:         loc_oOpt = loc_oPg.obj_4c_OptResultado
1466: 
1467:         WITH loc_oOpt
1468:             .Top           = 12
1469:             .Left          = 44
1470:             .Width         = 760
1471:             .Height        = 85
1472:             .ButtonCount   = 10
1473:             .BackStyle     = 0
1474:             .BorderStyle   = 0

*-- Linhas 1544 a 1564:
1544:             par_cCaption, par_cIcone, par_nPicPos, par_nAlign, par_lWordWrap, par_cToolTip)
1545: 
1546:         WITH par_oGrupo.Buttons(par_nIndice)
1547:             .Top        = 5
1548:             .Left       = par_nLeft
1549:             .Width      = 75
1550:             .Height     = 75
1551:             .FontBold   = .T.
1552:             .FontItalic = .T.
1553:             .FontName   = "Comic Sans MS"
1554:             .FontSize   = 8
1555:             .Style      = 1
1556:             .AutoSize   = .F.
1557:             .WordWrap   = par_lWordWrap
1558:             .Alignment  = par_nAlign
1559:             .Caption    = par_cCaption
1560:             .ForeColor  = RGB(90, 90, 90)
1561:             .BackColor  = RGB(255, 255, 255)
1562:             .Themes     = .F.
1563: 
1564:             IF par_nPicPos > 0

*-- Linhas 1596 a 1661:
1596:         loc_oCnt = loc_oPg.cnt_4c_Periodo
1597: 
1598:         WITH loc_oCnt
1599:             .Top         = 120
1600:             .Left        = -1
1601:             .Width       = 252
1602:             .Height      = 36
1603:             .BackStyle   = 0
1604:             .BorderWidth = 0
1605:             .Visible     = .T.
1606:         ENDWITH
1607: 
1608:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
1609:         WITH loc_oCnt.lbl_4c_Periodo
1610:             .Top       = 10
1611:             .Left      = 16
1612:             .Width     = 48
1613:             .Height    = 17
1614:             .AutoSize  = .F.
1615:             .Alignment = 0
1616:             .FontName  = "Tahoma"
1617:             .FontSize  = 8
1618:             .BackStyle = 0
1619:             .ForeColor = RGB(90, 90, 90)
1620:             .Caption   = "Per" + CHR(237) + "o\<do : "
1621:             .Visible   = .T.
1622:         ENDWITH
1623: 
1624:         loc_oCnt.AddObject("txt_4c_DtInicial", "TextBox")
1625:         WITH loc_oCnt.txt_4c_DtInicial
1626:             .Top           = 8
1627:             .Left          = 66
1628:             .Width         = 80
1629:             .Height        = 21
1630:             .Value         = {}
1631:             .Format        = "K"
1632:             .ForeColor     = RGB(0, 0, 0)
1633:             .SpecialEffect = 1
1634:             .Visible       = .T.
1635:         ENDWITH
1636: 
1637:         loc_oCnt.AddObject("lbl_4c_PeriodoAte", "Label")
1638:         WITH loc_oCnt.lbl_4c_PeriodoAte
1639:             .Top       = 10
1640:             .Left      = 149
1641:             .Width     = 10
1642:             .Height    = 17
1643:             .AutoSize  = .F.
1644:             .Alignment = 0
1645:             .FontName  = "Tahoma"
1646:             .FontSize  = 8
1647:             .BackStyle = 0
1648:             .ForeColor = RGB(90, 90, 90)
1649:             .Caption   = CHR(224)
1650:             .Visible   = .T.
1651:         ENDWITH
1652: 
1653:         loc_oCnt.AddObject("txt_4c_DtFinal", "TextBox")
1654:         WITH loc_oCnt.txt_4c_DtFinal
1655:             .Top           = 8
1656:             .Left          = 160
1657:             .Width         = 80
1658:             .Height        = 21
1659:             .Value         = {}
1660:             .Format        = "K"
1661:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1692 a 1720:
1692:         *-- Cmd_MudaCli: "Cadastro"
1693:         loc_oPg.AddObject("cmg_4c_MudaCli", "CommandGroup")
1694:         WITH loc_oPg.cmg_4c_MudaCli
1695:             .Top           = 12
1696:             .Left          = 794
1697:             .Width         = 85
1698:             .Height        = 85
1699:             .ButtonCount   = 1
1700:             .BackStyle     = 0
1701:             .BorderStyle   = 0
1702:             .SpecialEffect = 1
1703:             .BorderColor   = RGB(136, 189, 188)
1704:             .Themes        = .F.
1705: 
1706:             WITH .Buttons(1)
1707:                 .Top         = 5
1708:                 .Left        = 5
1709:                 .Width       = 75
1710:                 .Height      = 75
1711:                 .FontBold    = .T.
1712:                 .FontItalic  = .T.
1713:                 .FontName    = "Comic Sans MS"
1714:                 .FontSize    = 8
1715:                 .Caption     = "\<Cadastro"
1716:                 .ToolTipText = "Dados Cadastrais"
1717:                 .ForeColor   = RGB(90, 90, 90)
1718:                 .BackColor   = RGB(255, 255, 255)
1719:                 .Themes      = .F.
1720:                 IF FILE(gc_4c_CaminhoIcones + "geral_contatos_60.jpg")

*-- Linhas 1728 a 1756:
1728:         *-- Cmd_MudaMov: "Movimento"
1729:         loc_oPg.AddObject("cmg_4c_MudaMov", "CommandGroup")
1730:         WITH loc_oPg.cmg_4c_MudaMov
1731:             .Top           = 12
1732:             .Left          = 794
1733:             .Width         = 85
1734:             .Height        = 85
1735:             .ButtonCount   = 1
1736:             .BackStyle     = 0
1737:             .BorderStyle   = 0
1738:             .SpecialEffect = 1
1739:             .BorderColor   = RGB(136, 189, 188)
1740:             .Themes        = .F.
1741: 
1742:             WITH .Buttons(1)
1743:                 .Top         = 5
1744:                 .Left        = 5
1745:                 .Width       = 75
1746:                 .Height      = 75
1747:                 .FontBold    = .T.
1748:                 .FontItalic  = .T.
1749:                 .FontName    = "Comic Sans MS"
1750:                 .FontSize    = 8
1751:                 .Caption     = "\<Movimento"
1752:                 .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
1753:                 .ForeColor   = RGB(90, 90, 90)
1754:                 .BackColor   = RGB(255, 255, 255)
1755:                 .Themes      = .F.
1756:                 IF FILE(gc_4c_CaminhoIcones + "geral_pastas_60.jpg")

*-- Linhas 1764 a 1827:
1764:         *-- grp_operacao da pagina Resultado: "Voltar"
1765:         loc_oPg.AddObject("cmg_4c_Voltar", "CommandGroup")
1766:         WITH loc_oPg.cmg_4c_Voltar
1767:             .Top           = 12
1768:             .Left          = 869
1769:             .Width         = 85
1770:             .Height        = 85
1771:             .ButtonCount   = 1
1772:             .BackStyle     = 0
1773:             .BorderStyle   = 0
1774:             .SpecialEffect = 1
1775:             .BorderColor   = RGB(136, 189, 188)
1776:             .Value         = 1
1777:             .Themes        = .F.
1778: 
1779:             WITH .Buttons(1)
1780:                 .Top        = 5
1781:                 .Left       = 5
1782:                 .Width      = 75
1783:                 .Height     = 75
1784:                 .FontBold   = .T.
1785:                 .FontItalic = .T.
1786:                 .FontName   = "Comic Sans MS"
1787:                 .FontSize   = 8
1788:                 .Cancel     = .T.
1789:                 .Caption    = "Voltar"
1790:                 .ForeColor  = RGB(90, 90, 90)
1791:                 .BackColor  = RGB(255, 255, 255)
1792:                 .Themes     = .F.
1793:                 IF FILE(gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg")
1794:                     .Picture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1795:                 ENDIF
1796:             ENDWITH
1797: 
1798:             .Visible = .T.
1799:         ENDWITH
1800: 
1801:         *-- Saldo de cashback do cliente (lblSaldoCash / getSaldoCash)
1802:         loc_oPg.AddObject("lbl_4c_SaldoCash", "Label")
1803:         WITH loc_oPg.lbl_4c_SaldoCash
1804:             .Top       = 97
1805:             .Left      = 49
1806:             .Width     = 59
1807:             .Height    = 21
1808:             .AutoSize  = .F.
1809:             .Alignment = 0
1810:             .FontBold  = .T.
1811:             .FontName  = "Tahoma"
1812:             .FontSize  = 12
1813:             .BackStyle = 0
1814:             .ForeColor = RGB(0, 0, 0)
1815:             .Caption   = "Saldo: "
1816:             .Visible   = .F.
1817:         ENDWITH
1818: 
1819:         loc_oPg.AddObject("txt_4c_SaldoCash", "TextBox")
1820:         WITH loc_oPg.txt_4c_SaldoCash
1821:             .Top               = 96
1822:             .Left              = 105
1823:             .Width             = 100
1824:             .Height            = 23
1825:             .Value             = ""
1826:             .FontName          = "Tahoma"
1827:             .FontSize          = 8

*-- Linhas 1847 a 2511:
1847:         LOCAL loc_oPg
1848:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1849: 
1850:         loc_oPg.AddObject("cmd_4c_Imprime", "CommandButton")
1851:         WITH loc_oPg.cmd_4c_Imprime
1852:             .Top             = 134
1853:             .Left            = 858
1854:             .Width           = 137
1855:             .Height          = 37
1856:             .FontBold        = .T.
1857:             .FontItalic      = .T.
1858:             .FontName        = "Comic Sans MS"
1859:             .FontSize        = 8
1860:             .Caption         = "     \<Imprimir"
1861:             .ToolTipText     = "Impress" + CHR(227) + "o"
1862:             .PicturePosition = 1
1863:             .ForeColor       = RGB(90, 90, 90)
1864:             .BackColor       = RGB(255, 255, 255)
1865:             .Themes          = .F.
1866:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
1867:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1868:             ENDIF
1869:             .Visible = .T.
1870:         ENDWITH
1871:         BINDEVENT(loc_oPg.cmd_4c_Imprime, "Click", THIS, "BtnImprimeClick")
1872: 
1873:         THIS.ConfigurarPainelImpressaoCadastro(loc_oPg)
1874:         THIS.ConfigurarPainelImpressaoMovimento(loc_oPg)
1875:     ENDPROC
1876: 
1877:     *==========================================================================
1878:     * ConfigurarPainelImpressaoCadastro - SelecionaImpCad do legado: painel
1879:     * simples (5 checkboxes) usado quando Imprime eh acionado na visao
1880:     * CADASTRO.
1881:     *==========================================================================
1882:     PROTECTED PROCEDURE ConfigurarPainelImpressaoCadastro(par_oPg)
1883:         LOCAL loc_oCnt
1884:         par_oPg.AddObject("cnt_4c_SelecionaImpCad", "Container")
1885:         loc_oCnt = par_oPg.cnt_4c_SelecionaImpCad
1886: 
1887:         WITH loc_oCnt
1888:             .Top           = 213
1889:             .Left          = 270
1890:             .Width         = 458
1891:             .Height        = 178
1892:             .SpecialEffect = 0
1893:             .BackColor     = RGB(255, 255, 255)
1894:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
1895:                 .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
1896:             ENDIF
1897:             .Visible = .F.
1898:         ENDWITH
1899: 
1900:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
1901:         WITH loc_oCnt.lbl_4c_Titulo
1902:             .Top       = 6
1903:             .Left      = 5
1904:             .Width     = 226
1905:             .Height    = 17
1906:             .AutoSize  = .F.
1907:             .FontBold  = .T.
1908:             .FontName  = "Tahoma"
1909:             .FontSize  = 8
1910:             .BackStyle = 0
1911:             .ForeColor = RGB(90, 90, 90)
1912:             .Caption   = "Impress" + CHR(227) + "o da Consulta (Cadastro)"
1913:             .Visible   = .T.
1914:         ENDWITH
1915: 
1916:         loc_oCnt.AddObject("chk_4c_Generico", "CheckBox")
1917:         WITH loc_oCnt.chk_4c_Generico
1918:             .Top       = 37
1919:             .Left      = 18
1920:             .Width     = 99
1921:             .Height    = 15
1922:             .AutoSize  = .T.
1923:             .Alignment = 0
1924:             .BackStyle = 0
1925:             .FontName  = "Tahoma"
1926:             .FontSize  = 8
1927:             .ForeColor = RGB(90, 90, 90)
1928:             .Caption   = "Dados do Cliente"
1929:             .Value     = 1
1930:             .Visible   = .T.
1931:         ENDWITH
1932: 
1933:         loc_oCnt.AddObject("chk_4c_Pessoais", "CheckBox")
1934:         WITH loc_oCnt.chk_4c_Pessoais
1935:             .Top       = 61
1936:             .Left      = 18
1937:             .Width     = 92
1938:             .Height    = 15
1939:             .AutoSize  = .T.
1940:             .Alignment = 0
1941:             .BackStyle = 0
1942:             .FontName  = "Tahoma"
1943:             .FontSize  = 8
1944:             .ForeColor = RGB(90, 90, 90)
1945:             .Caption   = "Dados Pessoais"
1946:             .Value     = 1
1947:             .Visible   = .T.
1948:         ENDWITH
1949: 
1950:         loc_oCnt.AddObject("chk_4c_Bancarias", "CheckBox")
1951:         WITH loc_oCnt.chk_4c_Bancarias
1952:             .Top       = 85
1953:             .Left      = 18
1954:             .Width     = 124
1955:             .Height    = 15
1956:             .AutoSize  = .T.
1957:             .Alignment = 0
1958:             .BackStyle = 0
1959:             .FontName  = "Tahoma"
1960:             .FontSize  = 8
1961:             .ForeColor = RGB(90, 90, 90)
1962:             .Caption   = "Refer" + CHR(234) + "ncias Banc" + CHR(225) + "rias"
1963:             .Value     = 1
1964:             .Visible   = .T.
1965:         ENDWITH
1966: 
1967:         loc_oCnt.AddObject("chk_4c_Followup", "CheckBox")
1968:         WITH loc_oCnt.chk_4c_Followup
1969:             .Top       = 109
1970:             .Left      = 18
1971:             .Width     = 64
1972:             .Height    = 15
1973:             .AutoSize  = .T.
1974:             .Alignment = 0
1975:             .BackStyle = 0
1976:             .FontName  = "Tahoma"
1977:             .FontSize  = 8
1978:             .ForeColor = RGB(90, 90, 90)
1979:             .Caption   = "Follow-up"
1980:             .Value     = 1
1981:             .Visible   = .T.
1982:         ENDWITH
1983: 
1984:         loc_oCnt.AddObject("chk_4c_Impressora", "CheckBox")
1985:         WITH loc_oCnt.chk_4c_Impressora
1986:             .Top       = 133
1987:             .Left      = 18
1988:             .Width     = 126
1989:             .Height    = 15
1990:             .AutoSize  = .T.
1991:             .Alignment = 0
1992:             .BackStyle = 0
1993:             .FontName  = "Tahoma"
1994:             .FontSize  = 8
1995:             .ForeColor = RGB(90, 90, 90)
1996:             .Caption   = "Impressora 40 colunas"
1997:             .Value     = 1
1998:             .Visible   = .T.
1999:         ENDWITH
2000: 
2001:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
2002:         WITH loc_oCnt.cmd_4c_Visualizar
2003:             .Top             = 5
2004:             .Left            = 231
2005:             .Width           = 75
2006:             .Height          = 75
2007:             .FontBold        = .T.
2008:             .FontItalic      = .T.
2009:             .FontName        = "Comic Sans MS"
2010:             .PicturePosition = 13
2011:             .Caption         = "V" + CHR(237) + "deo"
2012:             .ForeColor       = RGB(90, 90, 90)
2013:             .BackColor       = RGB(255, 255, 255)
2014:             .Themes          = .F.
2015:             IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
2016:                 .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
2017:             ENDIF
2018:             .Visible = .T.
2019:         ENDWITH
2020: 
2021:         loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
2022:         WITH loc_oCnt.cmd_4c_Imprimir
2023:             .Top             = 5
2024:             .Left            = 306
2025:             .Width           = 75
2026:             .Height          = 75
2027:             .FontBold        = .T.
2028:             .FontItalic      = .T.
2029:             .FontName        = "Comic Sans MS"
2030:             .WordWrap        = .F.
2031:             .PicturePosition = 13
2032:             .Caption         = " Impressora    "
2033:             .ForeColor       = RGB(90, 90, 90)
2034:             .BackColor       = RGB(255, 255, 255)
2035:             .Themes          = .F.
2036:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
2037:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2038:             ENDIF
2039:             .Visible = .T.
2040:         ENDWITH
2041: 
2042:         loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
2043:         WITH loc_oCnt.cmd_4c_Saida
2044:             .Top        = 5
2045:             .Left        = 379
2046:             .Width       = 75
2047:             .Height      = 75
2048:             .FontBold    = .T.
2049:             .FontItalic  = .T.
2050:             .FontName    = "Comic Sans MS"
2051:             .FontSize    = 8
2052:             .Cancel      = .T.
2053:             .Caption     = "Encerrar"
2054:             .ForeColor   = RGB(90, 90, 90)
2055:             .BackColor   = RGB(255, 255, 255)
2056:             .Themes      = .F.
2057:             IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
2058:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2059:             ENDIF
2060:             .Visible = .T.
2061:         ENDWITH
2062: 
2063:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpCadVisualizarClick")
2064:         BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpCadImprimirClick")
2065:         BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpCadSaidaClick")
2066:     ENDPROC
2067: 
2068:     *==========================================================================
2069:     * ConfigurarPainelImpressaoMovimento - SelecionaImpress?o do legado:
2070:     * painel completo (14 checkboxes + periodo de produtos adquiridos) usado
2071:     * quando Imprime eh acionado na visao MOVIMENTO.
2072:     *==========================================================================
2073:     PROTECTED PROCEDURE ConfigurarPainelImpressaoMovimento(par_oPg)
2074:         LOCAL loc_oCnt, loc_oProd
2075:         par_oPg.AddObject("cnt_4c_SelecionaImpressao", "Container")
2076:         loc_oCnt = par_oPg.cnt_4c_SelecionaImpressao
2077: 
2078:         WITH loc_oCnt
2079:             .Top           = 145
2080:             .Left          = 295
2081:             .Width         = 409
2082:             .Height        = 315
2083:             .SpecialEffect = 0
2084:             .BackColor     = RGB(255, 255, 255)
2085:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
2086:                 .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
2087:             ENDIF
2088:             .Visible = .F.
2089:         ENDWITH
2090: 
2091:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
2092:         WITH loc_oCnt.lbl_4c_Titulo
2093:             .Top       = 12
2094:             .Left      = 10
2095:             .Width     = 132
2096:             .Height    = 15
2097:             .AutoSize  = .T.
2098:             .FontBold  = .T.
2099:             .FontName  = "Tahoma"
2100:             .FontSize  = 8
2101:             .BackStyle = 0
2102:             .ForeColor = RGB(90, 90, 90)
2103:             .Caption   = "Impress" + CHR(227) + "o da Consulta"
2104:             .Visible   = .T.
2105:         ENDWITH
2106: 
2107:         loc_oCnt.AddObject("chk_4c_Saldo", "CheckBox")
2108:         WITH loc_oCnt.chk_4c_Saldo
2109:             .Top       = 88
2110:             .Left      = 10
2111:             .Width     = 137
2112:             .Height    = 15
2113:             .AutoSize  = .T.
2114:             .Alignment = 0
2115:             .BackStyle = 0
2116:             .FontName  = "Tahoma"
2117:             .FontSize  = 8
2118:             .ForeColor = RGB(90, 90, 90)
2119:             .Caption   = "Saldo de Conta Corrente"
2120:             .Value     = 0
2121:             .Visible   = .T.
2122:         ENDWITH
2123: 
2124:         loc_oCnt.AddObject("chk_4c_Limite", "CheckBox")
2125:         WITH loc_oCnt.chk_4c_Limite
2126:             .Top       = 112
2127:             .Left      = 10
2128:             .Width     = 98
2129:             .Height    = 15
2130:             .AutoSize  = .T.
2131:             .Alignment = 0
2132:             .BackStyle = 0
2133:             .FontName  = "Tahoma"
2134:             .FontSize  = 8
2135:             .ForeColor = RGB(90, 90, 90)
2136:             .Caption   = "Limite de Cr" + CHR(233) + "dito"
2137:             .Value     = 0
2138:             .Visible   = .T.
2139:         ENDWITH
2140: 
2141:         loc_oCnt.AddObject("chk_4c_ChqPend", "CheckBox")
2142:         WITH loc_oCnt.chk_4c_ChqPend
2143:             .Top       = 136
2144:             .Left      = 10
2145:             .Width     = 114
2146:             .Height    = 15
2147:             .AutoSize  = .T.
2148:             .Alignment = 0
2149:             .BackStyle = 0
2150:             .FontName  = "Tahoma"
2151:             .FontSize  = 8
2152:             .ForeColor = RGB(90, 90, 90)
2153:             .Caption   = "Cheques Pendentes"
2154:             .Value     = 0
2155:             .Visible   = .T.
2156:         ENDWITH
2157: 
2158:         loc_oCnt.AddObject("chk_4c_ChqDev", "CheckBox")
2159:         WITH loc_oCnt.chk_4c_ChqDev
2160:             .Top       = 162
2161:             .Left      = 10
2162:             .Width     = 115
2163:             .Height    = 15
2164:             .AutoSize  = .T.
2165:             .Alignment = 0
2166:             .BackStyle = 0
2167:             .FontName  = "Tahoma"
2168:             .FontSize  = 8
2169:             .ForeColor = RGB(90, 90, 90)
2170:             .Caption   = "Cheques Devolvidos"
2171:             .Value     = 0
2172:             .Visible   = .T.
2173:         ENDWITH
2174: 
2175:         loc_oCnt.AddObject("chk_4c_ChqDep", "CheckBox")
2176:         WITH loc_oCnt.chk_4c_ChqDep
2177:             .Top       = 185
2178:             .Left      = 10
2179:             .Width     = 122
2180:             .Height    = 15
2181:             .AutoSize  = .T.
2182:             .Alignment = 0
2183:             .BackStyle = 0
2184:             .FontName  = "Tahoma"
2185:             .FontSize  = 8
2186:             .ForeColor = RGB(90, 90, 90)
2187:             .Caption   = "Cheques Depositados"
2188:             .Value     = 0
2189:             .Visible   = .T.
2190:         ENDWITH
2191: 
2192:         loc_oCnt.AddObject("chk_4c_Negociado", "CheckBox")
2193:         WITH loc_oCnt.chk_4c_Negociado
2194:             .Top       = 208
2195:             .Left      = 10
2196:             .Width     = 118
2197:             .Height    = 15
2198:             .AutoSize  = .T.
2199:             .Alignment = 0
2200:             .BackStyle = 0
2201:             .FontName  = "Tahoma"
2202:             .FontSize  = 8
2203:             .ForeColor = RGB(90, 90, 90)
2204:             .Caption   = "Cheques Negociados"
2205:             .Value     = 0
2206:             .Visible   = .T.
2207:         ENDWITH
2208: 
2209:         loc_oCnt.AddObject("chk_4c_Cartao", "CheckBox")
2210:         WITH loc_oCnt.chk_4c_Cartao
2211:             .Top       = 229
2212:             .Left      = 10
2213:             .Width     = 109
2214:             .Height    = 15
2215:             .AutoSize  = .T.
2216:             .Alignment = 0
2217:             .BackStyle = 0
2218:             .FontName  = "Tahoma"
2219:             .FontSize  = 8
2220:             .ForeColor = RGB(90, 90, 90)
2221:             .Caption   = "Cart" + CHR(245) + "es em Aberto"
2222:             .Value     = 0
2223:             .Visible   = .T.
2224:         ENDWITH
2225: 
2226:         loc_oCnt.AddObject("chk_4c_Pend", "CheckBox")
2227:         WITH loc_oCnt.chk_4c_Pend
2228:             .Top       = 250
2229:             .Left      = 10
2230:             .Width     = 72
2231:             .Height    = 15
2232:             .AutoSize  = .T.
2233:             .Alignment = 0
2234:             .BackStyle = 0
2235:             .FontName  = "Tahoma"
2236:             .FontSize  = 8
2237:             .ForeColor = RGB(90, 90, 90)
2238:             .Caption   = "Pend" + CHR(234) + "ncias"
2239:             .Value     = 0
2240:             .Visible   = .T.
2241:         ENDWITH
2242: 
2243:         loc_oCnt.AddObject("chk_4c_Estoque", "CheckBox")
2244:         WITH loc_oCnt.chk_4c_Estoque
2245:             .Top       = 271
2246:             .Left      = 10
2247:             .Width     = 111
2248:             .Height    = 15
2249:             .AutoSize  = .T.
2250:             .Alignment = 0
2251:             .BackStyle = 0
2252:             .FontName  = "Tahoma"
2253:             .FontSize  = 8
2254:             .ForeColor = RGB(90, 90, 90)
2255:             .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Estoque"
2256:             .Value     = 0
2257:             .Visible   = .T.
2258:         ENDWITH
2259: 
2260:         loc_oCnt.AddObject("chk_4c_MovPend", "CheckBox")
2261:         WITH loc_oCnt.chk_4c_MovPend
2262:             .Top       = 135
2263:             .Left      = 191
2264:             .Width     = 146
2265:             .Height    = 15
2266:             .AutoSize  = .T.
2267:             .Alignment = 0
2268:             .BackStyle = 0
2269:             .FontName  = "Tahoma"
2270:             .FontSize  = 8
2271:             .ForeColor = RGB(90, 90, 90)
2272:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es Pendentes"
2273:             .Value     = 0
2274:             .Visible   = .T.
2275:         ENDWITH
2276: 
2277:         loc_oCnt.AddObject("chk_4c_Imp40", "CheckBox")
2278:         WITH loc_oCnt.chk_4c_Imp40
2279:             .Top       = 159
2280:             .Left      = 191
2281:             .Width     = 126
2282:             .Height    = 15
2283:             .AutoSize  = .T.
2284:             .Alignment = 0
2285:             .BackStyle = 0
2286:             .FontName  = "Tahoma"
2287:             .FontSize  = 8
2288:             .ForeColor = RGB(90, 90, 90)
2289:             .Caption   = "Impressora 40 colunas"
2290:             .Value     = 0
2291:             .Visible   = .T.
2292:         ENDWITH
2293: 
2294:         loc_oCnt.AddObject("chk_4c_ResVenda", "CheckBox")
2295:         WITH loc_oCnt.chk_4c_ResVenda
2296:             .Top       = 183
2297:             .Left      = 191
2298:             .Width     = 130
2299:             .Height    = 15
2300:             .AutoSize  = .T.
2301:             .Alignment = 0
2302:             .BackStyle = 0
2303:             .FontName  = "Tahoma"
2304:             .FontSize  = 8
2305:             .ForeColor = RGB(90, 90, 90)
2306:             .Caption   = "Resumo Mensal Vendas"
2307:             .Value     = 1
2308:             .Visible   = .T.
2309:         ENDWITH
2310: 
2311:         loc_oCnt.AddObject("chk_4c_ProdAdq", "CheckBox")
2312:         WITH loc_oCnt.chk_4c_ProdAdq
2313:             .Top       = 209
2314:             .Left      = 191
2315:             .Width     = 173
2316:             .Height    = 15
2317:             .AutoSize  = .T.
2318:             .Alignment = 0
2319:             .BackStyle = 0
2320:             .FontName  = "Tahoma"
2321:             .FontSize  = 8
2322:             .ForeColor = RGB(90, 90, 90)
2323:             .Caption   = "Produtos Adquiridos Pelo Cliente"
2324:             .Value     = 1
2325:             .Visible   = .T.
2326:         ENDWITH
2327: 
2328:         loc_oCnt.AddObject("chk_4c_Producao", "CheckBox")
2329:         WITH loc_oCnt.chk_4c_Producao
2330:             .Top       = 232
2331:             .Left      = 191
2332:             .Width     = 180
2333:             .Height    = 15
2334:             .AutoSize  = .T.
2335:             .Alignment = 0
2336:             .BackStyle = 0
2337:             .FontName  = "Tahoma"
2338:             .FontSize  = 8
2339:             .ForeColor = RGB(90, 90, 90)
2340:             .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Produtos em Produ" + ;
2341:                 CHR(231) + CHR(227) + "o"
2342:             .Value     = 0
2343:             .Visible   = .T.
2344:         ENDWITH
2345: 
2346:         loc_oCnt.AddObject("cnt_4c_ProdAdq", "Container")
2347:         WITH loc_oCnt.cnt_4c_ProdAdq
2348:             .Top           = 255
2349:             .Left          = 199
2350:             .Width         = 191
2351:             .Height        = 47
2352:             .SpecialEffect = 0
2353:             .BackColor     = RGB(255, 255, 255)
2354:             .Visible       = .T.
2355:         ENDWITH
2356:         loc_oProd = loc_oCnt.cnt_4c_ProdAdq
2357: 
2358:         loc_oProd.AddObject("lbl_4c_Titulo", "Label")
2359:         WITH loc_oProd.lbl_4c_Titulo
2360:             .Top       = 3
2361:             .Left      = 6
2362:             .Width     = 150
2363:             .Height    = 15
2364:             .AutoSize  = .T.
2365:             .FontName  = "Tahoma"
2366:             .FontSize  = 8
2367:             .BackStyle = 0
2368:             .ForeColor = RGB(90, 90, 90)
2369:             .Caption   = "Prod.Adquirido No Per" + CHR(237) + "odo de :"
2370:             .Visible   = .T.
2371:         ENDWITH
2372: 
2373:         loc_oProd.AddObject("txt_4c_DtInicial", "TextBox")
2374:         WITH loc_oProd.txt_4c_DtInicial
2375:             .Top           = 20
2376:             .Left          = 7
2377:             .Width         = 80
2378:             .Height        = 23
2379:             .Value         = {}
2380:             .Format        = "K"
2381:             .ForeColor     = RGB(0, 0, 0)
2382:             .SpecialEffect = 1
2383:             .Visible       = .T.
2384:         ENDWITH
2385: 
2386:         loc_oProd.AddObject("lbl_4c_PeriodoAte", "Label")
2387:         WITH loc_oProd.lbl_4c_PeriodoAte
2388:             .Top       = 23
2389:             .Left      = 92
2390:             .Width     = 10
2391:             .Height    = 15
2392:             .AutoSize  = .T.
2393:             .FontName  = "Tahoma"
2394:             .FontSize  = 8
2395:             .BackStyle = 0
2396:             .ForeColor = RGB(90, 90, 90)
2397:             .Caption   = "a"
2398:             .Visible   = .T.
2399:         ENDWITH
2400: 
2401:         loc_oProd.AddObject("txt_4c_DtFinal", "TextBox")
2402:         WITH loc_oProd.txt_4c_DtFinal
2403:             .Top           = 20
2404:             .Left          = 104
2405:             .Width         = 80
2406:             .Height        = 23
2407:             .Value         = {}
2408:             .Format        = "K"
2409:             .ForeColor     = RGB(0, 0, 0)
2410:             .SpecialEffect = 1
2411:             .Visible       = .T.
2412:         ENDWITH
2413: 
2414:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
2415:         WITH loc_oCnt.cmd_4c_Visualizar
2416:             .Top             = 4
2417:             .Left            = 179
2418:             .Width           = 75
2419:             .Height          = 75
2420:             .FontBold        = .T.
2421:             .FontItalic      = .T.
2422:             .FontName        = "Comic Sans MS"
2423:             .WordWrap        = .F.
2424:             .PicturePosition = 13
2425:             .Caption         = "    V" + CHR(237) + "deo            "
2426:             .ForeColor       = RGB(90, 90, 90)
2427:             .BackColor       = RGB(255, 255, 255)
2428:             .Themes          = .F.
2429:             IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
2430:                 .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
2431:             ENDIF
2432:             .Visible = .T.
2433:         ENDWITH
2434: 
2435:         loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
2436:         WITH loc_oCnt.cmd_4c_Imprimir
2437:             .Top             = 4
2438:             .Left            = 254
2439:             .Width           = 75
2440:             .Height          = 75
2441:             .FontBold        = .T.
2442:             .FontItalic      = .T.
2443:             .FontName        = "Comic Sans MS"
2444:             .WordWrap        = .F.
2445:             .PicturePosition = 13
2446:             .Caption         = " Impressora    "
2447:             .ForeColor       = RGB(90, 90, 90)
2448:             .BackColor       = RGB(255, 255, 255)
2449:             .Themes          = .F.
2450:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
2451:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2452:             ENDIF
2453:             .Visible = .T.
2454:         ENDWITH
2455: 
2456:         loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
2457:         WITH loc_oCnt.cmd_4c_Saida
2458:             .Top             = 4
2459:             .Left            = 329
2460:             .Width           = 75
2461:             .Height          = 75
2462:             .FontBold        = .T.
2463:             .FontItalic      = .T.
2464:             .FontName        = "Comic Sans MS"
2465:             .FontSize        = 8
2466:             .Cancel          = .T.
2467:             .PicturePosition = 13
2468:             .Caption         = "Encerrar"
2469:             .ForeColor       = RGB(90, 90, 90)
2470:             .BackColor       = RGB(255, 255, 255)
2471:             .Themes          = .F.
2472:             IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
2473:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2474:             ENDIF
2475:             .Visible = .T.
2476:         ENDWITH
2477: 
2478:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpMovVisualizarClick")
2479:         BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpMovImprimirClick")
2480:         BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpMovSaidaClick")
2481:     ENDPROC
2482: 
2483:     *==========================================================================
2484:     * BtnImprimeClick - Imprime.Click do legado: centraliza o painel de
2485:     * impressao correto (SelecionaImpressao na visao MOVIMENTO,
2486:     * SelecionaImpCad na visao CADASTRO - distincao por cmg_4c_MudaCli.
2487:     * Visible, regra #40: so um dos dois MudaCli/MudaMov fica visivel por
2488:     * vez, e MudaCli visivel = visao MOVIMENTO em curso) e desabilita o
2489:     * resto da tela enquanto o painel esta aberto.
2490:     *==========================================================================
2491:     PROCEDURE BtnImprimeClick()
2492:         LOCAL loc_oPg, loc_oPainel, loc_nLeft, loc_nTop
2493: 
2494:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2495:         loc_oPg.cmd_4c_Imprime.Enabled = .F.
2496: 
2497:         loc_oPainel = IIF(loc_oPg.cmg_4c_MudaCli.Visible, ;
2498:             loc_oPg.cnt_4c_SelecionaImpressao, loc_oPg.cnt_4c_SelecionaImpCad)
2499: 
2500:         loc_nLeft = INT(THIS.Width - loc_oPainel.Width)
2501:         loc_nLeft = IIF(loc_nLeft > 0, INT(loc_nLeft / 2), 0)
2502:         loc_nTop  = INT(THIS.Height - loc_oPainel.Height)
2503:         loc_nTop  = IIF(loc_nTop > 0, INT(loc_nTop / 2), 0)
2504: 
2505:         loc_oPainel.Left    = loc_nLeft
2506:         loc_oPainel.Top     = loc_nTop
2507:         loc_oPainel.Visible = .T.
2508:         loc_oPainel.ZOrder(0)
2509: 
2510:         THIS.DesabilitarControlesImpressao()
2511:     ENDPROC

*-- Linhas 2543 a 2551:
2543:         loc_oPg.cmg_4c_MudaMov.Enabled = .T.
2544:         loc_oPg.cmg_4c_MudaCli.Enabled = .T.
2545:         loc_oPg.cmg_4c_Voltar.Enabled  = .T.
2546:         loc_oPg.cmd_4c_Imprime.Enabled = .T.
2547:     ENDPROC
2548: 
2549:     *==========================================================================
2550:     * BtnImpCadSaidaClick / BtnImpCadVisualizarClick / BtnImpCadImprimirClick
2551:     * Saida/Visualizar/Imprimir.Click do SelecionaImpCad legado.

*-- Linhas 2807 a 2815:
2807:             loc_oPg.cmg_4c_MudaCli.Enabled = loc_lMovimento
2808: 
2809:             *-- Saldo de cashback acompanha a visao cadastral
2810:             loc_oPg.lbl_4c_SaldoCash.Visible = !loc_lMovimento
2811:             loc_oPg.txt_4c_SaldoCash.Visible = !loc_lMovimento
2812: 
2813:             IF loc_lMovimento
2814:                 *-- Abre na aba 1 (Saldo), como o legado faz com ResultPageToSet
2815:                 IF loc_oPg.obj_4c_OptResultado.Value < 1

*-- Linhas 2923 a 2931:
2923:     * Processa()/PCartao()/PEstoque() do legado:
2924:     *
2925:     *   aba 2 Pendencias  - grade TmpPar + grade de formas de pagamento
2926:     *                       (crTmpTipos, com CheckBox marcavel) + total
2927:     *   aba 3 Cheques     - quatro grades (aberto / follow-up / titulos /
2928:     *                       devolvidos) + os nove totais do pe da pagina
2929:     *   aba 4 Cartao      - grade TmpCart (cartoes em aberto)
2930:     *   aba 6 Estoque     - grade dbEstoque (produtos em poder do cliente)
2931:     *

*-- Linhas 2949 a 3033:
2949:     * ConfigurarAbaPendencias - Aba 2 (Result.Pendencias do legado):
2950:     *
2951:     *   Grd_Pendente -> grd_4c_Pendentes  (TmpPar, 6 colunas)
2952:     *   grdTipos     -> grd_4c_TiposPend  (crTmpTipos, CheckBox marcavel)
2953:     *   Cmb_Grupo    -> cbo_4c_GrupoPend  (filtro de grupo)
2954:     *   getTotPends  -> txt_4c_TotPend    (total do que esta visivel na grade)
2955:     *   Anexa        -> cmd_4c_AnexaPend  (abre o documento da pendencia)
2956:     *   CmdImpPend   -> cmd_4c_ImpPend    (listagem SigReIpd)
2957:     *
2958:     * As colunas sao declaradas na ordem de ColumnOrder do dump (vencto, O,
2959:     * valor, moeda, tipo, historico), que eh a ordem em que o legado as mostra.
2960:     *==========================================================================
2961:     PROTECTED PROCEDURE ConfigurarAbaPendencias()
2962:         LOCAL loc_oPg, loc_oGrid
2963:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
2964: 
2965:         loc_oPg.AddObject("shp_4c_Pendencias", "Shape")
2966:         WITH loc_oPg.shp_4c_Pendencias
2967:             .Top         = 42
2968:             .Left        = 18
2969:             .Width       = 735
2970:             .Height      = 413
2971:             .BackStyle   = 0
2972:             .BorderColor = RGB(90, 90, 90)
2973:             .Visible     = .T.
2974:         ENDWITH
2975: 
2976:         loc_oPg.AddObject("lbl_4c_GrupoPend", "Label")
2977:         WITH loc_oPg.lbl_4c_GrupoPend
2978:             .Top       = 53
2979:             .Left      = 42
2980:             .Width     = 41
2981:             .Height    = 15
2982:             .AutoSize  = .F.
2983:             .Alignment = 0
2984:             .FontName  = "Tahoma"
2985:             .FontSize  = 8
2986:             .BackStyle = 0
2987:             .ForeColor = RGB(90, 90, 90)
2988:             .Caption   = "Grupo : "
2989:             .Visible   = .T.
2990:         ENDWITH
2991: 
2992:         loc_oPg.AddObject("cbo_4c_GrupoPend", "ComboBox")
2993:         WITH loc_oPg.cbo_4c_GrupoPend
2994:             .Top           = 49
2995:             .Left          = 85
2996:             .Width         = 300
2997:             .Height        = 24
2998:             .Style         = 2
2999:             .RowSourceType = 0
3000:             .FontName      = "Tahoma"
3001:             .FontSize      = 8
3002:             .ForeColor     = RGB(0, 0, 0)
3003:             .BackColor     = RGB(255, 255, 255)
3004:             .Visible       = .T.
3005:         ENDWITH
3006: 
3007:         loc_oPg.AddObject("lbl_4c_FormaPagto", "Label")
3008:         WITH loc_oPg.lbl_4c_FormaPagto
3009:             .Top       = 41
3010:             .Left      = 813
3011:             .Width     = 70
3012:             .Height    = 15
3013:             .AutoSize  = .F.
3014:             .Alignment = 0
3015:             .FontName  = "Tahoma"
3016:             .FontSize  = 8
3017:             .BackStyle = 0
3018:             .ForeColor = RGB(90, 90, 90)
3019:             .Caption   = "Forma Pagto:"
3020:             .Visible   = .T.
3021:         ENDWITH
3022: 
3023:         *-- Grade das pendencias (TmpPar)
3024:         loc_oPg.AddObject("grd_4c_Pendentes", "Grid")
3025:         loc_oGrid = loc_oPg.grd_4c_Pendentes
3026:         WITH loc_oGrid
3027:             .Top               = 77
3028:             .Left              = 22
3029:             .Width             = 725
3030:             .Height            = 346
3031:             .AllowHeaderSizing = .F.
3032:             .AllowRowSizing    = .F.
3033:             .DeleteMark        = .F.

*-- Linhas 3041 a 3099:
3041: 
3042:             *-- ColumnOrder 1 - vencimento (o legado nao sobrepoe a largura)
3043:             .Columns(1).ControlSource   = "TmpPar.vencs"
3044:             .Columns(1).Header1.Caption = "Vecto"
3045:             .Columns(1).Movable         = .F.
3046:             .Columns(1).Resizable       = .F.
3047:             .Columns(1).ReadOnly        = .T.
3048: 
3049:             *-- ColumnOrder 2 - natureza do lancamento (sem cabecalho no legado)
3050:             .Columns(2).ControlSource   = "TmpPar.Opers"
3051:             .Columns(2).Header1.Caption = ""
3052:             .Columns(2).Width           = 19
3053:             .Columns(2).Movable         = .F.
3054:             .Columns(2).Resizable       = .F.
3055:             .Columns(2).ReadOnly        = .T.
3056: 
3057:             .Columns(3).ControlSource   = "TmpPar.Valos"
3058:             .Columns(3).Header1.Caption = "Valor"
3059:             .Columns(3).Width           = 77
3060:             .Columns(3).Movable         = .F.
3061:             .Columns(3).Resizable       = .F.
3062:             .Columns(3).ReadOnly        = .T.
3063: 
3064:             .Columns(4).ControlSource   = "TmpPar.Moefpgs"
3065:             .Columns(4).Header1.Caption = "Moe"
3066:             .Columns(4).Width           = 30
3067:             .Columns(4).Movable         = .F.
3068:             .Columns(4).Resizable       = .F.
3069:             .Columns(4).ReadOnly        = .T.
3070: 
3071:             .Columns(5).ControlSource   = "TmpPar.FPags"
3072:             .Columns(5).Header1.Caption = "Tipo"
3073:             .Columns(5).Width           = 100
3074:             .Columns(5).Movable         = .F.
3075:             .Columns(5).Resizable       = .F.
3076:             .Columns(5).ReadOnly        = .T.
3077: 
3078:             .Columns(6).ControlSource   = "TmpPar.Hists"
3079:             .Columns(6).Header1.Caption = "Hist" + CHR(243) + "rico"
3080:             .Columns(6).Width           = 360
3081:             .Columns(6).Movable         = .F.
3082:             .Columns(6).Resizable       = .F.
3083:             .Columns(6).ReadOnly        = .T.
3084:         ENDWITH
3085: 
3086:         *-- Grade das formas de pagamento marcaveis (crTmpTipos). A coluna 1 eh
3087:         *-- um CheckBox de verdade: Column.AddObject sozinho NAO exibe o
3088:         *-- controle - precisa de CurrentControl, e de Sparse = .F. para
3089:         *-- aparecer em TODAS as linhas (regra #18)
3090:         loc_oPg.AddObject("grd_4c_TiposPend", "Grid")
3091:         loc_oGrid = loc_oPg.grd_4c_TiposPend
3092:         WITH loc_oGrid
3093:             .Top               = 59
3094:             .Left              = 812
3095:             .Width             = 133
3096:             .Height            = 105
3097:             .FontSize          = 8
3098:             .AllowHeaderSizing = .F.
3099:             .AllowRowSizing    = .F.

*-- Linhas 3108 a 3152:
3108:             .Visible           = .T.
3109:         ENDWITH
3110: 
3111:         loc_oGrid.Columns(1).AddObject("chk_4c_TipoPend", "CheckBox")
3112:         WITH loc_oGrid.Columns(1).chk_4c_TipoPend
3113:             .Top       = 9
3114:             .Left      = 2
3115:             .Width     = 22
3116:             .Height    = 17
3117:             .FontName  = "Arial"
3118:             .FontSize  = 8
3119:             .Alignment = 0
3120:             .Caption   = ""
3121:             .ReadOnly  = .F.
3122:             .Value     = 0
3123:             .Visible   = .T.
3124:         ENDWITH
3125: 
3126:         WITH loc_oGrid
3127:             .Columns(1).CurrentControl   = "chk_4c_TipoPend"
3128:             .Columns(1).Sparse           = .F.
3129:             .Columns(1).ControlSource    = "crTmpTipos.Listas"
3130:             .Columns(1).Header1.Caption  = ""
3131:             .Columns(1).Width            = 15
3132:             .Columns(1).Movable          = .F.
3133:             .Columns(1).Resizable        = .F.
3134:             *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid propaga)
3135:             .Columns(1).ReadOnly         = .F.
3136: 
3137:             .Columns(2).ControlSource    = "crTmpTipos.fPags"
3138:             .Columns(2).Header1.Caption  = "Tipos"
3139:             .Columns(2).Width            = 95
3140:             .Columns(2).FontName         = "Arial"
3141:             .Columns(2).FontSize         = 8
3142:             .Columns(2).Movable          = .F.
3143:             .Columns(2).Resizable        = .F.
3144:             .Columns(2).ReadOnly         = .T.
3145:         ENDWITH
3146: 
3147:         *-- CheckBox de grade nao alterna pelo binding nativo: os quatro
3148:         *-- handlers (Click/MouseDown suprimem o toggle padrao, MouseUp e
3149:         *-- KeyPress alternam por codigo) sao obrigatorios
3150:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "Click", ;
3151:             THIS, "ChkTipoPendClick")
3152:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseDown", ;

*-- Linhas 3159 a 3168:
3159:         *-- Total das pendencias visiveis (getTotPends)
3160:         loc_oPg.AddObject("txt_4c_TotPend", "TextBox")
3161:         WITH loc_oPg.txt_4c_TotPend
3162:             .Top           = 427
3163:             .Left          = 56
3164:             .Width         = 150
3165:             .Height        = 23
3166:             .FontName      = "Tahoma"
3167:             .FontSize      = 8
3168:             .Value         = 0

*-- Linhas 3178 a 3225:
3178:         *-- DisabledPicture + Themes = .T. para o icone desenhar sempre, e o
3179:         *-- botao NUNCA eh desabilitado em runtime - a condicao que o legado
3180:         *-- usava para habilitar/desabilitar vive dentro do proprio handler.
3181:         loc_oPg.AddObject("cmd_4c_AnexaPend", "CommandButton")
3182:         WITH loc_oPg.cmd_4c_AnexaPend
3183:             .Top             = 180
3184:             .Left            = 835
3185:             .Width           = 40
3186:             .Height          = 40
3187:             .FontName        = "Verdana"
3188:             .FontSize        = 8
3189:             .Caption         = ""
3190:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
3191:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
3192:             .ToolTipText     = "Documento"
3193:             .ForeColor       = RGB(36, 84, 155)
3194:             .BackColor       = RGB(255, 255, 255)
3195:             .Themes          = .T.
3196:             .Visible         = .T.
3197:         ENDWITH
3198: 
3199:         loc_oPg.AddObject("cmd_4c_ImpPend", "CommandButton")
3200:         WITH loc_oPg.cmd_4c_ImpPend
3201:             .Top             = 180
3202:             .Left            = 875
3203:             .Width           = 40
3204:             .Height          = 40
3205:             .FontName        = "Verdana"
3206:             .FontSize        = 8
3207:             .Caption         = ""
3208:             .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
3209:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
3210:             .ToolTipText     = "Listagem"
3211:             .ForeColor       = RGB(36, 84, 155)
3212:             .BackColor       = RGB(255, 255, 255)
3213:             .Themes          = .T.
3214:             .Visible         = .T.
3215:         ENDWITH
3216: 
3217:         BINDEVENT(loc_oPg.cbo_4c_GrupoPend, "InteractiveChange", ;
3218:             THIS, "CboGrupoPendInteractiveChange")
3219:         BINDEVENT(loc_oPg.cmd_4c_AnexaPend, "Click", THIS, "BtnAnexaPendClick")
3220:         BINDEVENT(loc_oPg.cmd_4c_ImpPend,   "Click", THIS, "BtnImpPendClick")
3221:     ENDPROC
3222: 
3223:     *==========================================================================
3224:     * ConfigurarAbaCheques - Aba 3 (Result.Cheque do legado). Tem quatro grades
3225:     * e doze campos somente-leitura:

*-- Linhas 3252 a 3325:
3252:         *-- Legenda de cor da grade de cheques em aberto
3253:         loc_oPg.AddObject("shp_4c_LegendaDevolvido", "Shape")
3254:         WITH loc_oPg.shp_4c_LegendaDevolvido
3255:             .Top           = 65
3256:             .Left          = 295
3257:             .Width         = 14
3258:             .Height        = 14
3259:             .BackStyle     = 1
3260:             .SpecialEffect = 0
3261:             .BackColor     = RGB(255, 0, 0)
3262:             .Visible       = .T.
3263:         ENDWITH
3264: 
3265:         loc_oPg.AddObject("shp_4c_LegendaFollowup", "Shape")
3266:         WITH loc_oPg.shp_4c_LegendaFollowup
3267:             .Top           = 65
3268:             .Left          = 196
3269:             .Width         = 14
3270:             .Height        = 14
3271:             .BackStyle     = 1
3272:             .SpecialEffect = 0
3273:             .BackColor     = RGB(220, 255, 220)
3274:             .Visible       = .T.
3275:         ENDWITH
3276: 
3277:         *-- Rotulos
3278:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoCheque",  36,  16,  41, 15, "Grupo : ")
3279:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeAberto", 65,  11,  97, 15, ;
3280:             "Cheques em Aberto")
3281:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeFollow", 65, 499, 100, 15, ;
3282:             "FollowUp do Cheque")
3283:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LegFollowup",  64, 211,  69, 15, ;
3284:             "Com FollowUp")
3285:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LegDevolvido", 64, 310,  49, 15, ;
3286:             "Devolvido")
3287:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeTitulo", 204, 13, 148, 15, ;
3288:             "Cheques Negociados ( titulos )")
3289:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeDevolv", 206, 499, 158, 15, ;
3290:             "Hist" + CHR(243) + "rico de Cheques Devolvidos")
3291:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_HistChqDev",  234, 891, 75, 15, ;
3292:             "Hist. Chq Dev -")
3293:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_MoedaHist",   234, 981, 15, 15, "R$")
3294:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ContasRec",   329, 508, 98, 15, ;
3295:             "Contas a Receber - ")
3296:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_MoedaConta",  328, 608, 15, 15, "R$")
3297:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ObsNegoc",    327,  11, 109, 15, ;
3298:             "Obs. Chq. Negociados")
3299:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LimiteCred",  349, 520, 89, 15, ;
3300:             "Limite de Cr" + CHR(233) + "dito :")
3301:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqAVencer",  371, 531, 78, 15, ;
3302:             "Chqs " + CHR(224) + " Vencer :")
3303:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqVencidos", 393, 531, 78, 15, ;
3304:             "Chqs Vencidos :")
3305:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqDevolv",   417, 521, 88, 15, ;
3306:             "Chqs Devolvidos :")
3307:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_SaldoCC",     371, 783, 56, 15, ;
3308:             "Saldo C/C :")
3309:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqNegoc",    351, 748, 91, 15, ;
3310:             "Chqs Negociados :")
3311:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_VlEstoque",   393, 750, 89, 15, ;
3312:             "Valor em Estoque:")
3313:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LimiteDisp",  416, 752, 87, 15, ;
3314:             "Limite Dispon" + CHR(237) + "vel :")
3315: 
3316:         *-- Filtro de grupo
3317:         loc_oPg.AddObject("cbo_4c_GrupoCheque", "ComboBox")
3318:         WITH loc_oPg.cbo_4c_GrupoCheque
3319:             .Top           = 32
3320:             .Left          = 59
3321:             .Width         = 188
3322:             .Height        = 24
3323:             .Style         = 2
3324:             .RowSourceType = 0
3325:             .FontName      = "Tahoma"

*-- Linhas 3333 a 3342:
3333:         loc_oPg.AddObject("grd_4c_ChequeAberto", "Grid")
3334:         loc_oGrid = loc_oPg.grd_4c_ChequeAberto
3335:         WITH loc_oGrid
3336:             .Top          = 79
3337:             .Left         = 11
3338:             .Width        = 471
3339:             .Height       = 86
3340:             .FontName     = "Courier New"
3341:             .DeleteMark   = .F.
3342:             .RecordMark   = .F.

*-- Linhas 3351 a 3397:
3351:             .Visible      = .T.
3352: 
3353:             .Columns(1).ControlSource   = "dbAberto.vencs"
3354:             .Columns(1).Header1.Caption = "Vencimento"
3355:             .Columns(1).Width           = 80
3356:             .Columns(1).ReadOnly        = .T.
3357: 
3358:             .Columns(2).ControlSource   = "dbAberto.bancos"
3359:             .Columns(2).Header1.Caption = "Bco."
3360:             .Columns(2).Width           = 38
3361:             .Columns(2).Alignment       = 1
3362:             .Columns(2).ReadOnly        = .T.
3363: 
3364:             .Columns(3).ControlSource   = "dbAberto.agencias"
3365:             .Columns(3).Header1.Caption = "Ag."
3366:             .Columns(3).Width           = 45
3367:             .Columns(3).Alignment       = 1
3368:             .Columns(3).ReadOnly        = .T.
3369: 
3370:             .Columns(4).ControlSource   = "dbAberto.ncontas"
3371:             .Columns(4).Header1.Caption = "Conta"
3372:             .Columns(4).Width           = 100
3373:             .Columns(4).ReadOnly        = .T.
3374: 
3375:             .Columns(5).ControlSource   = "dbAberto.ncheques"
3376:             .Columns(5).Header1.Caption = "Cheque"
3377:             .Columns(5).Width           = 65
3378:             .Columns(5).Alignment       = 1
3379:             .Columns(5).ReadOnly        = .T.
3380: 
3381:             .Columns(6).ControlSource   = "dbAberto.valors"
3382:             .Columns(6).Header1.Caption = "Valor"
3383:             .Columns(6).Width           = 115
3384:             .Columns(6).ReadOnly        = .T.
3385:         ENDWITH
3386: 
3387:         *-- Follow-up do cheque corrente (DbFollow)
3388:         loc_oPg.AddObject("grd_4c_ChequeFollowup", "Grid")
3389:         loc_oGrid = loc_oPg.grd_4c_ChequeFollowup
3390:         WITH loc_oGrid
3391:             .Top          = 79
3392:             .Left         = 499
3393:             .Width        = 471
3394:             .Height       = 86
3395:             .FontName     = "Courier New"
3396:             .DeleteMark   = .F.
3397:             .RecordMark   = .F.

*-- Linhas 3406 a 3429:
3406:             .Visible      = .T.
3407: 
3408:             .Columns(1).ControlSource   = "DbFollow.Datas"
3409:             .Columns(1).Header1.Caption = "Data"
3410:             .Columns(1).Width           = 78
3411:             .Columns(1).ReadOnly        = .T.
3412: 
3413:             .Columns(2).ControlSource   = "DbFollow.Hists"
3414:             .Columns(2).Header1.Caption = "Hist" + CHR(243) + "rico"
3415:             .Columns(2).Width           = 370
3416:             .Columns(2).ReadOnly        = .T.
3417:         ENDWITH
3418: 
3419:         *-- Cheques negociados / titulos (DbTitulo)
3420:         loc_oPg.AddObject("grd_4c_ChequeTitulo", "Grid")
3421:         loc_oGrid = loc_oPg.grd_4c_ChequeTitulo
3422:         WITH loc_oGrid
3423:             .Top          = 219
3424:             .Left         = 11
3425:             .Width        = 471
3426:             .Height       = 86
3427:             .FontName     = "Courier New"
3428:             .DeleteMark   = .F.
3429:             .RecordMark   = .F.

*-- Linhas 3438 a 3481:
3438:             .Visible      = .T.
3439: 
3440:             .Columns(1).ControlSource   = "DbTitulo.Titulos"
3441:             .Columns(1).Header1.Caption = "Titulo"
3442:             .Columns(1).Width           = 80
3443:             .Columns(1).ReadOnly        = .T.
3444: 
3445:             .Columns(2).ControlSource   = "DbTitulo.Vencs"
3446:             .Columns(2).Header1.Caption = "Vencto"
3447:             .Columns(2).Width           = 80
3448:             .Columns(2).ReadOnly        = .T.
3449: 
3450:             .Columns(3).ControlSource   = "DbTitulo.Valors"
3451:             .Columns(3).Header1.Caption = "Valor"
3452:             .Columns(3).Width           = 85
3453:             .Columns(3).ReadOnly        = .T.
3454: 
3455:             .Columns(4).ControlSource   = "DbTitulo.ValPags"
3456:             .Columns(4).Header1.Caption = "V.Pago"
3457:             .Columns(4).Width           = 85
3458:             .Columns(4).ReadOnly        = .T.
3459: 
3460:             .Columns(5).ControlSource   = "DbTitulo.Saldos"
3461:             .Columns(5).Header1.Caption = "Saldo"
3462:             .Columns(5).Width           = 80
3463:             .Columns(5).ReadOnly        = .T.
3464: 
3465:             .Columns(6).ControlSource   = "DbTitulo.Moedas"
3466:             .Columns(6).Header1.Caption = "Moe"
3467:             .Columns(6).Width           = 28
3468:             .Columns(6).ReadOnly        = .T.
3469:         ENDWITH
3470: 
3471:         *-- Historico de cheques devolvidos (dbDevolvido)
3472:         loc_oPg.AddObject("grd_4c_ChequeDevolvido", "Grid")
3473:         loc_oGrid = loc_oPg.grd_4c_ChequeDevolvido
3474:         WITH loc_oGrid
3475:             .Top          = 220
3476:             .Left         = 499
3477:             .Width        = 386
3478:             .Height       = 86
3479:             .FontName     = "Courier New"
3480:             .DeleteMark   = .F.
3481:             .RecordMark   = .F.

*-- Linhas 3490 a 3526:
3490:             .Visible      = .T.
3491: 
3492:             .Columns(1).ControlSource   = "dbDevolvido.vencs"
3493:             .Columns(1).Header1.Caption = "Vencimento"
3494:             .Columns(1).Width           = 80
3495:             .Columns(1).ReadOnly        = .T.
3496: 
3497:             .Columns(2).ControlSource   = "dbDevolvido.bancos"
3498:             .Columns(2).Header1.Caption = "Bco."
3499:             .Columns(2).Width           = 31
3500:             .Columns(2).Alignment       = 1
3501:             .Columns(2).ReadOnly        = .T.
3502: 
3503:             .Columns(3).ControlSource   = "dbDevolvido.agencias"
3504:             .Columns(3).Header1.Caption = "Ag."
3505:             .Columns(3).Width           = 38
3506:             .Columns(3).Alignment       = 1
3507:             .Columns(3).ReadOnly        = .T.
3508: 
3509:             .Columns(4).ControlSource   = "dbDevolvido.ncontas"
3510:             .Columns(4).Header1.Caption = "Conta"
3511:             .Columns(4).Width           = 80
3512:             .Columns(4).ReadOnly        = .T.
3513: 
3514:             .Columns(5).ControlSource   = "dbDevolvido.ncheques"
3515:             .Columns(5).Header1.Caption = "Cheque"
3516:             .Columns(5).Width           = 52
3517:             .Columns(5).Alignment       = 1
3518:             .Columns(5).ReadOnly        = .T.
3519: 
3520:             .Columns(6).ControlSource   = "dbDevolvido.valors"
3521:             .Columns(6).Header1.Caption = "Valor"
3522:             .Columns(6).Width           = 80
3523:             .Columns(6).ReadOnly        = .T.
3524:         ENDWITH
3525: 
3526:         *-- Campos somente-leitura: total da grade de aberto, historico de

*-- Linhas 3557 a 3572:
3557: 
3558:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_CartaoAberto", 56, 132, 735, 274)
3559: 
3560:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_CartaoAberto", 57, 139, 93, 15, ;
3561:             "Cart" + CHR(245) + "es em Aberto")
3562: 
3563:         loc_oPg.AddObject("grd_4c_Cartao", "Grid")
3564:         loc_oGrid = loc_oPg.grd_4c_Cartao
3565:         WITH loc_oGrid
3566:             .Top          = 72
3567:             .Left         = 137
3568:             .Width        = 725
3569:             .Height       = 254
3570:             .FontName     = "Courier New"
3571:             .DeleteMark   = .F.
3572:             .RecordMark   = .F.

*-- Linhas 3580 a 3618:
3580:             .Visible      = .T.
3581: 
3582:             .Columns(1).ControlSource   = "TmpCart.vencs"
3583:             .Columns(1).Header1.Caption = "Vencimento"
3584:             .Columns(1).Width           = 75
3585:             .Columns(1).Alignment       = 0
3586:             .Columns(1).ReadOnly        = .T.
3587: 
3588:             .Columns(2).ControlSource   = "TmpCart.fpags"
3589:             .Columns(2).Header1.Caption = "Cart" + CHR(227) + "o"
3590:             .Columns(2).Width           = 100
3591:             .Columns(2).Alignment       = 0
3592:             .Columns(2).ReadOnly        = .T.
3593: 
3594:             .Columns(3).ControlSource   = "TmpCart.nocreditos"
3595:             .Columns(3).Header1.Caption = "Cr" + CHR(233) + "dito"
3596:             .Columns(3).Width           = 80
3597:             .Columns(3).Alignment       = 0
3598:             .Columns(3).ReadOnly        = .T.
3599: 
3600:             .Columns(4).ControlSource   = "TmpCart.cartaos"
3601:             .Columns(4).Header1.Caption = "N" + CHR(186) + " Cart" + CHR(227) + "o"
3602:             .Columns(4).Width           = 120
3603:             .Columns(4).Alignment       = 0
3604:             .Columns(4).ReadOnly        = .T.
3605: 
3606:             .Columns(5).ControlSource   = "TmpCart.valos"
3607:             .Columns(5).Header1.Caption = "Valor"
3608:             .Columns(5).Width           = 110
3609:             .Columns(5).Alignment       = 3
3610:             .Columns(5).ReadOnly        = .T.
3611: 
3612:             .Columns(6).ControlSource   = "TmpCart.datas"
3613:             .Columns(6).Header1.Caption = "Data"
3614:             .Columns(6).Width           = 75
3615:             .Columns(6).Alignment       = 0
3616:             .Columns(6).ReadOnly        = .T.
3617:         ENDWITH
3618:     ENDPROC

*-- Linhas 3632 a 3645:
3632: 
3633:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_EstoqueProduto", 86, 303, 392, 361)
3634: 
3635:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoEstoque", 60, 307, 41, 15, "Grupo : ")
3636: 
3637:         loc_oPg.AddObject("cbo_4c_GrupoEstoque", "ComboBox")
3638:         WITH loc_oPg.cbo_4c_GrupoEstoque
3639:             .Top           = 56
3640:             .Left          = 350
3641:             .Width         = 300
3642:             .Height        = 24
3643:             .Style         = 2
3644:             .RowSourceType = 0
3645:             .FontName      = "Tahoma"

*-- Linhas 3652 a 3661:
3652:         loc_oPg.AddObject("grd_4c_Estoque", "Grid")
3653:         loc_oGrid = loc_oPg.grd_4c_Estoque
3654:         WITH loc_oGrid
3655:             .Top          = 92
3656:             .Left         = 308
3657:             .Width        = 381
3658:             .Height       = 347
3659:             .FontName     = "Courier New"
3660:             .DeleteMark   = .F.
3661:             .RecordMark   = .F.

*-- Linhas 3669 a 3689:
3669:             .Visible      = .T.
3670: 
3671:             .Columns(1).ControlSource   = "dbEstoque.cpros"
3672:             .Columns(1).Header1.Caption = "Produto"
3673:             .Columns(1).Width           = 108
3674:             .Columns(1).Alignment       = 3
3675:             .Columns(1).ReadOnly        = .T.
3676: 
3677:             .Columns(2).ControlSource   = "dbEstoque.sqtds"
3678:             .Columns(2).Header1.Caption = "Qtde."
3679:             .Columns(2).Width           = 100
3680:             .Columns(2).Alignment       = 3
3681:             .Columns(2).InputMask       = "999,999,999.99"
3682:             .Columns(2).ReadOnly        = .T.
3683: 
3684:             .Columns(3).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
3685:             .Columns(3).Width           = 150
3686:             .Columns(3).Alignment       = 3
3687:             .Columns(3).ReadOnly        = .T.
3688:         ENDWITH
3689: 

*-- Linhas 3710 a 3719:
3710:         loc_oPg.AddObject("grd_4c_HistCheque", "Grid")
3711:         loc_oGrid = loc_oPg.grd_4c_HistCheque
3712:         WITH loc_oGrid
3713:             .Top          = 57
3714:             .Left         = 152
3715:             .Width        = 696
3716:             .Height       = 124
3717:             .FontName     = "Courier New"
3718:             .DeleteMark   = .F.
3719:             .RecordMark   = .F.

*-- Linhas 3727 a 3787:
3727:             .Visible      = .T.
3728: 
3729:             .Columns(1).ControlSource   = "dbCheqHist.Vencs"
3730:             .Columns(1).Header1.Caption = "Vencimento"
3731:             .Columns(1).Width           = 75
3732:             .Columns(1).ReadOnly        = .T.
3733: 
3734:             .Columns(2).ControlSource   = "dbCheqHist.Bancos"
3735:             .Columns(2).Header1.Caption = "Banco"
3736:             .Columns(2).Width           = 50
3737:             .Columns(2).ReadOnly        = .T.
3738: 
3739:             .Columns(3).ControlSource   = "dbCheqHist.Agencias"
3740:             .Columns(3).Header1.Caption = "Agencia"
3741:             .Columns(3).Width           = 55
3742:             .Columns(3).ReadOnly        = .T.
3743: 
3744:             .Columns(4).ControlSource   = "dbCheqHist.NContas"
3745:             .Columns(4).Header1.Caption = "Conta"
3746:             .Columns(4).Width           = 70
3747:             .Columns(4).ReadOnly        = .T.
3748: 
3749:             .Columns(5).ControlSource   = "dbCheqHist.NCheques"
3750:             .Columns(5).Header1.Caption = "N" + CHR(186) + "mero"
3751:             .Columns(5).Width           = 60
3752:             .Columns(5).ReadOnly        = .T.
3753: 
3754:             .Columns(6).ControlSource   = "dbCheqHist.Valors"
3755:             .Columns(6).Header1.Caption = "Valor"
3756:             .Columns(6).Width           = 75
3757:             .Columns(6).Alignment       = 3
3758:             .Columns(6).InputMask       = "999,999,999.99"
3759:             .Columns(6).ReadOnly        = .T.
3760: 
3761:             .Columns(7).ControlSource   = "dbCheqHist.GruCarts"
3762:             .Columns(7).Header1.Caption = "Grupo Carteira"
3763:             .Columns(7).Width           = 70
3764:             .Columns(7).ReadOnly        = .T.
3765: 
3766:             .Columns(8).ControlSource   = "dbCheqHist.ConCarts"
3767:             .Columns(8).Header1.Caption = "Conta Carteira"
3768:             .Columns(8).Width           = 70
3769:             .Columns(8).ReadOnly        = .T.
3770: 
3771:             .Columns(9).ControlSource   = "dbCheqHist.Emps"
3772:             .Columns(9).Header1.Caption = "Emp"
3773:             .Columns(9).Width           = 40
3774:             .Columns(9).ReadOnly        = .T.
3775: 
3776:             .Columns(10).ControlSource   = "dbCheqHist.Numeros"
3777:             .Columns(10).Header1.Caption = "Arquivo"
3778:             .Columns(10).Width           = 60
3779:             .Columns(10).ReadOnly        = .T.
3780: 
3781:             .Columns(11).ControlSource   = "dbCheqHist.DiasP"
3782:             .Columns(11).Header1.Caption = "Dias Pag."
3783:             .Columns(11).Width           = 55
3784:             .Columns(11).Alignment       = 3
3785:             .Columns(11).ReadOnly        = .T.
3786: 
3787:             *-- SetAll('DynamicForeColor'/'DynamicBackColor', ...) do legado:

*-- Linhas 3797 a 3806:
3797:         loc_oPg.AddObject("grd_4c_MovCheque", "Grid")
3798:         loc_oGrid = loc_oPg.grd_4c_MovCheque
3799:         WITH loc_oGrid
3800:             .Top          = 182
3801:             .Left         = 152
3802:             .Width        = 696
3803:             .Height       = 90
3804:             .FontName     = "Courier New"
3805:             .DeleteMark   = .F.
3806:             .RecordMark   = .F.

*-- Linhas 3814 a 3872:
3814:             .Visible      = .T.
3815: 
3816:             .Columns(1).ControlSource   = "dbCheqMovim.Codigos"
3817:             .Columns(1).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
3818:             .Columns(1).Width           = 80
3819:             .Columns(1).ReadOnly        = .T.
3820: 
3821:             .Columns(2).ControlSource   = "dbCheqMovim.Nalineas"
3822:             .Columns(2).Header1.Caption = "Alinea"
3823:             .Columns(2).Width           = 60
3824:             .Columns(2).ReadOnly        = .T.
3825: 
3826:             .Columns(3).ControlSource   = "dbCheqMovim.Dtents"
3827:             .Columns(3).Header1.Caption = "Entrada"
3828:             .Columns(3).Width           = 80
3829:             .Columns(3).ReadOnly        = .T.
3830: 
3831:             .Columns(4).ControlSource   = "dbCheqMovim.Gruorigs"
3832:             .Columns(4).Header1.Caption = "Grupo/Origem"
3833:             .Columns(4).Width           = 80
3834:             .Columns(4).ReadOnly        = .T.
3835: 
3836:             .Columns(5).ControlSource   = "dbCheqMovim.Conorigs"
3837:             .Columns(5).Header1.Caption = "Conta/Origem"
3838:             .Columns(5).Width           = 80
3839:             .Columns(5).ReadOnly        = .T.
3840: 
3841:             .Columns(6).ControlSource   = "dbCheqMovim.Grupos"
3842:             .Columns(6).Header1.Caption = "Grupo/Destino"
3843:             .Columns(6).Width           = 80
3844:             .Columns(6).ReadOnly        = .T.
3845: 
3846:             .Columns(7).ControlSource   = "dbCheqMovim.Contas"
3847:             .Columns(7).Header1.Caption = "Conta/Destino"
3848:             .Columns(7).Width           = 80
3849:             .Columns(7).ReadOnly        = .T.
3850: 
3851:             .Columns(8).ControlSource   = "dbCheqMovim.Numlotes"
3852:             .Columns(8).Header1.Caption = "Lote"
3853:             .Columns(8).Width           = 70
3854:             .Columns(8).ReadOnly        = .T.
3855: 
3856:             .Columns(9).ControlSource   = "dbCheqMovim.Protocolos"
3857:             .Columns(9).Header1.Caption = "Protocolo"
3858:             .Columns(9).Width           = 86
3859:             .Columns(9).ReadOnly        = .T.
3860:         ENDWITH
3861: 
3862:         *-- GradeProrrog (dbCheqProrrog) - prorrogacoes do cheque selecionado
3863:         loc_oPg.AddObject("grd_4c_ProrrogCheque", "Grid")
3864:         loc_oGrid = loc_oPg.grd_4c_ProrrogCheque
3865:         WITH loc_oGrid
3866:             .Top          = 273
3867:             .Left         = 735
3868:             .Width        = 113
3869:             .Height       = 84
3870:             .FontName     = "Courier New"
3871:             .DeleteMark   = .F.
3872:             .RecordMark   = .F.

*-- Linhas 3880 a 3907:
3880:             .Visible      = .T.
3881: 
3882:             .Columns(1).ControlSource   = "dbCheqProrrog.Vencs"
3883:             .Columns(1).Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
3884:             .Columns(1).Width           = 108
3885:             .Columns(1).ReadOnly        = .T.
3886:         ENDWITH
3887: 
3888:         *-- Follow-up da linha corrente (Cnt_Followup.UltFollowup)
3889:         loc_oPg.AddObject("cnt_4c_Followup", "Container")
3890:         WITH loc_oPg.cnt_4c_Followup
3891:             .Top       = 273
3892:             .Left      = 151
3893:             .Width     = 561
3894:             .Height    = 43
3895:             .BackStyle = 0
3896:             .Visible   = .T.
3897:         ENDWITH
3898:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_Followup, "lbl_4c_Followup", 1, 8, 54, 15, "Follow_up:")
3899:         loc_oPg.cnt_4c_Followup.AddObject("txt_4c_UltFollowup", "TextBox")
3900:         WITH loc_oPg.cnt_4c_Followup.txt_4c_UltFollowup
3901:             .Top           = 19
3902:             .Left          = 5
3903:             .Width         = 550
3904:             .Height        = 20
3905:             .Value         = ""
3906:             .ReadOnly      = .T.
3907:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 3913 a 3972:
3913:         *-- ficam so por fidelidade estrutural, sem BINDEVENT.
3914:         loc_oPg.AddObject("cnt_4c_DescricaoCheque", "Container")
3915:         WITH loc_oPg.cnt_4c_DescricaoCheque
3916:             .Top       = 319
3917:             .Left      = 151
3918:             .Width     = 457
3919:             .Height    = 46
3920:             .BackStyle = 0
3921:             .Visible   = .F.
3922:         ENDWITH
3923:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Origem", 4, 9, 46, 15, "Origem :")
3924:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Destino", 24, 7, 48, 15, "Destino :")
3925:         loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescOrigem", "TextBox")
3926:         WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescOrigem
3927:             .Top     = 3
3928:             .Left    = 57
3929:             .Width   = 386
3930:             .Height  = 20
3931:             .Value   = ""
3932:             .Visible = .T.
3933:         ENDWITH
3934:         loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescDestino", "TextBox")
3935:         WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescDestino
3936:             .Top     = 22
3937:             .Left    = 57
3938:             .Width   = 386
3939:             .Height  = 20
3940:             .Value   = ""
3941:             .Visible = .T.
3942:         ENDWITH
3943: 
3944:         loc_oPg.AddObject("cnt_4c_PeriodoCheque", "Container")
3945:         WITH loc_oPg.cnt_4c_PeriodoCheque
3946:             .Top       = 368
3947:             .Left      = 151
3948:             .Width     = 280
3949:             .Height    = 36
3950:             .BackStyle = 0
3951:             .Visible   = .F.
3952:         ENDWITH
3953:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_PeriodoCheque, "lbl_4c_PeriodoCheque", 10, 26, 67, 15, "Vencimento : ")
3954:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_PeriodoCheque, "lbl_4c_PeriodoChequeA", 10, 180, 8, 15, "a")
3955:         loc_oPg.cnt_4c_PeriodoCheque.AddObject("txt_4c_PeriodoCheqIni", "TextBox")
3956:         WITH loc_oPg.cnt_4c_PeriodoCheque.txt_4c_PeriodoCheqIni
3957:             .Top     = 6
3958:             .Left    = 95
3959:             .Width   = 80
3960:             .Height  = 21
3961:             .Value   = {}
3962:             .Visible = .T.
3963:         ENDWITH
3964:         loc_oPg.cnt_4c_PeriodoCheque.AddObject("txt_4c_PeriodoCheqFim", "TextBox")
3965:         WITH loc_oPg.cnt_4c_PeriodoCheque.txt_4c_PeriodoCheqFim
3966:             .Top     = 6
3967:             .Left    = 192
3968:             .Width   = 80
3969:             .Height  = 21
3970:             .Value   = {}
3971:             .Visible = .T.
3972:         ENDWITH

*-- Linhas 3984 a 4163:
3984:         LOCAL loc_oPg, loc_oCns, loc_oGrid
3985:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page10
3986: 
3987:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_SituacaoCredito", 53, 3, 996, 47, "CLIENTE")
3988:         loc_oPg.lbl_4c_SituacaoCredito.FontName = "Tahoma"
3989:         loc_oPg.lbl_4c_SituacaoCredito.FontSize = 10
3990:         loc_oPg.lbl_4c_SituacaoCredito.FontBold = .T.
3991:         loc_oPg.lbl_4c_SituacaoCredito.ForeColor = RGB(0, 0, 255)
3992: 
3993:         loc_oPg.AddObject("pgf_4c_Credito", "PageFrame")
3994:         WITH loc_oPg.pgf_4c_Credito
3995:             .Top       = 96
3996:             .Left      = 0
3997:             .Width     = 1003
3998:             .Height    = 408
3999:             .PageCount = 1
4000:             .Tabs      = .F.
4001:             .Themes    = .F.
4002:             .Visible   = .T.
4003:             .Page1.Caption = "Consultas"
4004:         ENDWITH
4005:         loc_oCns = loc_oPg.pgf_4c_Credito.Page1
4006: 
4007:         *-- Cnt_banco
4008:         loc_oCns.AddObject("cnt_4c_CreditoBanco", "Container")
4009:         WITH loc_oCns.cnt_4c_CreditoBanco
4010:             .Top       = 273
4011:             .Left      = 170
4012:             .Width     = 479
4013:             .Height    = 40
4014:             .BackStyle = 0
4015:             .Visible   = .T.
4016:         ENDWITH
4017:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Bco",   1, 6,   30, 15, "Bco")
4018:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Age",   1, 43,  40, 15, "Ag" + CHR(234) + "ncia")
4019:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Cta",   1, 95,  40, 15, "Conta")
4020:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumI",  1, 173, 65, 15, "Num.Inicial")
4021:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumF",  1, 265, 60, 15, "Num.Final")
4022:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Serie", 1, 357, 40, 15, "S" + CHR(233) + "rie")
4023:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_DtAb",  1, 408, 70, 15, "Dt Abertura")
4024:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Dig1",  0, 238, 24, 17, "Dig.")
4025:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Dig2",  0, 327, 24, 17, "Dig.")
4026: 
4027:         WITH loc_oCns.cnt_4c_CreditoBanco
4028:             .AddObject("txt_4c_CBancos", "TextBox")
4029:             .txt_4c_CBancos.Top           = 13
4030:             .txt_4c_CBancos.Left          = 3
4031:             .txt_4c_CBancos.Width         = 36
4032:             .txt_4c_CBancos.Height        = 23
4033:             .txt_4c_CBancos.Value         = ""
4034:             .txt_4c_CBancos.ControlSource = "dbCredito.Cbancos"
4035:             .txt_4c_CBancos.Visible       = .T.
4036: 
4037:             .AddObject("txt_4c_CAgencias", "TextBox")
4038:             .txt_4c_CAgencias.Top           = 13
4039:             .txt_4c_CAgencias.Left          = 47
4040:             .txt_4c_CAgencias.Width         = 38
4041:             .txt_4c_CAgencias.Height        = 23
4042:             .txt_4c_CAgencias.Value         = ""
4043:             .txt_4c_CAgencias.ControlSource = "dbCredito.Cagencias"
4044:             .txt_4c_CAgencias.Visible       = .T.
4045: 
4046:             .AddObject("txt_4c_CContas", "TextBox")
4047:             .txt_4c_CContas.Top           = 13
4048:             .txt_4c_CContas.Left          = 92
4049:             .txt_4c_CContas.Width         = 80
4050:             .txt_4c_CContas.Height        = 23
4051:             .txt_4c_CContas.Value         = ""
4052:             .txt_4c_CContas.ControlSource = "dbCredito.Ccontas"
4053:             .txt_4c_CContas.Visible       = .T.
4054: 
4055:             .AddObject("txt_4c_CCheInis", "TextBox")
4056:             .txt_4c_CCheInis.Top           = 13
4057:             .txt_4c_CCheInis.Left          = 177
4058:             .txt_4c_CCheInis.Width         = 52
4059:             .txt_4c_CCheInis.Height        = 23
4060:             .txt_4c_CCheInis.Value         = ""
4061:             .txt_4c_CCheInis.ControlSource = "dbCredito.Ccheinis"
4062:             .txt_4c_CCheInis.Visible       = .T.
4063: 
4064:             .AddObject("txt_4c_CDigInis", "TextBox")
4065:             .txt_4c_CDigInis.Top           = 13
4066:             .txt_4c_CDigInis.Left          = 240
4067:             .txt_4c_CDigInis.Width         = 17
4068:             .txt_4c_CDigInis.Height        = 23
4069:             .txt_4c_CDigInis.Value         = ""
4070:             .txt_4c_CDigInis.ControlSource = "dbCredito.Cdiginis"
4071:             .txt_4c_CDigInis.Visible       = .T.
4072: 
4073:             .AddObject("txt_4c_CCheFins", "TextBox")
4074:             .txt_4c_CCheFins.Top           = 13
4075:             .txt_4c_CCheFins.Left          = 268
4076:             .txt_4c_CCheFins.Width         = 52
4077:             .txt_4c_CCheFins.Height        = 23
4078:             .txt_4c_CCheFins.Value         = ""
4079:             .txt_4c_CCheFins.ControlSource = "dbCredito.Cchefins"
4080:             .txt_4c_CCheFins.Visible       = .T.
4081: 
4082:             .AddObject("txt_4c_CDigFins", "TextBox")
4083:             .txt_4c_CDigFins.Top           = 13
4084:             .txt_4c_CDigFins.Left          = 329
4085:             .txt_4c_CDigFins.Width         = 17
4086:             .txt_4c_CDigFins.Height        = 23
4087:             .txt_4c_CDigFins.Value         = ""
4088:             .txt_4c_CDigFins.ControlSource = "dbCredito.Cdigfins"
4089:             .txt_4c_CDigFins.Visible       = .T.
4090: 
4091:             .AddObject("txt_4c_CSeries", "TextBox")
4092:             .txt_4c_CSeries.Top           = 13
4093:             .txt_4c_CSeries.Left          = 354
4094:             .txt_4c_CSeries.Width         = 52
4095:             .txt_4c_CSeries.Height        = 23
4096:             .txt_4c_CSeries.Value         = ""
4097:             .txt_4c_CSeries.ControlSource = "dbCredito.Cseries"
4098:             .txt_4c_CSeries.Visible       = .T.
4099: 
4100:             .AddObject("txt_4c_CDAberts", "TextBox")
4101:             .txt_4c_CDAberts.Top           = 13
4102:             .txt_4c_CDAberts.Left          = 413
4103:             .txt_4c_CDAberts.Width         = 59
4104:             .txt_4c_CDAberts.Height        = 23
4105:             .txt_4c_CDAberts.Value         = ""
4106:             .txt_4c_CDAberts.ControlSource = "dbCredito.Cdaberts"
4107:             .txt_4c_CDAberts.Visible       = .T.
4108:         ENDWITH
4109: 
4110:         *-- Cnt_Valor
4111:         loc_oCns.AddObject("cnt_4c_CreditoValor", "Container")
4112:         WITH loc_oCns.cnt_4c_CreditoValor
4113:             .Top       = 230
4114:             .Left      = 170
4115:             .Width     = 372
4116:             .Height    = 40
4117:             .BackStyle = 0
4118:             .Visible   = .T.
4119:         ENDWITH
4120:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_ValorCredito", 0, 166, 39, 17, "Valor")
4121:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_DtVenc",       0, 272, 83, 15, "Data Vencimento")
4122:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_CpfCredito",   0, 11,  43, 15, "C.P.F. : ")
4123:         WITH loc_oCns.cnt_4c_CreditoValor
4124:             .AddObject("txt_4c_NrCpf", "TextBox")
4125:             .txt_4c_NrCpf.Top           = 12
4126:             .txt_4c_NrCpf.Left          = 8
4127:             .txt_4c_NrCpf.Width         = 150
4128:             .txt_4c_NrCpf.Height        = 23
4129:             .txt_4c_NrCpf.Value         = ""
4130:             .txt_4c_NrCpf.ControlSource = "dbCredito.Ccpfs"
4131:             .txt_4c_NrCpf.Visible       = .T.
4132: 
4133:             .AddObject("txt_4c_Valor", "TextBox")
4134:             .txt_4c_Valor.Top           = 12
4135:             .txt_4c_Valor.Left          = 166
4136:             .txt_4c_Valor.Width         = 108
4137:             .txt_4c_Valor.Height        = 23
4138:             .txt_4c_Valor.Value         = 0
4139:             .txt_4c_Valor.ControlSource = "dbCredito.Nvalors"
4140:             .txt_4c_Valor.InputMask     = "999,999,999.99"
4141:             .txt_4c_Valor.Visible       = .T.
4142: 
4143:             .AddObject("txt_4c_DtVenc", "TextBox")
4144:             .txt_4c_DtVenc.Top           = 12
4145:             .txt_4c_DtVenc.Left          = 281
4146:             .txt_4c_DtVenc.Width         = 80
4147:             .txt_4c_DtVenc.Height        = 23
4148:             .txt_4c_DtVenc.Value         = {}
4149:             .txt_4c_DtVenc.ControlSource = "dbCredito.Dvencs"
4150:             .txt_4c_DtVenc.Visible       = .T.
4151:         ENDWITH
4152: 
4153:         *-- Grade (crSigFiCp)
4154:         loc_oCns.AddObject("grd_4c_Credito", "Grid")
4155:         loc_oGrid = loc_oCns.grd_4c_Credito
4156:         WITH loc_oGrid
4157:             .Top          = 45
4158:             .Left         = 170
4159:             .Width        = 658
4160:             .Height       = 182
4161:             .FontName     = "Courier New"
4162:             .DeleteMark   = .F.
4163:             .RecordMark   = .F.

*-- Linhas 4171 a 4253:
4171:             .Visible      = .T.
4172: 
4173:             .Columns(1).ControlSource = "dbCredito.Tipos"
4174:             .Columns(1).Header1.Caption = ""
4175:             .Columns(1).Width = 30
4176:             .Columns(1).ReadOnly = .T.
4177: 
4178:             .Columns(2).ControlSource = "dbCredito.Usuars"
4179:             .Columns(2).Header1.Caption = "Usu" + CHR(225) + "rio"
4180:             .Columns(2).Width = 100
4181:             .Columns(2).ReadOnly = .T.
4182: 
4183:             .Columns(3).ControlSource = "dbCredito.Emps"
4184:             .Columns(3).Header1.Caption = "Emp"
4185:             .Columns(3).Width = 50
4186:             .Columns(3).ReadOnly = .T.
4187: 
4188:             .Columns(4).ControlSource = "dbCredito.Datas"
4189:             .Columns(4).Header1.Caption = "Data / Hora"
4190:             .Columns(4).Width = 120
4191:             .Columns(4).ReadOnly = .T.
4192: 
4193:             .Columns(5).ControlSource = "dbCredito.Dopes"
4194:             .Columns(5).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
4195:             .Columns(5).Width = 160
4196:             .Columns(5).ReadOnly = .T.
4197: 
4198:             .Columns(6).ControlSource = "dbCredito.Numes"
4199:             .Columns(6).Header1.Caption = "No. Oper"
4200:             .Columns(6).Width = 100
4201:             .Columns(6).ReadOnly = .T.
4202:         ENDWITH
4203: 
4204:         *-- Cnt_Docs
4205:         loc_oCns.AddObject("cnt_4c_CreditoDocs", "Container")
4206:         WITH loc_oCns.cnt_4c_CreditoDocs
4207:             .Top       = 230
4208:             .Left      = 545
4209:             .Width     = 185
4210:             .Height    = 40
4211:             .BackStyle = 0
4212:             .Visible   = .T.
4213:         ENDWITH
4214:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_TipoDocto", 1, 11, 53, 15, "Tipo Docto")
4215:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_DataDocto", 1, 97, 25, 15, "Data")
4216:         WITH loc_oCns.cnt_4c_CreditoDocs
4217:             .AddObject("obj_4c_OptDocs", "OptionGroup")
4218:             WITH .obj_4c_OptDocs
4219:                 .Top           = 15
4220:                 .Left          = 5
4221:                 .Width         = 89
4222:                 .Height        = 25
4223:                 .ButtonCount   = 2
4224:                 .BackStyle     = 0
4225:                 .BorderStyle   = 0
4226:                 .ControlSource = "dbCredito.NChkDocs"
4227:                 WITH .Buttons(1)
4228:                     .Caption   = "RG"
4229:                     .Top       = 5
4230:                     .Left      = 5
4231:                     .BackStyle = 0
4232:                     .FontSize  = 8
4233:                 ENDWITH
4234:                 WITH .Buttons(2)
4235:                     .Caption   = "CNH"
4236:                     .Top       = 5
4237:                     .Left      = 45
4238:                     .Height    = 15
4239:                     .BackStyle = 0
4240:                     .FontSize  = 8
4241:                 ENDWITH
4242:                 .Visible = .T.
4243:             ENDWITH
4244: 
4245:             .AddObject("txt_4c_DataDoc", "TextBox")
4246:             WITH .txt_4c_DataDoc
4247:                 .Top           = 14
4248:                 .Left          = 95
4249:                 .Width         = 85
4250:                 .Height        = 23
4251:                 .Value         = {}
4252:                 .ControlSource = "dbCredito.TdDocs"
4253:                 .Visible       = .T.

*-- Linhas 4267 a 4276:
4267: 
4268:         *-- Membro alcancado por NOME: EVALUATE na leitura (regra #15/#34)
4269:         WITH EVALUATE("par_oPagina." + par_cNome)
4270:             .Top         = par_nTop
4271:             .Left        = par_nLeft
4272:             .Width       = par_nWidth
4273:             .Height      = par_nHeight
4274:             .BackStyle   = 0
4275:             .BorderColor = RGB(90, 90, 90)
4276:             .Visible     = .T.

*-- Linhas 4289 a 4307:
4289:         par_oPagina.AddObject(par_cNome, "Label")
4290: 
4291:         WITH EVALUATE("par_oPagina." + par_cNome)
4292:             .Top       = par_nTop
4293:             .Left      = par_nLeft
4294:             .Width     = par_nWidth
4295:             .Height    = par_nHeight
4296:             .AutoSize  = .F.
4297:             .Alignment = 0
4298:             .FontName  = "Tahoma"
4299:             .FontSize  = 8
4300:             .BackStyle = 0
4301:             .ForeColor = RGB(90, 90, 90)
4302:             .Caption   = par_cCaption
4303:             .Visible   = .T.
4304:         ENDWITH
4305:     ENDPROC
4306: 
4307:     *==========================================================================

*-- Linhas 4315 a 4324:
4315:         par_oPagina.AddObject(par_cNome, "TextBox")
4316: 
4317:         WITH EVALUATE("par_oPagina." + par_cNome)
4318:             .Top           = par_nTop
4319:             .Left          = par_nLeft
4320:             .Width         = par_nWidth
4321:             .Height        = par_nHeight
4322:             .FontName      = "Tahoma"
4323:             .FontSize      = 8
4324:             .ReadOnly      = .T.

*-- Linhas 4492 a 4500:
4492:     * 0=1" no legado) - eh o que diz ao usuario que o filtro excluiu tudo.
4493:     * O filtro de grupo (SET KEY) e o de tipos (SET FILTER) sao independentes e
4494:     * convivem, como no legado.
4495:     * PUBLIC: chamado pelos handlers do CheckBox e pelo harness de teste.
4496:     *==========================================================================
4497:     PROCEDURE FiltrarTipos()
4498:         LOCAL loc_cTipos, loc_oAba, loc_oErro
4499: 
4500:         TRY

*-- Linhas 4564 a 4572:
4564:     ENDPROC
4565: 
4566:     *==========================================================================
4567:     * ChkTipoPendMouseDown - Suprime o toggle nativo do CheckBox (NoDefault do
4568:     * MouseDown legado): quem alterna o valor eh o MouseUp/KeyPress.
4569:     *==========================================================================
4570:     PROCEDURE ChkTipoPendMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
4571:         NODEFAULT
4572:     ENDPROC

*-- Linhas 5436 a 5445:
5436:                 *-- Moeda do limite de credito nos dois rotulos "R$" do legado
5437:                 loc_cMoeda = ALLTRIM(loc_oBO.this_cMoedaPadrao)
5438:                 IF !EMPTY(loc_cMoeda)
5439:                     loc_oAba.lbl_4c_MoedaConta.Caption = loc_cMoeda
5440:                     loc_oAba.lbl_4c_MoedaHist.Caption  = loc_cMoeda
5441:                 ENDIF
5442: 
5443:                 loc_oAba.Refresh()
5444:             ENDIF
5445:         CATCH TO loc_oErro

*-- Linhas 5624 a 5632:
5624:                 loc_cNums = ALLTRIM(dbCheqHist.Nums)
5625: 
5626:                 IF !EMPTY(loc_cNums)
5627:                     THIS.Caption = "Hist" + CHR(243) + "rico de Cheques de: " + ;
5628:                         ALLTRIM(loc_oBO.this_cConta) + " - " + ;
5629:                         ALLTRIM(loc_oBO.this_cDescConta) + " / " + ALLTRIM(loc_oBO.this_cCpf)
5630: 
5631:                     loc_oBO.CarregarMovimentoCheque(loc_cNums)
5632: 

*-- Linhas 5675 a 5686:
5675:                 loc_oAba.pgf_4c_Credito.Page1.grd_4c_Credito.Refresh()
5676: 
5677:                 IF VARTYPE(loc_oBO) = "O"
5678:                     loc_oAba.lbl_4c_SituacaoCredito.Caption = ;
5679:                         IIF(EMPTY(loc_oBO.this_cLabelSituacaoCredito), ;
5680:                             "CLIENTE", ALLTRIM(loc_oBO.this_cLabelSituacaoCredito))
5681:                     loc_oAba.lbl_4c_SituacaoCredito.ForeColor = ;
5682:                         IIF(loc_oBO.this_lSituacaoVermelha, RGB(255, 0, 0), RGB(0, 0, 255))
5683:                 ENDIF
5684:             ENDIF
5685:         CATCH TO loc_oErro
5686:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 6127 a 6156:
6127:                 loc_nLeft    = 769
6128: 
6129:                 IF !loc_lCadastro
6130:                     loc_oGrp.Buttons(2).Left = 5
6131:                     loc_oGrp.Buttons(3).Left = 80
6132:                     loc_nLargura = loc_nLargura - 81
6133:                     loc_nLeft    = loc_nLeft + 81
6134:                 ENDIF
6135: 
6136:                 IF !loc_lMovimenta
6137:                     loc_oGrp.Buttons(3).Left = IIF(loc_lCadastro, 80, 5)
6138:                     loc_nLargura = loc_nLargura - 81
6139:                     loc_nLeft    = loc_nLeft + 81
6140:                 ENDIF
6141: 
6142:                 loc_oGrp.Width = loc_nLargura
6143:                 loc_oGrp.Left  = loc_nLeft
6144:             ENDIF
6145: 
6146:             *-- Pagina Resultado
6147:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
6148: 
6149:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Imprime", 5)
6150:                 loc_oPg2.cmd_4c_Imprime.Visible = (loc_lResultado AND loc_lImprimir)
6151:                 loc_oPg2.cmd_4c_Imprime.Enabled = loc_oPg2.cmd_4c_Imprime.Visible
6152:             ENDIF
6153: 
6154:             IF PEMSTATUS(loc_oPg2, "cmg_4c_MudaCli", 5)
6155:                 loc_oPg2.cmg_4c_MudaCli.Visible = ;
6156:                     (loc_lResultado AND loc_lVisaoMov AND loc_lCadastro)

